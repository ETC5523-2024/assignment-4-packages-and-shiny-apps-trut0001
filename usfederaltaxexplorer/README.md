
<!-- README.md is generated from README.Rmd. Please edit that file -->

# US Federal Tax Explorer

<!-- badges: start -->

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Dependencies](https://img.shields.io/badge/dependencies-up%20to%20date-brightgreen.svg)
<!-- badges: end -->

The usfederaltaxexplorer package allows you to explore how your US
federal taxes are allocated across various federal programs. Using the
app, you can input your annual income and marital status, and the app
will estimate your federal taxes and show where those dollars go.

## Installation

You can install the development version of usfederaltaxexplorer from
[GitHub](https://github.com/) with:

``` r
# Install devtools if you don't already have it
# install.packages("devtools")
devtools::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-trut0001/usfederaltaxexplorer")
```

## Use

After installation, load the library and launch the app with:

``` r
library(usfederaltaxexplorer)
usfederaltaxexplorer::run_app()
```

For more detailed instructions, visit the [pkgdown
website](https://etc5523-2024.github.io/assignment-4-packages-and-shiny-apps-trut0001/)
or see the vignette:

``` r
vignette("introduction", package = "usfederaltaxexplorer")
```
