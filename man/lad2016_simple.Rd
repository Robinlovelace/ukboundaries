% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{lad2016_simple}
\alias{lad2016_simple}
\alias{lad2016_simple}
\title{lad boundaries - 2011}
\description{
lad boundaries - 2011

lad boundaries
}
\examples{
\dontrun{
u = "https://census.edina.ac.uk/ukborders/easy_download/prebuilt/shape/England_lad_2011_gen_clipped.zip"
lad2011_simple = duraz(u)
object.size(lad2016_simple) / 1000000 # 1 mb
plot(lad2016_simple)
devtools::use_data(lad2016_simple)
}
\dontrun{
# See http://geoportal1-ons.opendata.arcgis.com/
u = "http://esriuktechnicalsupportopendata-techsupportuk.opendata.arcgis.com/datasets/686603e943f948acaa13fb5d2b0f1275_4.zip"
lad2016_simple = duraz(u)
object.size(lad2016_simple) / 1000000 # 1 mb
plot(lad2016_simple)
devtools::use_data(lad2016_simple)
}
}
