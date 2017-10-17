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

.onAttach <- function(libname, pkgname) {
  msg <- paste0 ("Contains National Statistics data © Crown copyright and database right",
                 format(Sys.Date(), "%Y"),
                 "\nContains OS data © Crown copyright and database right",
                 format(Sys.Date(), "%Y"),
                 "\nSee https://www.ons.gov.uk/methodology/geography/licences"
                 )
  packageStartupMessage (msg)
}
