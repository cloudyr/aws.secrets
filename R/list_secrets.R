#' @title List Secrets
#' @description List Secrets
#' @param n An integer specifying a number of secrets to return (for pagination).
#' @param marker A pagination marker.
#' @param \dots Additional arguments passed to \code{\link{secretsHTTP}}.
#' @seealso \code{\link{create_secret}}, \code{\link{create_kms_key}}, \code{\link{delete_kms_key}}
#' @export
list_secrets <-
function(
  n = 100,
  marker = NULL,
  ...
) {
    bod <- list()
    if (!is.null(marker)) {
        bod$Marker <- marker
    }
    if (!is.null(n)) {
        if (n < 1 || n > 10000) {
            stop("'n' must be between 1 and 10000")
        }
        bod$MaxResults <- n
    }
    out <- secretsHTTP(action = "ListSecrets", body = bod, ...)
    return(out$SecretList)
}
