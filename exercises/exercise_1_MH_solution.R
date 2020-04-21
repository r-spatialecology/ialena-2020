##-----------------------------------------------##
##    Author: Maximilian H.K. Hesselbarth        ##
##    Department of Ecosystem Modelling          ##
##    University of Goettingen                   ##
##    maximilian.hesselbarth@uni-goettingen.de   ##
##    https://mhesselbarth.rbind.io              ##
##-----------------------------------------------##

#### Goals ####

# - Import and preperation of raster data
# - Calculate single landscape metrics
# - Calculate multiple landscape metrics
# - Integrate landscapemetrics into larger workflows

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
# object using the raster() function.

#### Required R libraries ####

# We will mainly use the landscapemetrics package. Additionally, we will use the 
# "raster" package and some package from the "tidyverse". In case you miss these 
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

# For a first impression of the spatial characteristics, use the plotting 
# function to get a first impression.

# /Start Code/ #

plot(landscape)
plot(augusta_nlcd)
plot(podlasie_ccilc)

# /End Code/ #

#### Check if data sets are suitable for landscapemetrics ####

# To check if the data sets fulfill the basic requirements of the landscapemetrics 
# package, you can use the check_landscape() function. Check if all three data 
# sets are suitable for the landscapemetrics package and if not, try to understand 
# why.

# /Start Code/ #

check_landscape(landscape = landscape)
check_landscape(landscape = augusta_nlcd)
check_landscape(landscape = podlasie_ccilc)

# /End Code/ #

#### List all available metrics ####

# landscapemetrics include a function to show you all available metrics and 
# filter them according to the characteristics of the landscape they conceptually 
# describe. For help, have a look at the help page of the ?list_lsm() function.

# To show all metrics, you do not have to specify any argument of the function. 
# However, if you want e.g. only all metrics on patch level, you can specify the 
# "level" argument. Of course, several arguments can be combined.

list_lsm()
list_lsm(level = "patch")

# Try to list all "shape metric" on "class"- and "landscape"-level as well as 
# all "diversity metric" on "landscape"-level. For the diversity metrics, try to 
# return the simplified version, i.e. only a vector of function names.

# /Start Code/ #

list_lsm(level = c("class", "landscape"), type = "shape metric")
list_lsm(level = "landscape", type = "diversity metric", simplify = TRUE)

# /End Code/ #

#### Calculate a single metric ####

# All functions that calculate a single landscape metrics have a similar name 
# structure. The first part of the function name "lsm_" stands for landscape 
# metric. The second part indicates the level, e.g. "lsm_p_" for patch level 
# (correspondingly "_c_" for class- and "_l_" for landscape-level). Lastly, the 
# third part is an abbreviation of the metric, e.g. lsm_p_area().

lsm_p_area(landscape = landscape)

# For the "augusta_nlcd" data set, try to calculate the perimeter-area ratio (para) 
# on patch level. Also, calculate the percentage of landscape of class (pland) and 
# lastly the total edge (te) on landscape level. Save all resulting tibbles in a
# seperated tibble each.

# /Start Code/ #

para_patch <- lsm_p_para(augusta_nlcd)
percentage_class <- lsm_c_pland(augusta_nlcd)
edge_landscape <- lsm_l_te(augusta_nlcd)

# /End Code/ #

# Because the output of all functions that calculate landscape metrics is
# type-stable, it is quite easy to combine several result tibbles. Combine the 
# previously created tibbles into one large result tibble using 
# e.g. dplyr::bind_rows()

# /Start Code/ #

result_tibble <- dplyr::bind_rows(para_patch, percentage_class, edge_landscape)

# /End Code/ #

#### Change parameters of function ####

# Many metrics have additional arguments that can be specified. One example is the
# core area. The function allows to specify, besides others, to set the edge_depth. 
# This is the distance (in cells) a cell has the be away from the patch edge to be 
# considered as core cell. For more information see e.g. ?lsm_p_core()

core_edge_1 <- lsm_l_core_mn(landscape = augusta_nlcd, edge_depth = 1)

# Calculate the mean core area on landscape level for the "augusta_nlcd" data set.
# Try to increase the edge_depth to 3, 5 and 10 and see how the results of the 
# metric change. Later on, we will also look at this visually.

# /Start Code/ #

core_edge_3 <- lsm_l_core_mn(landscape = augusta_nlcd, edge_depth = 3)
core_edge_5 <- lsm_l_core_mn(landscape = augusta_nlcd, edge_depth = 5)
core_edge_10 <- lsm_l_core_mn(landscape = augusta_nlcd, edge_depth = 10)

core_edge_var <- dplyr::bind_rows(edge_1 = core_edge_1, edge_3 = core_edge_3, 
                                  edge_5 = core_edge_5, edge_10 = core_edge_10, 
                                  .id = "id")

# /End Code/ #

#### Calculate multipe metrics at once ###

# Of course, it's also possible to calculate several metrics at once. For this, 
# the function calculate_lsm() can be used. There are several ways to select metrics. 
# The function takes the same arguments as the previously introduced list_lsm()
# function. So, for example it is quite easy to calculate all patch level 
# metrics. To see a progress report, you can set progress = TRUE. However, we 
# strongly recommend not to calculate a large number of metrics ("metric fishing 
# expeditions"; Gustafson 2019), but rather think about which selected metrics 
# are the most meanningful for your research question.

patch_level <- calculate_lsm(landscape = augusta_nlcd, 
                             level = "patch", type = "area and edge metric",
                             progress = TRUE)

