###########################################################
###########################################################
##########
##########  Project for importing and visualizing data across
##########  sensor systems in the sim center
##########
###########################################################
###########################################################
library(tidyverse)
library(here)
debuggingState(on=FALSE)
Sys.setenv(R_CONFIG_ACTIVE = "mike") # 'default')#
config <- config::get()
source(here('1_funcs.R'), echo = TRUE)


# read in data
tobii_f <- 'IVlineInsertationDemo Metrics.tsv'
tobii_df <- getTobii(here::here(config$data_dir,tobii_f))

bioRadio_f <- 'GM_3_export_2.csv'
bioRadio_df <- getBioRadio(here::here(config$data_dir,bioRadio_f)) |>
  select(-x)

# graph data
tobii_df$breaks <- cut(1:nrow(tobii_df), breaks = ceiling(nrow(tobii_df)/5), labels = FALSE)
tobii_df |>
  group_by(breaks) |>
  summarize(pupil_dm = mean(average_whole_fixation_pupil_diameter, na.rm = TRUE)) |>
  ggplot(aes(x = breaks, y = pupil_dm)) + geom_line() + ggthemes::theme_tufte() + labs(title = "Pupil diameter")

bioRadio_df |>
  select(real_time, ecg) |>
  mutate(t = floor_date(real_time, unit = 'second')) |>
  group_by(t) |>
  summarize(
    ecg = mean(ecg, na.rm = TRUE)
  ) |>
  ggplot(aes(x = t, y = ecg)) + geom_line() + labs(title = 'ECG') + ggthemes::theme_tufte()
  
