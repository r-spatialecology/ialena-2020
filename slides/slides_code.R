library(raster)
elev_data <- raster("data/example_elevation.tif")
elev_data



library(sf)
study_area <- read_sf("data/study_area.gpkg")
head(study_area)





library(sf)
library(raster)
study_area <- read_sf("data/study_area.gpkg")
lc_data <- raster("data/example_landscape.tif") 



plot(lc_data, axes = TRUE)
plot(st_geometry(study_area), add = TRUE)



library(tmap)





tm_shape(study_area) #<<

tm_shape(study_area) +
  tm_borders() #<<

tm_shape(study_area) +
  tm_borders() +
  tm_scale_bar(position = c("right",      #<<
                            "bottom")) +  #<<
  tm_compass(position = c("left", "top")) #<<

tm_shape(study_area) +
  tm_borders() +
  tm_scale_bar(position = c("right",      
                            "bottom")) +  
  tm_compass(position = c("left", "top")) +
  tm_layout(main.title = "Study area") #<<

## tmap_mode("view") #<<
## tm_shape(study_area) +
##   tm_borders() +
##   tm_layout(main.title = "Study area")

## tmap_mode("plot") #<<
## tm_shape(study_area) +
##   tm_borders() +
##   tm_layout(main.title = "Study area")

tm_shape(lc_data) + #<<
  tm_raster()       #<<

tm_shape(lc_data) + 
  tm_raster() +
  tm_layout(legend.outside = TRUE) #<<

tm_shape(lc_data) + 
  tm_raster(drop.levels = TRUE,       #<<
            title = "Land cover:") +  #<<
  tm_layout(legend.outside = TRUE)   

tm_shape(lc_data) + 
  tm_raster(drop.levels = TRUE,       
            title = "Land cover:") +  
  tm_shape(study_area) + #<<
  tm_borders() + #<<
  tm_scale_bar(position = c("right",      #<<
                            "bottom")) +  #<<
  tm_compass(position = c("left", "top")) + #<<
  tm_layout(main.title = "Study area", #<<
            legend.outside = TRUE)  

tm_shape(lc_data) + 
  tm_raster(drop.levels = TRUE,       
            title = "Land cover:") +  
  tm_shape(study_area) +
  tm_borders(lwd = 3, col = "black") +  #<<
  tm_scale_bar(position = c("right",      
                            "bottom")) +  
  tm_compass(position = c("left", "top")) +
  tm_layout(main.title = "Study area",
            legend.outside = TRUE)  

elev_data <- raster("data/example_elevation.tif")

tm_shape(elev_data) +  #<<
  tm_raster()  #<<

tm_shape(elev_data) + 
  tm_raster(style = "cont",  #<<
            title = "Elevation (m asl)") +  #<<
  tm_layout(legend.outside = TRUE)  #<<

tm_shape(elev_data) + 
  tm_raster(style = "cont",
            title = "Elevation (m asl)",
            palette = "-RdYlGn") +  #<<
  tm_layout(legend.outside = TRUE)

# tmaptools::palette_explorer()

## map1 <- tm_shape(elev_data) +
##   tm_raster(style = "cont",
##             title = "Elevation (m asl)",
##             palette = "-RdYlGn") +
##   tm_layout(legend.outside = TRUE)
## 
## tmap_save(map1, "my_first_map.png")  #<<
## 
## tmap_save(map1, "my_first_map.html")  #<<

## lc_data


lc_data_cropped <- crop(lc_data, study_area) #<<


## lc_data


# lc_data_masked <- mask(crop(lc_data, study_area), study_area)
lc_data_masked <- mask(lc_data_cropped, study_area) #<<








st_crs(study_area) #<<

crs(lc_data) #<<

## elev_data



elev_data2 <- projectRaster(elev_data, #<<
                            crs = lc_data, #<< 
                            method = "bilinear") #<<














# install.packages("landscapemetrics")
library(landscapemetrics)
library(dplyr)
lc_data <- raster("data/toy_landscape.tif") 
check_landscape(lc_data)

list_lsm()

lsm_p_area(lc_data)

class_mean <- lsm_c_area_mn(lc_data)
lsm_total <- lsm_l_ta(lc_data)

bind_rows(class_mean, lsm_total)

set.seed(42)

sample(x = c(1, 2, 3), prob = c(0.5, 0.25, 0.25), size = 2500, replace = TRUE) %>%
  matrix(nrow = 50, ncol = 50) %>%
  raster() %>%
  lsm_p_enn() %>% #<<
  filter(value <= quantile(value, probs = 0.25) | value >= quantile(value, probs = 0.75)) %>%
  group_by(class) %>%
  summarise(n = n()) %>%
  arrange(-n)

calculate_lsm(landscape = lc_data, 
              level = "landscape", type = "diversity metric", 
              classes_max = 5)



show_patches(augusta_nlcd, labels = FALSE, class = 42)

## show_cores(augusta_nlcd,
##            labels = FALSE, class = 42)



## show_lsm(augusta_nlcd, labels = FALSE,
##          class = 42, what = "lsm_p_area")





sample_points <- matrix(c(1253709, 1249455, 
                          1261857, 1256055,
                          1252009, 1257055), ncol = 2, byrow = TRUE)

sample_lsm(landscape = augusta_nlcd, y = sample_points, 
           size = 1000, what = "lsm_l_np")



window <- matrix(1, nrow = 5, ncol = 5)
window_result <- window_lsm(lc_data, window = window, what = "lsm_l_np")



adj_raster <- function(x) {
  adjacencies <- adjacent(x,cells = 1:ncell(x))
  table(x[adjacencies[, 1]],x[adjacencies[, 2]])
}
adj_raster(lc_data)

get_adjacencies(lc_data)





citation("landscapemetrics")
