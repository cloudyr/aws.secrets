# AWS Secrets Managers service

**aws.secrets** is a package for the AWS Secrets Manager service <https://aws.amazon.com/secrets-manager/>.

To use the package, you will need an AWS account and to enter your credentials into R. Your keypair can be generated on the [IAM Management Console](https://aws.amazon.com/) under the heading *Access Keys*. Note that you only have access to your secret key once. After it is generated, you need to save it in a secure location. New keypairs can be generated at any time if yours has been lost, stolen, or forgotten. The [**aws.iam** package](https://github.com/cloudyr/aws.iam) profiles tools for working with IAM, including creating roles, users, groups, and credentials programmatically; it is not needed to *use* IAM credentials.

A detailed description of how credentials can be specified is provided at: https://github.com/cloudyr/aws.signature/. The easiest way is to simply set environment variables on the command line prior to starting R or via an `Renviron.site` or `.Renviron` file, which are used to set environment variables in R during startup (see `? Startup`). They can be also set within R:

```R
Sys.setenv("AWS_ACCESS_KEY_ID" = "mykey",
           "AWS_SECRET_ACCESS_KEY" = "mysecretkey",
           "AWS_DEFAULT_REGION" = "us-east-1",
           "AWS_SESSION_TOKEN" = "mytoken")
```


## Code Examples

The package provides ways of creating and storing "secrets" like passwords. A simple example is the password generation function:

```{r}
library("aws.secrets")
get_random_password()
```

A more useful use case for the package is to use Secrets Manager to store and update passwords that you want to programmatically use in other applications. Rather than hard-coding a password or secret key, you can use Secrets Manager to instead code calls to `get_secret()` and then update the stored secret whenever you want. Thus you have a form of version control for passwords that doesn't require any changes to a running application yet retains security for the password-protected service.

....

## Installation

[![CRAN](https://www.r-pkg.org/badges/version/aws.secrets)](https://cran.r-project.org/package=aws.secrets)
![Downloads](https://cranlogs.r-pkg.org/badges/aws.secrets)
[![Travis Build Status](https://travis-ci.org/cloudyr/aws.secrets.png?branch=master)](https://travis-ci.org/cloudyr/aws.secrets)
[![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/PROJECTNUMBER?svg=true)](https://ci.appveyor.com/project/cloudyr/aws.secrets)
[![codecov.io](https://codecov.io/github/cloudyr/aws.secrets/coverage.svg?branch=master)](https://codecov.io/github/cloudyr/aws.secrets?branch=master)

This package is not yet on CRAN. To install the latest development version you can install from the cloudyr drat repository:

```R
# latest stable version
install.packages("aws.secrets", repos = c(cloudyr = "http://cloudyr.github.io/drat", getOption("repos")))
```

Or, to pull a potentially unstable version directly from GitHub:

```R
if (!require("remotes")) {
    install.packages("remotes")
}
remotes::install_github("cloudyr/aws.secrets")
```


---
[![cloudyr project logo](https://i.imgur.com/JHS98Y7.png)](https://github.com/cloudyr)
