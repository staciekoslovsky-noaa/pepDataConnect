surv_jobss.tbl_detections_processed_rgb <- function(con){
  RPostgreSQL::dbGetQuery(con, "SELECT * FROM surv_jobss.tbl_detections_processed_rgb")
}
