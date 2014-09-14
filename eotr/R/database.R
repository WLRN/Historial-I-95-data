connect_db <- function(name = NULL) {
  return(src_postgres(dbname = "eotr",
                      host = "eotr.cthibqmrhtkk.us-east-1.rds.amazonaws.com",
                      port = 5439,
                      user = "statwonk",
                      password = "LxleycMBpRZKhtDtHQc"))
}
