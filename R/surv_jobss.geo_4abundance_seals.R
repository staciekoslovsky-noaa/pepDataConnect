surv_jobss.geo_4abundance_seals <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_jobss.geo_4abundance_seals")
}
