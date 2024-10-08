###########################################################
###########################################################
##########
##########  Project functions
##########
###########################################################
###########################################################

getTobii <- function(f) {
  df <- read.csv(f,sep = '\t') |>
    janitor::clean_names() |>
    filter(participant == 'GM_3') |>
    select(bin,ends_with(c("_starts","_diameter")))
}

getBioRadio <- function(f) {
  df <- read.csv(f) |>
    janitor::clean_names() |>
    mutate(real_time = lubridate::ymd_hms(real_time))
}
