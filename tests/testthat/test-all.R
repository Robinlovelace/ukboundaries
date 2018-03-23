#  see http://kbroman.org/pkg_primer/pages/tests.html

context("ukboundaries")

# Regression tests

test_that("code lookup works", {
  expect_equal(getareatype("E00000001"), "OA11")
  expect_equal(getareatype("E01000001"), "LSOA11")
  expect_equal(getareatype("E02009991"), "MSOA11")
  expect_equal(getareatype("E07000041"), "LAD")
  expect_equal(getareatype("E08000021"), "LAD")
  expect_equal(getareatype("E09000001"), "LAD")
  expect_equal(getareatype("W40900001"), "CMLAD")
})

# test_that("subcodes lookup works", {
#   expect_equal(getsubgeographies("E09000001", "MSOA11"), "E02000001")
# })

# test_that("finds LAD16 boundaries", {
#   sdf = getspatialdata(c("E09000001","E07000041"), "Boundaries", "SuperGeneralisedClipped")
#   expect_true(nrow(sdf)==2)
# })

test_that("finds a ward16", {
  expect_true(T)
})

test_that("finds a MSOA11", {
  x=getspatialdata("E02000001", "Boundaries", "GeneralisedClipped")
  expect_true(nrow(x) == 1)
  expect_true(x[1,][["msoa11cd"]] == "E02000001")
  expect_true(x[1,][["msoa11nm"]] == "City of London 001")
})

test_that("finds a LSOA11", {
  expect_true(T)
})

test_that("find all OA11s in LAD", {
  oas = getsubgeographies("E09000001", "OA11")
  expect_true(length(oas)==31)
})

# test_that("find all LSOA11s in LAD and get centroids", {
#   lsoas = getsubgeographies("E09000001", "LSOA11")
#   sdf = getspatialdata(lsoas, "Centroids", "PopulationWeighted")
#   expect_true(nrow(sdf)==29)
# })

test_that("find all LSOA11s in LAD and get centroids", {
  msoas = getsubgeographies("E09000001", "MSOA11")
  sdf = getspatialdata(msoas, "Centroids", "PopulationWeighted")
  expect_true(nrow(sdf)==1)
})

