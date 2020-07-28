## Make a map from a Google Sheet

## Load required packages
library(googlesheets4)
library(leaflet)

## In case Google Sheets authorization is enabled, turn it off (we don't need it)
googlesheets4::gs4_deauth()

## Get the ID for the Google Sheet (permission is 'anyone with the link')
scgis_cities_id <- "1wmvQDTr2wTIIsafptWfkh2WO6dUQDwuVcDUSJbMjm20"

## Download the 'Form Responses Geocoded' sheet
cities_geocoded <- googlesheets4::range_read(ss = scgis_cities_id, sheet = "Form Responses Geocoded", range = NULL)

## Create a character vector of HTML code for the pop-up windows
my_popups <- paste0("<b>", cities_geocoded$fname, "</b><br/>City: ", 
                    cities_geocoded$matchAddr, "<br/><br/>Invertebrate most similar to:<br/><b>",
                    cities_geocoded$invertebrate, "</b>")

## Create the leaflet map
cities_lflt <- leaflet(cities_geocoded) %>% 
  addTiles() %>% 
  addCircleMarkers(~lon, ~lat, popup = my_popups)

## Display the leaflet map
print(cities_lflt)

