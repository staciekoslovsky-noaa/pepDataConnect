# pep_connect --------------------------------------------------------------------------------
#' Connect to PEP PostgreSQL database
#'
#' @description
#' Connect to PEP PostgreSQL database
#'
#' @details
#' Uses the .Renviron file stored in your Documents folder to connect to the database.
#'
#' Please see the ReadMe file for this package (https://github.com/StacieKozHardy/pepDataConnect) or contact Stacie Hardy for help in getting your work environment set up properly.
#'
#' @return A connection to the PEP PostgreSQL database
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Do a lot of cool stuff here
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)
#'
#' @seealso
#' \code{\link{pep_disconnect}}
#'
#' @references
#' \url{https://github.com/StacieKozHardy/pepDataConnect}
pep_connect <- function() {
  DBI::dbConnect(RPostgreSQL::PostgreSQL(),
                         dbname = Sys.getenv("pep_db"),
                         host = Sys.getenv("pep_ip"),
                         user = Sys.getenv("pep_user"),
                         password = Sys.getenv("user_pw"))
}


# pep_disconnect --------------------------------------------------------------------------------
#' Disconnect from the PEP PostgreSQL database
#'
#' @description
#' Disconnect from the PEP PostgreSQL database
#'
#' @details
#' Closes an existing connection to the PEP PostgreSQL database. This is important to do at the end of a working session or R script,
#' because there is a limit to how many open connections you can have to the database at one time.
#'
#' @param con A connection string to the PEP PostgreSQL database
#'
#' @return nothing :)
#' @export
#'
#' @examples
#' # Connect to PEP database
#' con <- pep_connect()
#'
#' # Do a lot of cool stuff here
#'
#' # When you're done, disconnect from the database
#' pep_disconnect(con)
#'
#' @seealso
#' \code{\link{pep_connect}}
#'
pep_disconnect <- function(con) {
  DBI::dbDisconnect(con)
  rm(con)
}
