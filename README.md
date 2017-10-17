
<!-- README.md is generated from README.Rmd. Please edit that file -->
ukborders
=========

The goal of ukborders is to ease access to official geographic UK data. As some in the Free and Open Source Software for Geospatial community (FOSS4G) would say: "geo for all"!

This data is provided under the terms of the Open Government Licence. See <https://www.ons.gov.uk/methodology/geography/licences> for further details.

Installation
------------

You can install ukborders from github with:

``` r
# install.packages("devtools")
devtools::install_github("robinlovelace/ukborders")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(ukborders)
#> Loading required package: sf
#> Linking to GEOS 3.5.1, GDAL 2.2.1, proj.4 4.9.2, lwgeom 2.3.3 r15473
#> Contains National Statistics data © Crown copyright and database right2017
#> Contains OS data © Crown copyright and database right2017
#> See https://www.ons.gov.uk/methodology/geography/licences
plot(msoa2011_vsimple)
```

![](README-example-1.png)
