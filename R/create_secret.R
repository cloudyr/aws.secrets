#' @rdname secrets
#' @title Create/Retrieve/Update/Delete Secrets
#' @description Create/Retrieve/Update/Delete Secrets
#' @param secret
#' @param delay An integer specifying the deletion delay in days (between 7 and 30)
#' @param \dots Additional arguments passed to \code{\link{secretsHTTP}}.
#' @seealso \code{\link{list_secrets}}, \code{\link{get_secret_value}}
#' @export
create_secret <-
function(
  secret,
  ...
) {
    bod <- list(SecretId = secret)
    out <- secretsHTTP(action = "CreateSecret", body = bod, ...)
    return(out)
}

#' @rdname secrets
#' @export
update_secret <-
function(
  secret,
  ...
) {
    bod <- list(SecretId = secret)
    out <- secretsHTTP(action = "UpdateSecret", body = bod, ...)
    return(out)
}

#' @rdname secrets
#' @export
delete_secret <-
function(
  secret,
  delay = 7,
  ...
) {
    stopifnot(delay >= 7 && delay <= 30)
    bod <- list(SecretId = secret, RecoveryWindowInDays = delay)
    out <- secretsHTTP(action = "DeleteSecret", body = bod, ...)
    return(out)
}

#' @rdname secrets
#' @export
undelete_secret <-
function(
  secret,
  ...
) {
    bod <- list(SecretId = secret)
    out <- secretsHTTP(action = "RestoreSecret", body = bod, ...)
    return(out)
}

#' @rdname secrets
#' @export
get_secret <-
function(
  secret,
  ...
) {
    bod <- list(SecretId = secret)
    out <- secretsHTTP(action = "DescribeSecret", body = bod, ...)
    return(out)
}

#' @rdname secrets
#' @param n An integer specifying a number of secrets to return (for pagination).
#' @param marker A pagination marker.
#' @export
get_secret_versions <-
function(
  secret,
  n = 100,
  marker = NULL,
  ...
) {
    bod <- list(SecretId = secret)
    if (!is.null(marker)) {
        bod$Marker <- marker
    }
    if (!is.null(n)) {
        if (n < 1 || n > 10000) {
            stop("'n' must be between 1 and 10000")
        }
        bod$MaxResults <- n
    }
    out <- secretsHTTP(action = "ListSecretVersionIds", body = bod, ...)
    return(out)
}
