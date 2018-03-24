# ukboundaries.R


#' just get everything
#' @export
getfullspatialdata <- function(area_type, type, subtype) {

  # TODO validate type and subtype

  cachedir = paste0("./cache/", area_type, type, subtype)

  idcolumn = data_sources[data_sources$Type==type & data_sources$Geography==area_type & data_sources$Detail==subtype,]$IdColumn

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

  return(sdf_all)
}

#' for now area codes are assumed to be all the same
#' @export
getspatialdata <- function(area_codes, type, subtype) {

  area_type = getareatype(area_codes)

  # TODO validate type and subtype

  cachedir = paste0("./cache/", area_type, type, subtype)

  idcolumn = data_sources[data_sources$Type==type & data_sources$Geography==area_type & data_sources$Detail==subtype,]$IdColumn

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

  # check id column exists
  if (!idcolumn %in% names(sdf_all)) {
    stop(paste0(idcolumn, " column is not in dataset, check data source definitions"))
  }

  # use [[]] to access parameterised column name
  return(sdf_all[sdf_all[[idcolumn]] %in% area_codes,])
}


#' @export
getsubgeographies <- function(area_code, area_type) {
  uber_type = getareatype(area_code)

  # TODO use %in% for multiples codes
  return(unique(code_lookup[code_lookup[[uber_type]]==area_code,][[area_type]]))
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
  if (grepl("^[E|W]12.*", area_code[1])) {
    return("R")
  }
  # TODO error rather than return empty string?
  return("")
}
