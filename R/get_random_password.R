#' @title Get Random Password
#' @description Get a random password string with specified parameters
#' @param length An integer specifying a password character length between 1 and 4096
#' @param exclusions A character string specifying characters to exclude from the password
#' @param exclude_uppercase A logical specifying whether to exclude upper case characters.
#' @param exclude_lowercase A logical specifying whether to exclude lower case characters.
#' @param exclude_numbers A logical specifying whether to exclude numbers.
#' @param exclude_punctuation A logical specifying whether to exclude punctuation.
#' @param include_space A logical specifying whether to include spaces.
#' @param \dots Additional arguments passed to \code{\link{secretsHTTP}}.
#' @return A character string.
#' @examples
#' \dontrun{
#'   # basic functionality
#'   get_random_password()
#'   
#'   # lowercase alpha-numeric example
#'   get_random_password(exclude_punct = TRUE, exclude_upper = TRUE)
#' }
#' @export
get_random_password <-
function(
  length = 32,
  exclusions = "",
  exclude_uppercase = FALSE,
  exclude_lowercase = FALSE,
  exclude_numbers = FALSE,
  exclude_punctuation = FALSE,
  include_space = FALSE,
  ...
) {
    bod <- list()
    # length
    stopifnot(length >= 1 && length <= 4096)
    bod$PasswordLength <- length
    # excluded characters
    stopifnot(nchar(exclusions) >= 0 && nchar(exclusions) <= 4096)
    bod$ExcludeCharacters <- exclusions
    # other exclusions
    bod$ExcludeLowercase <- exclude_lowercase
    bod$ExcludeUppercase <- exclude_uppercase
    bod$ExcludeNumbers <- exclude_numbers
    bod$ExcludePunctuation <- exclude_punctuation
    bod$IncludeSpace <- include_space
    # execute request
    out <- secretsHTTP(action = "GetRandomPassword", body = bod, ...)
    return(out$RandomPassword)
}
