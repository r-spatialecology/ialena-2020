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

srtm = raster(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))

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



# /End Code/ #


#### Exercise III ####

# 1. Use the `zion` and `srtm2` objects.
# Crop and mask the `srtm2` object to the borders of the `zion` object.

# Your solution

# /Start Code/ #



# /End Code/ #


#### Exercise IV ####

# 1. Create a new map of the Zion National Park using the provided and created objects.
# 2. Save the obtained map to the new file "ZION_YOURNAME.png".

# Your solution

# /Start Code/ #



# /End Code/ #




