# ukboundaries.R

#' for now area codes are assumed to be all the same
#' @export
getspatialdata <- function(area_codes, type, subtype) {

  area_type = getareatype(area_codes)

  # TODO validate type and subtype

  cachedir = paste0("./cache/", area_type, type, subtype)

  shapefile = list.files(path=cachedir, pattern="*.shp")
  if (length(shapefile) == 0) {
    # TODO check URL exists
    url=data_sources[data_sources$Type==type & data_sources$Geography==area_type & data_sources$Detail==subtype,]$URL
    print(paste("Downloading and cacheing", cachedir, "from", url))
    if (!dir.exists(cachedir)) {
      dir.create(cachedir)
    }
    zipfile = paste0(cachedir, "/download.zip")
    download.file(url, zipfile)
    unzip(zipfile, exdir=cachedir)
  }
  sdf_all = st_read(paste0(cachedir, "/", shapefile), stringsAsFactors = F)

  # TODO use [[]] to parameterise col name
  return(sdf_all[sdf_all$msoa11cd %in% area_codes,])
}


#' @export
getsubgeographies <- function(area_code, area_type) {
  uber_type = getareatype(area_code)

  # TODO use %in% for multiples codes
  return(unique(code_lookup[code_lookup[[uber_type]]==area_code,][[area_type]]))
  #return(lookup[lookup[[uber_type]]==area_code,])
}

# TODO lookup between different geogs

#' expand types of area code
#' @export
getareatype <- function(area_code) {
  # treat area_code as an array otherwise R moans
  if (grepl("^[E|W]00.*", area_code[1])) {
    return("OA11")
  }
  if (grepl("^[E|W]01.*", area_code[1])) {
    return("LSOA11")
  }
  if (grepl("^[E|W]02.*", area_code[1])) {
    return("MSOA11")
  }
  if (grepl("^[E|W]0[6-9].*", area_code[1])) {
    return("LAD")
  }
  if (grepl("^[E|W]4.*", area_code[1])) {
    return("CMLAD")
  }
  # error
  return("UNKNOWN")
}
