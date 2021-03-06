
<!-- README.md is generated from README.Rmd. Please edit that file -->
ukboundaries
============

[![Travis build status](https://travis-ci.org/robinlovelace/ukboundaries.svg?branch=master)](https://travis-ci.org/robinlovelace/ukboundaries)

The goal of ukboundaries is to ease access to official geographic UK data. As some in the Free and Open Source Software for Geospatial community (FOSS4G) would say: "geo for all"!

This data is provided under the terms of the Open Government Licence. See <https://www.ons.gov.uk/methodology/geography/licences> for further details.

Installation
------------

You can install ukboundaries from github with:

``` r
# install.packages("devtools")
devtools::install_github("robinlovelace/ukboundaries")
```

Data sources
------------

An up-to-date list of data sources - each of which typically corresponds to a geographic object representing boundaries of some type - is kept in the file `inst/extdata/data_sources.csv`. This system file is installed with the package and can be read at any time, e.g. with:

``` r
f = system.file("extdata", "data_sources.csv", package = "ukboundaries")
data_sources = readr::read_csv(f)
```

You can see the contents, e.g. with:

``` r
head(data_sources)
#> # A tibble: 6 x 6
#>   Coverage Geography Type       Detail                  IdColumn URI      
#>   <chr>    <chr>     <chr>      <chr>                   <chr>    <chr>    
#> 1 EW       LAD15     Boundaries FullClipped             lad15cd  https://…
#> 2 GB       LAD16     Boundaries UltraGeneralisedClipped lad16cd  https://…
#> 3 GB       LAD16     Boundaries SuperGeneralisedClipped lad16cd  https://…
#> 4 UK       WD16      Boundaries FullClipped             wd16cd   https://…
#> 5 EW       MSOA11    Centroids  PopulationWeighted      msoa11cd https://…
#> 6 EW       MSOA11    Boundaries SuperGeneralisedClipped msoa11cd https://…
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(ukboundaries)
#> Loading required package: sf
#> Linking to GEOS 3.5.1, GDAL 2.2.2, proj.4 4.9.2
#> Parsed with column specification:
#> cols(
#>   Coverage = col_character(),
#>   Geography = col_character(),
#>   Type = col_character(),
#>   Detail = col_character(),
#>   IdColumn = col_character(),
#>   URI = col_character()
#> )
#> Using default data cache directory ~/.ukboundaries/cache 
#> Use cache_dir() to change it.
#> Contains National Statistics data © Crown copyright and database right2018
#> Contains OS data © Crown copyright and database right, 2018
#> See https://www.ons.gov.uk/methodology/geography/licences
lsoas <- getsubgeographies("E09000001", "LSOA11") # get LSOAs in City of London
spatialdata <- getspatialdata(lsoas, "Boundaries", "GeneralisedClipped") # get shapefile
#> Reading layer `Lower_Layer_Super_Output_Areas_December_2011_Generalised_Clipped__Boundaries_in_England_and_Wales' from data source `/home/robin/.ukboundaries/cache/LSOA11BoundariesGeneralisedClipped/Lower_Layer_Super_Output_Areas_December_2011_Generalised_Clipped__Boundaries_in_England_and_Wales.shp' using driver `ESRI Shapefile'
#> Simple feature collection with 34753 features and 6 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -6.418524 ymin: 49.86474 xmax: 1.762942 ymax: 55.81107
#> epsg (SRID):    4326
#> proj4string:    +proj=longlat +datum=WGS84 +no_defs
plot(spatialdata$geometry)
```

![](README-example-1.png)

``` r
#plot(msoa2011_vsimple)
```
