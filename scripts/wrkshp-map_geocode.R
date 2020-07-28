## This script will geocode the participant location info from Google Form
## https://forms.gle/SAbmxXmMdpihGvkQ9

## This script requires a valid token for the ESRI World Geocoding Service API,
## as well as write permissions for a specific Google Sheet.
## Without those, you'll get errors.

## Load required packages
library(googlesheets4)
library(dplyr)
library(httr)
library(rjson)

## In case Google Sheets authorization is enabled, turn it off (we don't need it)
googlesheets4::gs4_deauth()

## Get the ID for the Google Sheet (permission is 'anyone with the link')
scgis_cities_id <- "1wmvQDTr2wTIIsafptWfkh2WO6dUQDwuVcDUSJbMjm20"

## Download the 'Form Responses' sheet
cities_tbl <- googlesheets4::range_read(ss = scgis_cities_id, sheet = "Form Responses 1", range = NULL) %>% 
  select("fname" = "First name", "city" = "City", "state" = "State / Province", "zip" = "Zip / Postal Code",
         "country" = "Country", "invertebrate" = "What is your favorite invertebrate?")

## Add an ID column that uniquely identifies each row
cities_tbl$ID <- 1:nrow(cities_tbl)

## Grab a token for the ESRI World Geocoding Service. We assume that has been saved as the first
## line of a text file in the R home folder ('My Documents' )

esri_token_fn <- "~/my-google-geocode-api.txt"
f <- file(esri_token_fn, open = "r")
my_esri_token <- readLines(f, n = 1)
close(f)

## Load the script that has the ESRI Geocoding functions
#source("./scripts/geocode_esri.R")
source("./outputs/rspatial_scgis20/docs/scripts/geocode_esri.R")

## Run the geocode_many() function
## Note this will consume some of your ArcGIS.com 'units'
cities_tbl_gc <- geocode_many(cities_tbl$ID, "", cities_tbl$city, cities_tbl$state, cities_tbl$zip, cities_tbl$country, my_esri_token)

## View the results
## View(cities_tbl_gc)

## Merge the geocode results with the survey data
cities_loc_df <- cities_tbl %>% left_join(cities_tbl_gc, by = "ID")

## Inspect results
## View(cities_loc_df)

cat("Saving the geocoded data back to Google Sheets \n")

## Save the merged data back to the Google Sheet (in a different tab)
googlesheets4::gs4_auth(email="andlyons@ucdavis.edu")

## Write the results back to the Google Sheet
sheet_write(cities_loc_df, ss = scgis_cities_id, sheet = "Form Responses Geocoded")

cat("Done! \n")

