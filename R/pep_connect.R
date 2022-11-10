pep_connect <- function() {
  DBI::dbConnect(RPostgreSQL::PostgreSQL(),
                         dbname = Sys.getenv("pep_db"),
                         host = Sys.getenv("pep_ip"),
                         user = Sys.getenv("pep_user"),
                         password = Sys.getenv("user_pw"))
}
