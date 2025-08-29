## Chemistry of watersheds from the Luquillo Mountains, Puerto Rico


# Load packages
library(tidyverse)
library(janitor)


# Read and clean data

# PRM = Puente Roto Mameyes (PRM)
PRM <- read_csv(here::here("data", "RioMameyesPuenteRoto.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

# Quebrada uno-Bisley (QB1)
QB1 <- read_csv(here::here("data", "QuebradaCuenca1-Bisley.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

# Quebrada dos-Bisley (QB2)
QB2 <- read_csv(here::here("data", "QuebradaCuenca2-Bisley.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

# Quebrada tres-Bisley (QB3)
QB3 <- read_csv(here::here("data", "QuebradaCuenca3-Bisley.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data


# Combine four data sets into one data frame
watersheds_combined <- rbind(PRM, QB1, QB2, QB3)

# Intermediate output, detail list of all datasets
saveRDS(watersheds_combined, "outputs/watersheds_combined.rds")


# Create a new data frame
watersheds <- watersheds_combined %>%
  rename(sites = sample_id) %>%
  #only selecting the column that requires computation
  select(sites, sample_date, no3_n, k, mg, ca, nh4_n) %>%
  #add a new column  and change the sample dates into year for plotting, this is optional
  mutate(year = year(sample_date)) %>%
  #relocating the newly added column next to the sample dates
  relocate(year, .after = sample_date)

# Intermediate output, selected columns for computing moving average
saveRDS(watersheds, "outputs/watersheds.rds")



