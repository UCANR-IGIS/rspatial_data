## Copy the latest R Notebooks into the current working directory
nb_url <- "https://github.com/UCANR-IGIS/rspatial_data/raw/master/notebooks.zip"
temp_fn <- tempfile()
download.file(nb_url, destfile=temp_fn, mode="wb")
unzip(temp_fn)
