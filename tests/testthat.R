library("testthat")
library("aws.secrets")

if (Sys.getenv("AWS_ACCESS_KEY_ID") != "") {
    test_check("aws.secrets", filter = "authenticated")
}

test_check("aws.secrets", filter = "public")
