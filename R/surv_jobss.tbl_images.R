surv_jobss.tbl_images <- function(con){
  RPostgreSQL::dbGetQuery(con, "SELECT * FROM surv_jobss.tbl_images")
}
