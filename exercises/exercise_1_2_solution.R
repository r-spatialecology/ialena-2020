##-----------------------------------------------##
##    Author: Jakub Nowosad                      ##
##    Institute of Geoecology and Geoinformation ##
##    Adam Mickiewicz University, Poznan, Poland ##
##    nowosad.jakub@gmail.com                    ##
##    https://nowosad.github.io/                 ##
##-----------------------------------------------##

#### Goals ####

# - Understand the provided datasets
# - Learn how to reproject spatial data
# - Limit your data into an area of interest
# - Create a new map

# We highlighted all parts of the R script in which you are supposed to add your
# own code with: 

# /Start Code/ #

print("Hello World") # This would be your code contribution

# /End Code/ #

#### Required R libraries ####

# We will use the sf, raster, and tmap packages.
# Additionally, we will use the spData and spDataLarge packages that provide new datasets.

library(sf)
library(raster)
library(tmap)
library(spData)
library(spDataLarge)

#### Data sets #### 

# We will use two data sets: `srtm` and `zion`.
# The first one is an elevation raster object for the Zion National Park area, and the second one is an sf object with polygons representing borders of the Zion National Park.

srtm <- raster(system.file("raster/srtm.tif", package = "spDataLarge"))
zion <- read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))

# Additionally, the last exercise will used the masked version of the `lc_data` dataset.

study_area <- read_sf("data/study_area.gpkg")
lc_data <- raster("data/example_landscape.tif")
lc_data_masked <- mask(crop(lc_data, study_area), study_area)

#### Exercise I ####

# 1. Display the `zion` object and view its structure.
# What can you say about the content of this file?
# What type of data does it store? 
# What is the coordinate system used?
# How many attributes does it contain?
# What is its geometry?
# 2. Display the `srtm` object and view its structure.
# What can you say about the content of this file? 
# What type of data does it store?
# What is the coordinate system used? 
# How many attributes does it contain?
# How many dimensions does it have? 
# What is the data resolution?
  
# Your solution (type answer to the questions as code comments and the code used)

# /Start Code/ #

#1
zion
class(zion)
st_crs(zion)
dim(zion)
st_geometry_type(zion)

#2
srtm
class(srtm)
crs(srtm)
nlayers(srtm)
dim(srtm)
res(srtm)

# /End Code/ #

#### Exercise II ####

# 1. Reproject the `srtm` dataset into the coordinate reference system used in the `zion` object. 
# Create a new object `srtm2`
# Vizualize the results using the `plot()` function.
# 2. Reproject the `zion` dataset into the coordinate reference system used in the `srtm` object.
# Create a new object `zion2`
# Vizualize the results using the `plot()` function.


# Your solution

# /Start Code/ #

#1
srtm2 <- projectRaster(srtm, crs = zion)
plot(srtm)
plot(srtm2)

#2
zion2 <- st_transform(zion, crs = st_crs(srtm)$proj4string)
plot(zion)
plot(zion2)

# /End Code/ #


#### Exercise III ####

# 1. Use the `zion` and `srtm2` objects.
# Crop and mask the `srtm2` object to the borders of the `zion` object.
# 2. Try using the `inverse = TRUE` argument in the mask function. 
# What does it do?

# Your solution

# /Start Code/ #

#1
srtm3 <- mask(crop(srtm2, zion), zion)
plot(srtm3)

#2
srtm4 <- mask(crop(srtm2, zion), zion, inverse = TRUE)
plot(srtm4)

# /End Code/ #


#### Exercise IV ####

# 1. Create a new map of the `lc_data_masked` dataset.
# 2. Save the obtained map to a new file "LC_YOURNAME.png".

# Your solution

# /Start Code/ #

my_map = tm_shape(lc_data_masked) + 
  tm_raster(drop.levels = TRUE,       
            title = "Land cover:") +  
  tm_shape(study_area) +
  tm_borders(lwd = 3, col = "black") +
  tm_scale_bar(position = c("RIGHT", "BOTTOM"),
               breaks = c(0, 1, 2),
               text.size = 0.6) +
  tm_compass(position = c("LEFT", "TOP"),
             type = "rose", 
             size = 1) +
  tm_credits(position = c("LEFT", "BOTTOM"),
             text = "Nowosad, 2020",
             size = 0.5) +
  tm_layout(main.title = "Study area",
            legend.outside = TRUE,
            frame = FALSE)

tmap_save(my_map, "LC_NOWOSAD.png")

# /End Code/ #




