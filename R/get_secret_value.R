#' @rdname secret_values
#' @title Get/Put Secret Value
#' @description Get/Put Secret Value
#' @param secret 
#' @param \dots Additional arguments passed to \code{\link{secretsHTTP}}.
#' @seealso \code{\link{list_secrets}}, \code{\link{get_secret_value}}
#' @export
get_secret_value <-
function(
  secret,
  version_id,
  version_stage,
  ...
) {
    bod <- list(SecretId = secret)
    out <- secretsHTTP(action = "GetSecretValue", body = bod, ...)
    return(out)
}

#' @rdname secrets
#' @export
put_secret_value <-
function(
  ...
) {
    bod <- list(SecretId = secret)
    out <- secretsHTTP(action = "PutSecretValue", body = bod, ...)
    return(out)
}
