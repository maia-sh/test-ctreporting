# Set files
doc <- latest("dermatillomania_1-12.txt", here("data-raw", "records"))
dir <- here("data")
file_name <- "pubmed"

# Set log
log_file <-
  paste0(dir, "/",
         Sys.Date(),"_",
         file_name,
         if (exists("suffix") && !is.null(suffix)) paste0("_", suffix),
         ".csv"
  )

loggit::set_logfile(log_file)

# Parse single file
start <- Sys.time()
pubmedparser::parse_batch(doc,
            # datatypes = c("table", "abstract", "databanks",
            #               "authors", "mesh", "keywords",
            #               "pubtypes"),
            datatypes = c("keywords", "mesh"),
            file_name = file_name,
            dir = dir,
            subdir = here("data", "tables"),
            return = FALSE)
end <- Sys.time()
runtime_single <- end - start

# Parse multiple files
start <- Sys.time()
pubmedparser::parse_batches(here("data-raw", "records"), datatypes = "keywords", dir = here("data"), subdir = here("data", "tables"))
end <- Sys.time()
runtime_multiple <- end - start
