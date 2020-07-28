## Required packages from CRAN
pkgs_req <- c("sp", "sf", "tmap", "tmaptools", "leaflet", "ggmap", "maptools", 
              "RColorBrewer", "raster", "maps", "tidyverse",  "jsonlite", 
              "rasterVis", "GISTools", "nngeo", "lwgeom", "devtools", 
              "conflicted", "tigris", "tidycensus", "stars", 
              "googlesheets4", "httr", "rjson")

pkgs_req <- c("sp", "sf", "lidR")

## Install pacman if needed
if (!require(pacman)) install.packages(pacman)
  
## See which ones are missing
(pkgs_missing <- pkgs_req[!(pkgs_req %in% rownames(installed.packages()))])

## Install missing ones
if (length(pkgs_missing)) {
  pacman::p_install(pkgs_missing, character.only = TRUE, force = FALSE, try.bioconductor = FALSE)
}
  
## Re-run the check for missing packages
pkgs_missing <- pkgs_req[!(pkgs_req %in% installed.packages()[,"Package"])]
if (length(pkgs_missing)==0) cat("ALL PACKAGES WERE INSTALLED SUCCESSFULLY \n")


