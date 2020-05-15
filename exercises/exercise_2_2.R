##-----------------------------------------------##
##    Author: Maximilian H.K. Hesselbarth        ##
##    Department of Ecosystem Modelling          ##
##    University of Goettingen                   ##
##    maximilian.hesselbarth@uni-goettingen.de   ##
##    https://mhesselbarth.rbind.io              ##
##-----------------------------------------------##

#### Goals ####

# - Visualise the landscape and certain characteristics of it
# - Sample metrics within buffers
# - Use moving window
# - Use building blocks to create new metric

# We highlighted all parts of the R script in which you are supposed to add your
# own code with: 

# /Start Code/ #

print("Hello World") # This would be your code contribution

# /End Code/ #

#### Data sets #### 

# We will use three different data sets. They are all part of the landscapemetrics 
# package and you can access them after you installed the package. The data sets 
# are called "landscape", "augusta_nlcd" and "podlasie_ccilc". While the first 
# data set is rather a toy example created using a neutral landscape model, the 
# second two data sets are actual example maps. To get more information, 
# type e.g. ?augusta_nlcd.

# In case you want to import your own data set, you need to import it as a raster
# object using e.g. the raster() function.

#### Required R libraries ####

# We will mainly use the landscapemetrics package. Additionally, we will use the 
# "raster" package and some package from the "tidyverse". In case you miss these 
# packages, please install them using install.packages(pkgs).

library(landscapemetrics)
library(raster)
library(dplyr)

#### Visualise landscape #### 

# There are several functions that aim to help you with the visualisation of the 
# landscape. All visualisation functions start with the prefix show_. The most 
# important is probably show_patches(). The function plots all patches in the 
# landscape. For most landscapes we suggest to set labels = FALSE to turn off 
# labelling the patches with the ID (gets messy quite fast).

show_patches(landscape = landscape, labels = FALSE)

# Have a look at the class argument and try to plot only forest patches of the 
# "augusta_nlcd" data set (forest classes: 41, 42, 43). 

# /Start Code/ #



# /End Code/ #

# It is also possible to show only core cells of each patch using show_cores(). 
# For this, it makes sense not to look at the landscape globally, but at each 
# class separately. The core area is used quite often in ecology because it is 
# assumed to be less disturbed by neighbouring classes and thus to be ecological 
# valuable (e.g. a forest patch surrounded by a city).

show_cores(landscape = landscape, labels = FALSE)

# Try to plot only the core cells of evergreen forest (class 42) using the 
# "augusta_nlc" data set again. Try to increase the edge_depth parameter 
# (e.g. 1, 5, 10) and see how the results change.

# /Start Code/ #



# /End Code/ #

# Lastly, it is also possible to visualise the results of landscape metrics on 
# patch level using show_lsm(). The functions requires to specify what metric(s) 
# should be calculated. The function will visualise the metrics filling each cell 
# based on the result of the corresponding patch metric. 

show_lsm(landscape = landscape, what = "lsm_p_area", labels = FALSE)

# Using the "augusta_nlcd", visualise the value of the core area for each of 
# evergreen forest (class 42).

# /Start Code/ #



# /End Code/ #

#### Sample metrics within buffers #### 

# One common application of landscape metrics is sampling them in certain 
# sub-areas of the overall landscape. For this, landscapemetrics provides the 
# sample_lsm() function. The function can handle a matrix with coordinates of 
# sampling points, sp points or sp polygons. Thereby, all three levels are 
# possible (i.e. patch, class, landscape)

sample_points <- matrix(c(1253709, 1249455, 
                          1261857, 1256055,
                          1252009, 1257055), ncol = 2, byrow = TRUE)

result_sample <- sample_lsm(landscape = augusta_nlcd, y = sample_points, 
                            size = 1000, shape = "square", what = "lsm_l_ta")

# Try to sample the percentage of each class in a circular sample plot with a 
# radius of 2000 m around the sample points. What is the value for evergreen 
# forest (class 42)?

# /Start Code/ #



# /End Code/ #

#### Moving window ####

# The moving window function window_lsm() allows to visualise local variability 
# because for each focal cell the corresponding landscape metric value 
# of the focal window specified by a matrix is calculated. To be type stable, the 
# result will be a nested list, in which the first level corresponds to the number 
# of layers provided and the second level corresponds to the selected metrics.

focal_window <- matrix(1, nrow = 3, ncol = 3)

local_np <- window_lsm(landscape = landscape, window = focal_window, 
                       what = "lsm_l_np")

plot(local_np[[1]]$lsm_l_np)

# Use the "landscape" dataset and try to increase the size of the focal window 
# and have a look at the results. How does the size of the window influence the 
# number of patches?

# /Start Code/ #



# /End Code/ #

#### Building block ####

# landscapemetrics also provides several building blocks to develop new metrics
# or simplify some raster applications. All building blocks start with the prefix
# get_ (e.g. get_patches())

forest_patches <- get_patches(augusta_nlcd, class = c(41, 42, 43))

# Get only all boundary/edge cells of the evergreen forest patches (class 42) of 
# the "augusta_nlcd" dataset. For this, you can use the the second list entry of 
# the previously created "forest_patch" object and the get_boundaries() function. 
# Visualise the result using e.g. the raster plotting function.

# /Start Code/ #



# /End Code/ #
