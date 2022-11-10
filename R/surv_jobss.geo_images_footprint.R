surv_jobss.geo_images_footprint <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_jobss.geo_images_footprint")
}
