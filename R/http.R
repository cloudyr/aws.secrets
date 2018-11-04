#' @title Execute AWS Secrets Manager API Request
#' @description This is the workhorse function to execute calls to the Secrets Manager API.
#' @param action A character string specifying the API action to take
#' @param query An optional named list containing query string parameters and their character values.
#' @param headers A list of headers to pass to the HTTP request.
#' @param body A request body
#' @param verbose A logical indicating whether to be verbose. Default is given by \code{options("verbose")}.
#' @param region A character string specifying an AWS region. See \code{\link[aws.signature]{locate_credentials}}.
#' @param key A character string specifying an AWS Access Key. See \code{\link[aws.signature]{locate_credentials}}.
#' @param secret A character string specifying an AWS Secret Key. See \code{\link[aws.signature]{locate_credentials}}.
#' @param session_token Optionally, a character string specifying an AWS temporary Session Token to use in signing a request. See \code{\link[aws.signature]{locate_credentials}}.
#' @param ... Additional arguments passed to \code{\link[httr]{GET}}.
#' @return If successful, a named list. Otherwise, a data structure of class \dQuote{aws-error} containing any error message(s) from AWS and information about the request attempt.
#' @details This function constructs and signs a Secrets Manager API request and returns the results thereof, or relevant debugging information in the case of error.
#' @author Thomas J. Leeper
#' @import httr
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom aws.signature
#' @export
secretsHTTP <- 
function(
  action,
  query = list(),
  headers = list(),
  body = NULL,
  verbose = getOption("verbose", FALSE),
  region = Sys.getenv("AWS_DEFAULT_REGION", "us-east-1"), 
  key = NULL, 
  secret = NULL, 
  session_token = NULL,
  ...
) {
    # locate and validate credentials
    credentials <- aws.signature::locate_credentials(key = key, secret = secret, session_token = session_token, region = region, verbose = verbose)
    key <- credentials[["key"]]
    secret <- credentials[["secret"]]
    session_token <- credentials[["session_token"]]
    region <- credentials[["region"]]
    
    # generate request signature
    d_timestamp <- format(Sys.time(), "%Y%m%dT%H%M%SZ", tz = "UTC")
    url <- paste0("https://secretsmanager.",region,".amazonaws.com")
    Sig <- aws.signature::signature_v4_auth(
           datetime = d_timestamp,
           region = region,
           service = "secretsmanager",
           verb = "POST",
           action = "/",
           query_args = query,
           canonical_headers = list(host = paste0("secretsmanager.",region,".amazonaws.com"),
                                    `x-amz-date` = d_timestamp,
                                    "X-Amz-Target" = paste0("secretsmanager.", action),
                                    "Content-Type" = "application/x-amz-json-1.1"),
           request_body = if (length(body)) jsonlite::toJSON(body, auto_unbox = TRUE) else "",
           key = key, 
           secret = secret,
           session_token = session_token,
           verbose = verbose)
    # setup request headers
    headers[["x-amz-date"]] <- d_timestamp
    headers[["X-Amz-Target"]] <- paste0("secretsmanager.", action)
    headers[["x-amz-content-sha256"]] <- Sig$BodyHash
    headers[["Content-Type"]] <- "application/x-amz-json-1.1"
    headers[["Authorization"]] <- Sig[["SignatureHeader"]]
    if (!is.null(session_token) && session_token != "") {
        headers[["x-amz-security-token"]] <- session_token
    }
    H <- do.call(httr::add_headers, headers)
    
    # execute request
    if (length(query)) {
        r <- httr::POST(url, H, query = query, body = body, encode = "json", ...)
    } else {
        r <- httr::POST(url, H, body = body, encode = "json", ...)
    }
    
    if (httr::http_error(r)) {
        x <- jsonlite::fromJSON(httr::content(r, "text", encoding = "UTF-8"))
        httr::warn_for_status(r)
        h <- httr::headers(r)
        out <- structure(x, headers = h, class = "aws_error")
        attr(out, "request_canonical") <- Sig$CanonicalRequest
        attr(out, "request_string_to_sign") <- Sig$StringToSign
        attr(out, "request_signature") <- Sig$SignatureHeader
    } else {
        out <- try(jsonlite::fromJSON(httr::content(r, "text", encoding = "UTF-8")), silent = TRUE)
        if (inherits(out, "try-error")) {
            out <- structure(httr::content(r, "text", encoding = "UTF-8"), "unknown")
        }
    }
    return(out)
}
