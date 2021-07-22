# https://docs.ropensci.org/rinat/
## install.packages("rinat")
library(rinat)

## Load other packages
library(sf)
library(dplyr)
library(tmap)
library(leaflet)

## Import the YNP Boundary
yose_bnd_ll <- sf::st_read(dsn="./data", layer="yose_boundary")

## Get the bounding box
yose_bnd_bb <- st_bbox(yose_bnd_ll)
as.numeric(yose_bnd_bb)

## Retrieve the first 100 iNaturalist observations within the boudning box
yose_inat_df <- get_inat_obs(bounds = yose_bnd_bb[c(2,1,4,3)])

class(yose_inat_df)
head(yose_inat_df)

## Convert to sf
yose_toads_sf <-  yose_inat_df %>% 
  select(longitude, latitude, datetime, scientific_name, image_url, user_login) %>% 
  st_as_sf(coords=c("longitude", "latitude"),  crs=4326)

## Plot them with tmap
tmap_mode("view")

tm_shape(yose_bnd_ll) + 
  tm_borders(col = "red", lwd = 2) +
tm_shape(yose_toads_sf) + 
  tm_symbols()

## Plot them with leaflet

## Create the map definition with piping syntax

## Add a column containing HTML that will appear in the popup windows
yose_toads_popup_sf <- yose_toads_sf %>% 
  mutate(popup_html = paste0("<p><b>", scientific_name, "</b></p>",
                             "<p>Observed: ", datetime, "<br/>",
                             "User: ", user_login, "</p>",
                             "<p><img src='", image_url, "' style='width:100%;'/></p>")
  )

## See an example of the popup HTML 
yose_toads_popup_sf$popup_html[1]

toad_map <- leaflet(yose_toads_popup_sf) %>% 
  addTiles() %>% 
  addCircleMarkers(popup = ~popup_html, radius = 5)

toad_map