# Addtionally, the function can take a vector with function names as "what"
# argument to calculate selected metrics.

multiple_metrics <- calculate_lsm(landscape = augusta_nlcd, 
                                  what = c("lsm_p_area", "lsm_p_para"),
                                  progress = TRUE)

# Calculate all "shape metric"s on class level and addtionally 3 metrics of 
# choice (one from each level) using calculate_lsm (2 seperate function calls). 

# /Start Code/ #

shape_landscape <- calculate_lsm(landscape = augusta_nlcd, 
                                 level = "landscape", type = "shape metric",
                                 progress = TRUE)

multiple_levels <- calculate_lsm(landscape = augusta_nlcd, 
                                 what = c("lsm_p_area", "lsm_c_area_mn", "lsm_l_ta"),
                                 progress = TRUE)

# /End Code/ #

#### Integration into larger workflows ####

# One of the biggest advantages of the packages is its easy integration into larger
# workflows. This can include a pre-processing of the data, calculation of landscape
# metrics, further analyses of the results and plotting of the results - all in
# the same R environment. In the following example, firstly some classes of the 
# "landscape" data set are reclassfied. Next, the patch area, perimeter and the 
# parameter-area ratio are calculated. In the same pipe (%>%-operator) the quantiles
# of the results are calculated, grouped by the land-cover class and 
# the metric. Lastly, a result plot is created using the "ggplot2" package.

reclassification_matrix <- matrix(data = c(0, 2, 1,  2, 3, 2), 
                                  ncol = 3, byrow = TRUE)

landscape_reclass <- raster::reclassify(x = landscape, 
                                        rcl = reclassification_matrix)

lsm_patch <- calculate_lsm(landscape = landscape_reclass, 
                           what = c("lsm_p_area", "lsm_p_perim", "lsm_p_para")) %>% 
  dplyr::group_by(class, metric) %>% 
  dplyr::summarise(min = min(value),
                   low = quantile(value, probs = 0.05), 
                   mean = mean(value), 
                   hi = quantile(value, probs = 0.95),
                   max = max(value)) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(class = factor(class, 
                               levels = c(1,2), 
                               labels = c("Class 1", "Class 2")), 
                metric = factor(metric, 
                                levels = c("area", "perim", "para"), 
                                labels = c("Area", "Perimeter", "Perimeter-Area ratio")))

ggplot(data = lsm_patch) + 
  geom_boxplot(aes(x = class, 
                   min = min, lower = low, 
                   middle = mean, 
                   upper = hi, max = max), stat = "identity", width = 0.1) + 
  facet_wrap(~metric, scales = "free_y") +
  labs(x = "Class", y = "Metric value") + 
  theme_classic()


# Reclassify the "augusta_nlcd" data set into a raster with three classes and 
# plot the resut: 
# - 1: forest (original classes: 41, 42, 43)
# - 2: developed (original classes: 21, 22, 23, 24) 
# - 3: various (all other original classes)

# Calculate the patch area and the perimeter on patch level. Use the patch id of 
# the three largest patch to get the corresponding values of the perimeter for 
# these patches and vice versa (areas of patches with the three largest perim values).

# Lastly create a plot in which the patch area is on the x-axis and the 
# perimeter on the y-axis. Use a simple linear regression model lm(perim ~ area)
# to predict the perimeter for patches with a area of 100, 1000 and 5000 ha. Add
# these predictions and the regression line to the plot.

# /Start Code/ #

augusta_nlcd_rec <- augusta_nlcd

augusta_nlcd_rec[augusta_nlcd_rec %in% c(41, 42, 43)] <- 1
augusta_nlcd_rec[augusta_nlcd_rec %in% c(21, 22, 23, 24)] <- 2
augusta_nlcd_rec[!augusta_nlcd_rec %in% c(1, 2)] <- 3

plot(augusta_nlcd_rec, col = c("#38814E", "#B50000", "#848484"))

patch_area <- lsm_p_area(landscape = augusta_nlcd_rec)
patch_perim <- lsm_p_perim(landscape = augusta_nlcd_rec)

largest_patch <- dplyr::arrange(patch_area, -value) %>% 
  dplyr::top_n(n = 3, wt = value)

dplyr::filter(patch_perim, id %in% largest_patch$id)

largest_perim <- dplyr::arrange(patch_perim, -value) %>% 
  dplyr::top_n(n = 3, wt = value)

dplyr::filter(patch_area, id %in% largest_enn$id)

result_wide <- dplyr::full_join(x = patch_area, patch_perim, 
                                by = c("layer", "level", "class", "id"), 
                                suffix = c(".area", ".perim")) %>% 
  dplyr::select(-metric.area, -metric.perim)

regression_model <- lm(value.perim ~ value.area, data = result_wide)


prediction_result <- tibble::tibble(value.area = c(100, 1000, 5000))

prediction_result$prediction <- predict(object = regression_model,
                                        newdata = prediction_result)

ggplot(data = result_wide) + 
  geom_abline(intercept = regression_model$coefficients[1], 
              slope = regression_model$coefficients[2], 
              linetype = 2) +
  geom_point(aes(x = value.area, y = value.perim, 
                 col = "Observed value"), shape = 19) + 
  geom_point(data = prediction_result, aes(x = value.area, y = prediction, 
                                           col = "Predicted value"), shape = 19) +
  scale_color_manual(name = "", values = c("#DD8D29", "#46ACC8")) +
  labs(x = "Patch area", y = "Patch perimeter") +
  theme_classic()

# /End Code/ #

# In the next exercise, we are going to look at some advanced features of 
# landscapemetrics.
