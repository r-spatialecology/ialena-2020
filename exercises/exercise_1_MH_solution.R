##-----------------------------------------------##
##    Author: Maximilian H.K. Hesselbarth        ##
##    Department of Ecosystem Modelling          ##
##    University of Goettingen                   ##
##    maximilian.hesselbarth@uni-goettingen.de   ##
##    https://mhesselbarth.rbind.io              ##
##-----------------------------------------------##

#### Goals ####

# - Import and preperation raster data
# - Calculate single landscape metrics
# - Calculate multiple landscape metrics
# - Integrate landscapemetrics into larger workflows

# We highlighted all parts of the R script in which you are supposed to add 
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
# object using the raster() function.

#### Required R libraries ####

# We will mainly use the landscapemetrics package. Additionally, we will use the 
# raster package and some package from the tidyverse. In case you miss these 
# packages, please install them using install.packages(pkgs).

library(landscapemetrics)
library(raster)
library(tidyverse)

#### Get a glance a data sets ####

# All data sets are already raster objects. To get a first idea about the data, 
# print the objects on the console.

print(landscape)
print(augusta_nlcd)
print(podlasie_ccilc)

# For a first impression of the spatial characteristics, use the raster plotting 
# function to get a first impression

# /Start Code/ #

plot(landscape)
plot(augusta_nlcd)
plot(podlasie_ccilc)

# /End Code/ #

#### Check if data sets are suitable for landscapemetrics ####

# In order to check if the data sets fulfill the basic requirements of the 
# landscapemetrics package, you can use the check_landscape() function. Check if 
# all three data sets are suitable for the landscapemetrics package and if not, 
# try to understand whiy.

# /Start Code/ #

check_landscape(landscape = landscape)
check_landscape(landscape = augusta_nlcd)
check_landscape(landscape = podlasie_ccilc)

# /End Code/ #

#### List all available metrics ####

# landscapemetrics include a function to show you all available metrics and 
# filter them according to the characteristics of the landscape they conceptually 
# describe. Have a look at the list_lsm() function for help. 

# To show all metrics, you do not have to specify any argument of the function. 
# However, if you want e.g. only all metrics on patch level, you can specify the 
# "level" argument. Of course, several arguments can be combined.

list_lsm()
list_lsm(level = "patch")

# Try to list all "shape metric" on "class"- and "landscape"-level as well as 
# all diversity metrics on landscape level. For the diversity metrics, try to 
# return the simplified version, i.e. only a vector of function names.

# /Start Code/ #

list_lsm(level = c("class", "landscape"), type = "shape metric")
list_lsm(level = "landscape", type = "diversity metric", simplify = TRUE)

# /End Code/ #

#### Calculate a single metric ####

# All functions that calculate a single landscape metrics have a similar name 
# structure. The first part of the function name "lsm_" stands for landscape 
# metric. The second part indicates the level, e.g. "lsm_p_" for patch level 
# (correspondingly "_c_" for class and "_l_" for landscape). Lastly, the third part 
# is an abbriviation of the metric, e.g. "lsm_p_area".

lsm_p_area(landscape = landscape)

# For the "augusta_nlcd" data set, try to calculate the perimeter-area ratio (para) on patch level for the 
# Also, calculate the percentage of landscape of class (pland) and lastly the 
# total edge (te) on landscape level.

# /Start Code/ #

para_patch <- lsm_p_para(augusta_nlcd)
percentage_class <- lsm_c_pland(augusta_nlcd)
edge_landscpae <- lsm_l_te(augusta_nlcd)

# /End Code/ #

#### Ideas/Comments (will be removed for final version) ####
# Add start-end code to presentation
# Change raster and put into stack to show stack functionalitoy for stacks
