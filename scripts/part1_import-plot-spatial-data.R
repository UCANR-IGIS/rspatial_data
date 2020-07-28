## Code Examples from 
## Importing and Basic Plotting of Vector Data
## https://ucanr-igis.github.io/rspatial_scgis20/slides/05_importing-vector.html

library(sf)

## View spatial layers in the data folder
st_layers("./data")

## Import the 'yose_boundary' layer (a Shapefile)
yose_bnd_ll <- st_read(dsn="./data", layer="yose_boundary")

## View the class of the object we just created
class(yose_bnd_ll)

## View the spatial properties of this layer
yose_bnd_ll

## View column names in the attribute table
names(yose_bnd_ll)

## Plot the geometry (outline) of the Yosemite boundary
plot(yose_bnd_ll %>% st_geometry(), asp=1)


## Import KML file
kml_fn <- "./data/yose_historic_pts.kml"
file.exists(kml_fn)

## View the layers in this kml
st_layers(kml_fn)

## Import the 'yosem_historic_places' layer 
yose_hp <- st_read(kml_fn, layer="yose_historic_places")

## View properties
yose_hp

## Plot the boundary
plot(yose_bnd_ll %>% st_geometry(), asp=1)

## Add historic places
plot(yose_hp %>% st_geometry(), add=TRUE)

## Import a Geojson file
counties_fn <- "./data/ca_counties.geojson"
file.exists(counties_fn)

## View the layers 
st_layers(counties_fn)

## Import the 'yosem_historic_places' layer 
ca_counties_ll <- st_read(counties_fn)

## Plot
plot(ca_counties_ll %>% st_geometry(), asp=1, axes=TRUE)

## Define the path to the file geodatabase (a folder)
gdb_fn <- "./data/yose_trails.gdb"
file.exists(gdb_fn)

## View the layers in this source
st_layers(gdb_fn)

## Import the 'Trails' layer  (case sensitive!)
yose_trails <- st_read(gdb_fn, layer="Trails")

## Plot the trails layer
plot(st_geometry(yose_trails), axes=TRUE)

## Import watersheds from a geopackage
gpkg_watershd_fn <- "./data/yose_watersheds.gpkg"
file.exists(gpkg_watershd_fn)
st_layers(gpkg_watershd_fn)
yose_watersheds <- st_read(gpkg_watershd_fn, layer="calw221")

## Plot it
plot(st_geometry(yose_watersheds), axes=TRUE)