#' CAS wards from 2003
#'
#' @name cas2003_vsimple
#' @aliases cas2003 cas2003_simple
#' @examples \dontrun{
#' u_cas_uas = "https://borders.ukdataservice.ac.uk/ukborders/easy_download/prebuilt/shape/England_ua_caswa_2001_clipped.zip"
#' cas2003_uas = duraz(u_cas_uas)
#' plot(cas2003_uas$geometry) # not all of england is covered
#' u_cas_counties = "https://borders.ukdataservice.ac.uk/ukborders/easy_download/prebuilt/shape/England_caswa_2001_clipped.zip"
#' cas2003_counties = duraz(u_cas_counties)
#' plot(cas2003_counties$geometry)
#' # cas2003_simple = rmapshaper::ms_simplify(input = cas2003, keep = 0.05) # mishap with this...
#' cas2003_uas = duraz("england_ua_caswa_2001_clipped.zip")
#' cas2003_counties = duraz("england_caswa_2001_clipped.zip")
#' cas2003 = rbind(cas2003_counties, cas2003_uas)
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
#' }
#'
NULL
#' Download, unzip, read a zipped shapefile (tidy-up by default)
#' @param u character string pointing to a .zip file or an online url
#' @param delete_zip Should any downloaded .zip files be deleted (default is FALSE)?
#' @param rename_zip Should any downloaded .zip files be renames (defulat is TRUE)?
#' @export
duraz = function(u, delete_zip = FALSE, rename_zip = TRUE) {
  if(!grepl(pattern = "http", u)) {
    if(!grepl(pattern = ".zip", x = u)) {
      warning("This does not have a .zip suffix by trying to unzip anyway")
    }
    unzip(u)
  } else {
    if(file.exists("zipped_shapefile.zip")) {
      warning("zipped_shapefile.zip already exists. Not downloading new data.\nYou may want to delete or rename it before proceeding")
    } else {
      download.file(u, destfile = "zipped_shapefile.zip")
    }
    unzip("zipped_shapefile.zip")
  }
  f = list.files(pattern = ".shp")
  if(length(f) > 1) {
    stop("Warning: more than one shapefile downloaded - load them manually")
  }
  res = sf::st_read(f)
 delete_shapefiles()
 if(file.exists("zipped_shapefile.zip")) {
   if(delete_zip) {
     file.remove("zipped_shapefile.zip")
   } else if(rename_zip) {
     file.rename("zipped_shapefile.zip", gsub(pattern = ".shp", replacement = ".zip", f))
   }
 }
 return(res)
}

delete_shapefiles = function(path = ".") {
  f_shp = list.files(path = path, pattern = "*.dbf|*.prj|*.shp|*.shx")
  message(paste0("Removing the following files: ", paste0(f_shp, collapse = " ")))
  file.remove(f_shp)
}
