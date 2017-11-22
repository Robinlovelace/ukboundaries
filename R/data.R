#' CAS wards from 2003
#'
#' @name cas2003_vsimple
#' @aliases cas2003 cas2003_simple
#' @examples \dontrun{
#' u_cas_uas = "https://borders.ukdataservice.ac.uk/ukboundaries/easy_download/prebuilt/shape/England_ua_caswa_2001_clipped.zip"
#' cas2003_uas = duraz(u_cas_uas)
#' plot(cas2003_uas$geometry) # not all of england is covered
#' u_cas_counties = "https://borders.ukdataservice.ac.uk/ukboundaries/easy_download/prebuilt/shape/England_caswa_2001_clipped.zip"
#' cas2003_counties = duraz(u_cas_counties)
#' plot(cas2003_counties$geometry)
#' # cas2003_simple = rmapshaper::ms_simplify(input = cas2003, keep = 0.05) # mishap with this...
#' cas2003_uas = duraz("england_ua_caswa_2001_clipped.zip")
#' cas2003_counties = duraz("england_caswa_2001_clipped.zip")
#' cas2003 = rbind(cas2003_counties, cas2003_uas)
#' cas2003 = st_transform(cas2003, 4326)
#' st_write(cas2003, "cas2003.shp")
#' ms_msg = "mapshaper cas2003.shp -simplify dp 5% -o format=geojson cas2003.json"
#' system.time(system(ms_msg))
#' ms_msg = "mapshaper cas2003.shp -simplify dp 0.5% -o format=geojson cas2003-vsimple.json"
#' system(ms_msg)
#' cas2003_simple = st_read("cas2003.json")
#' cas2003_vsimple = st_read("cas2003-vsimple.json")
#' object.size(cas2003)
#' object.size(cas2003_simple)
#' object.size(cas2003_vsimple)
#' plot(cas2003_vsimple$geometry)
#' mapview::mapview(cas2003_vsimple)
#' devtools::use_data(cas2003_simple, overwrite = TRUE)
#' delete_shapefiles()
#' }
NULL
#' MSOA boundaries
#'
#' @name msoa2011_vsimple
#' @aliases msoa2011
#' @examples \dontrun{
#' # See http://geoportal1-ons.opendata.arcgis.com/datasets/middle-layer-super-output-areas-december-2011-super-generalised-clipped-boundaries-in-england-and-wales
#' u = "https://opendata.arcgis.com/datasets/826dc85fb600440889480f4d9dbb1a24_3.zip?outSR=%7B%22wkid%22%3A27700%2C%22latestWkid%22%3A27700%7D"
#' msoa2011_vsimple = duraz(u)
#' plot(msoa2011_vsimple$geometry)
#' devtools::use_data(msoa2011_vsimple)
#' }
NULL
#' LSOA boundaries
#'
#' @name lsoa2011_simple
#' @aliases msoa2011
#' @examples \dontrun{
#' # See http://geoportal1-ons.opendata.arcgis.com/
#' u = "https://opendata.arcgis.com/datasets/da831f80764346889837c72508f046fa_2.zip?outSR=%7B%22wkid%22%3A27700%2C%22latestWkid%22%3A27700%7D"
#' lsoa2011 = duraz(u)
#' object.size(lsoa2011) / 1000000 # 63 mb
#' lsoa2011_simple = stplanr::mapshape(lsoa2011, percent = 20)
#' object.size(lsoa2011_simple) / 1e6 # 40 mb
#' plot(lsoa2011$geometry[1:3])
#' plot(lsoa2011_simple$geometry[1:3], add = TRUE)
#' devtools::use_data(lsoa2011_simple)
#' }
NULL
