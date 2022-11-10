surv_jobss.tbl_detections_processed_ir <- function(con){
  RPostgreSQL::dbGetQuery(con, "SELECT * FROM surv_jobss.tbl_detections_processed_ir")
}
