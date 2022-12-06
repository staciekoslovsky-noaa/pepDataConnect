##### TABLES #####

# surv_pv_cst.archive_poly_counts_2003 --------------------------------------------------------------------------------
# surv_pv_cst.archive_poly_counts_9697 --------------------------------------------------------------------------------
# surv_pv_cst.archive_poly_counts_9802 --------------------------------------------------------------------------------
# surv_pv_cst.archive_poly_counts_adfg --------------------------------------------------------------------------------
# surv_pv_cst.archive_poly_counts_iliamna --------------------------------------------------------------------------------
# surv_pv_cst.archive_poly_counts_pribs --------------------------------------------------------------------------------
# surv_pv_cst.archive_poly_effort --------------------------------------------------------------------------------
# surv_pv_cst.geo_haulout_all --------------------------------------------------------------------------------
# surv_pv_cst.geo_image_count --------------------------------------------------------------------------------

# surv_pv_cst.geo_polys --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: geo_polys
#'
#' @description
#' Return all records from surv_pv_cst.geo_polys as an sp object
#'
#' @details
#' This function returns all the survey unit polygons available to be flown during coastal harbor seal surveys.
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each polygon
#'   \item polyid - unique alpha-numeric identifier for each survey unit
#'   \item stockid - integer identifier for the stock in which the survey unit falls
#'   \item stockname - name of the stock in which the survey unit falls
#'   \item station - name of the tidal station for which tidal covariates are calculated
#'   \item distance_km - distance from the tidal station
#'   \item iliamna - denotes if the polyid is located at Iliamna Lake (Y)
#'   \item glacier_name - denotes the glacial within the polygon that is surveyed for glacial harbor seal surveys
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item id - for joining to other tables based on poly_id
#'   \item polyid
#'   \item stockid
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.geo_polys table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.geo_polys(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.geo_polys <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_pv_cst.geo_polys")
}

# surv_pv_cst.geo_tidal_stations --------------------------------------------------------------------------------

# surv_pv_cst.geo_track_lines --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: geo_track_lines
#'
#' @description
#' Return all records from surv_pv_cst.geo_track_lines as an sp object
#'
#' @details
#' This function returns all the available tracklines from coastal harbor seal surveys (with the tracks represented as a single line record per flight).
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each trackline
#'   \item trackid - unique identifier for each flight
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item trackid
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.geo_track_lines table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.geo_track_lines(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.geo_track_lines <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_pv_cst.geo_track_lines")
}

# surv_pv_cst.geo_track_pts --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: geo_track_pts
#'
#' @description
#' Return all records from surv_pv_cst.geo_track_pts as an sp object and processed to provide date/times in GMT
#'
#' @details
#' This function returns all the available tracklines from coastal harbor seal surveys (with the tracks represented all GPS points records during each flight).
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each record
#'   \item gpx_file - originating file for the GPS data
#'   \item trackid - unique identifier for each flight
#'   \item segmentid - unique identifier for each record within the flight
#'   \item gps_dt - date/time of the GPS location; data are presented in GMT
#'   \item latitude - latitude for the GPS location
#'   \item longitude - longitude for the GPS location
#'   \item altitude - altitude for the GPS location
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item trackid
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.geo_track_pts table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.geo_track_pts(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.geo_track_pts <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_pv_cst.geo_track_pts") %>%
    mutate(gps_dt = lubridate::with_tz(gps_dt, tz = "UTC"))
}

# surv_pv_cst.res_abundance_201902 --------------------------------------------------------------------------------

# surv_pv_cst.res_abundance_201902_bystock --------------------------------------------------------------------------------

