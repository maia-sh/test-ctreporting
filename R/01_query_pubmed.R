# Set query
query <- 'dermatillomania'
query_name <- query

# Set directory for saving search/pmids, fetch batches, and log
dir <- here("data-raw")

# Set log
log_file <- paste0(dir, "/", Sys.Date(), "_", query_name, "_eutilities.log")
loggit::set_logfile(log_file)

# Run search for query and save pmid's and esearch
records_search <-
  pubmedparser::search_get_pmids(query, file_name = query_name, dir = dir)
# old_records_search <- read_rds(latest(paste(query_name, "_eutilities.log"), dir))
# read_rds(here("data-raw", "hasdatabanklist_og","2020-07-26_esearch_hasdatabanklist.rds"))

# Fetch records for search in batches
pubmedparser::fetch_batches(records_search,
                            # fetch_start = 1,
                            # fetch_end = NULL,
                            batch_size = 12,#10000, #Small batch size for multiple files
                            file_name = query_name,
                            dir =  paste0(dir, "/records")
)

# See logfile
loggit::get_logfile()
loggit::read_logs()

#Error in curl::curl_fetch_memory(url, handle = handle) :
# transfer closed with outstanding read data remaining
