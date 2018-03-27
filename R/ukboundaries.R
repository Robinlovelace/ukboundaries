# ukboundaries.R

.onLoad <- function(libname, pkgname)
{
  # TODO user-customised data sources...

  # TODO sort out package data properly - needs to be
  # - human readable (i.e. csv) and
  # - not have the frankly f**king idiotic stringsAsFactors

  # need some way of optionally loading the data
  #custom_data_sources=default_data_sources[default_data_sources$Geography=="invalid",]

  #all_data_sources=rbind(custom_data_sources, default_data_sources)
  #data(default_data_sources, custom_data_sources, census11_codes)
  census11_codes <<- read.csv("./data/census11_codes.csv", sep=";", stringsAsFactors = F)

  # load in source data, custom first
  data_sources <<- read.csv("./data/custom_data_sources.csv", sep=";", stringsAsFactors = F)
  data_sources <<- rbind(data_sources, read.csv("./data/default_data_sources.csv", sep=";", stringsAsFactors = F))
}


#' add custom data source
#' @export
add_datasource <- function(coverage, geography, type, detail, idcolumn, uri) {
  custom = read.csv("./data/custom_data_sources.csv", sep=";", stringsAsFactors = F)
  # TODO some validation of inputs?
  # cols are: "Coverage"  "Geography" "Type"      "Detail"    "IdColumn"  "URI"
  custom[nrow(custom)+1,] = list(coverage, geography, type, detail, idcolumn, uri)
  write.table(custom, "./data/custom_data_sources.csv", sep=";", row.names = F)
  # TODO find a way of not having to reload...
  print("Reload package to update source database")
}

#' just get everything
#' @export
getfullspatialdata <- function(area_type, type, subtype) {

  # TODO validate type and subtype

  uri=data_sources[data_sources$Type==type & data_sources$Geography==area_type & data_sources$Detail==subtype,]$URI

  # treat as file is URI doesnt begin with http:// or https://
  if (!grepl("^http[s]?://", uri)) {
    stopifnot(file.exists(uri), "local (custom) shapefile not found")
    shapefile = uri
  } else {
    cachedir = paste0("./cache/", area_type, type, subtype)
    shapefile = paste0(cachedir, "/", list.files(path=cachedir, pattern="*.shp"))

    if (length(shapefile) == 0) {
      # TODO check URL exists
      print(paste("Downloading and cacheing", cachedir, "from", uri))
      if (!dir.exists(cachedir)) {
        dir.create(cachedir)
      }
      zipfile = paste0(cachedir, "/download.zip")
      download.file(uri, zipfile)
      unzip(zipfile, exdir=cachedir)
    }
  }
  sdf_all = st_read(shapefile, stringsAsFactors = F)

  return(sdf_all)
}

#' for now area codes are assumed to be all the same
#' @export
getspatialdata <- function(area_codes, type, subtype) {

  area_type = getareatype(area_codes)
  sdf_all = getfullspatialdata(area_type, type, subtype)

  idcolumn = data_sources[data_sources$Type==type & data_sources$Geography==area_type & data_sources$Detail==subtype,]$IdColumn
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

  # TODO non-census codes
  # TODO use %in% for multiples codes
  return(unique(census11_codes[census11_codes[[uber_type]]==area_code,][[area_type]]))
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
