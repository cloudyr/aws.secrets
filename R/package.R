#' @name aws.secrets-package
#' @title aws.secrets
#' @aliases aws.secrets-package aws.secrets
#' @docType package
#' @description AWS Secrets Manager Client
#' @details This is a client for the AWS Secrets Manager, a service that allows users to securely store \dQuote{secrets} (passwords, API keys, etc.) in the AWS cloud, programmatically retrieve those secrets in applications using the API (i.e., via this package) while logging uses of the secrets, and then rotate the secrets themselves without changing any application software because the secrets are retrieved dynamically rather than being hardcoded.
#' @references
#' \url{https://aws.amazon.com/secrets-manager/}
#' \url{https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html}
#' @author Thomas J. Leeper <thosjleeper@gmail.com>
#' @seealso \code{\link{create_secret}}, \code{\link{list_secrets}}, \code{\link{get_random_password}}
#' @keywords package 
NULL