# surv_pv_cst.tbl_effort --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: tbl_effort
#'
#' @description
#' Return all records from surv_pv_cst.tbl_effort as an sp object and processed to provide look-up values (instead of codes) and date/times in GMT
#'
#' @details
#' This function returns all effort records from 2004 to present.
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each record
#'   \item trackid - unique identifier for each flight
#'   \item survey_date - date of survey (in GMT)
#'   \item photographer - initials of the person who took photos during the survey
#'   \item polyid - unique alpha-numeric identifier for each survey unit
#'   \item effort_type - designates the type of effort under which the survey unit was flown
#'   \item effort_comments - any additional comments regarding survey effort in the survey unit
#'   \item num_disturbed - number of harbor seals disturbed during the survey effort
#'   \item ssl_disturbed - number of Steller sea lions disturbed during the survey effort (recorded starting in 2022)
#'   \item track_rep - the survey repetition number for the survey unit (1 if the first pass, 2 if the second pass, etc.)
#'   \item survey_dt - the survey date/time (in GMT) assigned to the survey unit based on href{https://github.com/StacieKozHardy/CoastalPv_DataManagement/blob/main/CoastalPv_04b_CalculateSurveyDTinEffort.R}{this code}
#'   \item survey_dt_source - designates how the survey date/time was generated
#'   \item tide_height - the tidal height based on the survey_dt and the tidal station assigned to that survey unit; calculated using href{https://github.com/StacieKozHardy/CoastalPv_DataManagement/blob/main/CoastalPv_04c_CalculateTideCovariates.R}{this code}
#'   \item nearest_high_dt - the date/time of the nearest high tide to the survey
#'   \item nearest_high_height - the tidal height of the nearest high tide to the survey
#'   \item nearest_low_dt - the date/time of the nearest low tide to the survey
#'   \item nearest_high_height - the tidal height of the nearest low tide to the survey
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item trackid, track_rep
#'   \item polyid
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.tbl_effort table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.tbl_effort(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.tbl_effort <- function(con){
  sf::st_read(con, query = "SELECT id, trackid, survey_date, photographer, polyid, effort_type, effort_comments,
              num_disturbed, ssl_disturbed, track_rep, survey_dt, survey_dt_source, tide_height, nearest_high_dt, nearest_high_height,
              nearest_low_dt, nearest_low_height, geom
              FROM surv_pv_cst.tbl_effort
              LEFT JOIN surv_pv_cst.lku_effort_type USING (effort_type_lku)") %>%
    mutate(survey_dt = lubridate::with_tz(survey_dt, tz = "UTC"),
           nearest_high_dt = lubridate::with_tz(nearest_high_dt, tz = "UTC"),
           nearest_low_dt = lubridate::with_tz(nearest_low_dt, tz = "UTC"))
}

# surv_pv_cst.tbl_image_exif --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: tbl_image_exif
#'
#' @description
#' Return all records from surv_pv_cst.tbl_image_exif as an sp object and processed to provide look-up values (instead of codes) and date/times in GMT
#'
#' @details
#' This function returns all image information from 2004 to present.
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each record
#'   \item source_file - image name and network path
#'   \item exif_extract_dt - date/time when the exif data were extracted (in GMT)
#'   \item image_name - name of the image
#'   \item photog_date_id - initials and date of image photographer
#'   \item original_dt - date/time when the image was taken based on camera (in GMT)
#'   \item camera_make - camera make from image exif
#'   \item camera_model - camera model from image exif
#'   \item lens_speces - lens information from image exif
#'   \item exposure_time_sec - exposure time from image exif
#'   \item f_stop - F-stop value from image_exif
#'   \item focal_length - focal length from image_exif
#'   \item iso - ISO from image exif
#'   \item quality - quality from image exif
#'   \item white_balance - white balance from image exif
#'   \item sharpness - sharpness from image exif
#'   \item focus_mode - focus mode from image exif
#'   \item image_width_pix - image width from image exif
#'   \item image_height_pix - image height from image exif
#'   \item gps_dt - date/time when the image was taken based on GPS (in GMT)
#'   \item latitude - latitude where image was taken
#'   \item longitude - longitude where image was taken
#'   \item altitude - altitude of aircraft when image was taken
#'   \item gps_satellites - number of GPS satellites
#'   \item polyid - unique alpha-numeric identifier for each survey unit; XXX if image was not used for counting
#'   \item interpolated - indicates if the location data were interpolated
#'   \item use_for_count - indicates if the image was used for counting
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item photog_date_id - can match to track_id, as well
#'   \item image_name
#'   \item polyid
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.tbl_image_exif table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.tbl_image_exif(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.tbl_image_exif <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_pv_cst.tbl_image_exif
              LEFT JOIN surv_pv_cst.lku_interpolated USING (interpolated_lku)
              LEFT JOIN surv_pv_cst.lku_use_for_count USING (use_for_count_lku)") %>%
    mutate(exif_extract_dt = lubridate::with_tz(exif_extract_dt, tz = "UTC"),
           original_dt = lubridate::with_tz(original_dt, tz = "UTC"),
           gps_dt = lubridate::with_tz(gps_dt, tz = "UTC")) %>%
    select(-interpolated_lku, -use_for_count_lku)
}

# surv_pv_cst.tbl_track --------------------------------------------------------------------------------

##### QUERIES #####

# surv_pv_cst.geo_abundance_4agol --------------------------------------------------------------------------------
# surv_pv_cst.geo_abundance_4shiny --------------------------------------------------------------------------------
# surv_pv_cst.geo_haulout_current --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_201706 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_201708 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_201808 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_201809 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_201906 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_201908 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_202108 --------------------------------------------------------------------------------
# surv_pv_cst.geo_priorities_202208 --------------------------------------------------------------------------------

# surv_pv_cst.summ_count_by_image --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: summ_count_by_image
#'
#' @description
#' Return all records from surv_pv_cst.summ_count_by_image as an sp object and processed to provide date/times in GMT
#'
#' @details
#' This function returns all counts for each image that has been counted in the database.
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each record
#'   \item trackid - unique identifier for each flight
#'   \item image_name - name of the image
#'   \item polyid - unique alpha-numeric identifier for each survey unit
#'   \item non_pup - total number of non-pup harbor seals counted on the image
#'   \item pup - total number of pup harbor seals counted on the image
#'   \item aux - total number of harbor seals counted off-frame in the vicinity of that image
#'   \item total - total number of harbor seals (non-pup, pup and off-frame) counted on the
#'   \item survey_date - date of survey (in GMT)
#'   \item track_rep - the survey repetition number for the survey unit (1 if the first pass, 2 if the second pass, etc.)
#'   \item gps_dt - date/time when the image was taken based on GPS (in GMT)
#'   \item count_compromised - indicates if there were any issues with the image that resulted in the count at that location being compromised
#'   \item photog_date_id - initials and date of image photographer
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item trackid, track_rep
#'   \item photog_date_id - can match to track_id, as well
#'   \item image_name
#'   \item polyid
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.summ_count_by_image table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.summ_count_by_image(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.summ_count_by_image <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_pv_cst.summ_count_by_image") %>%
    mutate(survey_date = lubridate::with_tz(survey_date, tz = "UTC"),
           gps_dt = lubridate::with_tz(gps_dt, tz = "UTC"))
}

# surv_pv_cst.summ_count_by_image_iliamna --------------------------------------------------------------------------------

# surv_pv_cst.summ_count_by_polyid --------------------------------------------------------------------------------
#' Get Coastal harbor seal data: summ_count_by_polyid
#'
#' @description
#' Return all records from surv_pv_cst.summ_count_by_polyid as an sp object and processed to provide date/times in GMT
#'
#' @details
#' This function returns all counts for each image that has been counted in the database.
#'
#' The fields in this table are as follows:
#' \itemize{
#'   \item id - unique integer identifier for each record
#'   \item trackid - unique identifier for each flight
#'   \item track_rep - the survey repetition number for the survey unit (1 if the first pass, 2 if the second pass, etc.)
#'   \item polyid - unique alpha-numeric identifier for each survey unit
#'   \item non_pup - total number of non-pup harbor seals counted on the image
#'   \item pup - total number of pup harbor seals counted on the image
#'   \item count_compromised - indicates if there were any issues with the image that resulted in the count at that location being compromised
#'   \item effort_type - designates the type of effort under which the survey unit was flown
#'   \item survey_dt - the survey date/time (in GMT) assigned to the survey unit based on href{https://github.com/StacieKozHardy/CoastalPv_DataManagement/blob/main/CoastalPv_04b_CalculateSurveyDTinEffort.R}{this code}
#'   \item tide_height - the tidal height based on the survey_dt and the tidal station assigned to that survey unit; calculated using href{https://github.com/StacieKozHardy/CoastalPv_DataManagement/blob/main/CoastalPv_04c_CalculateTideCovariates.R}{this code}
#'   \item nearest_high_dt - the date/time of the nearest high tide to the survey
#'   \item nearest_high_height - the tidal height of the nearest high tide to the survey
#'   \item nearest_low_dt - the date/time of the nearest low tide to the survey
#'   \item nearest_high_height - the tidal height of the nearest low tide to the survey
#' }
#'
#' The data in this table relate to other coastal harbor seal survey data based on the following fields:
#' \itemize{
#'   \item trackid, track_rep
#'   \item polyid, track_rep
#' }
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return A sp object containing all records in the surv_pv_cst.summ_count_by_polyid table.
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Get data and do a lot of cool stuff here
#' data <- surv_pv_cst.summ_count_by_polyid(con)
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)

surv_pv_cst.summ_count_by_polyid <- function(con){
  sf::st_read(con, query = "SELECT * FROM surv_pv_cst.summ_count_by_polyid") %>%
    mutate(survey_dt = lubridate::with_tz(survey_dt, tz = "UTC"),
           nearest_high_dt = lubridate::with_tz(nearest_high_dt, tz = "UTC"),
           nearest_low_dt = lubridate::with_tz(nearest_low_dt, tz = "UTC"))
}


# surv_pv_cst.summ_count_by_polyid_4analysis --------------------------------------------------------------------------------
# surv_pv_cst.summ_count_by_polyid_iliamna --------------------------------------------------------------------------------
# surv_pv_cst.summ_count_by_survey_iliamna_4analysis --------------------------------------------------------------------------------
# surv_pv_cst.summ_count_by_survey_iliamna_all --------------------------------------------------------------------------------

