## Chemistry of watersheds from the Luquillo Mountains, Puerto Rico

# Load packages
library(tidyverse)
library(janitor)

# Sourcing the moving average function from different .R script
source(here::here("R", "revised-func-watershed.R"))

# Read data
watersheds <- read_rds(here::here("outputs", "watersheds.rds"))


# Calculating moving average for nitrate_N, potassium, magnesium, calcium, ammonium_N
watersheds_grouping <- watersheds %>%
  group_by(sites) %>% # grouping by the sites
  mutate(nitrate_N = sapply(sample_date, moving_average,
                            dates = sample_date, conc = no3_n, win_size_wks = 9)) %>% #add new column and calculate moving average for nitrate_N
  mutate(potassium = sapply(sample_date, moving_average,
                            dates = sample_date, conc = k, win_size_wks = 9)) %>% #add new column and calculate moving average for potassium
  mutate(magnesium = sapply(sample_date, moving_average,
                            dates = sample_date, conc = mg, win_size_wks = 9)) %>% #add new column and calculate moving average for magnesium
  mutate(calcium = sapply(sample_date, moving_average,
                          dates = sample_date, conc = ca, win_size_wks = 9)) %>% #add new column and calculate moving average for calcium
  mutate(ammonium_N = sapply(sample_date, moving_average,
                             dates = sample_date, conc = nh4_n, win_size_wks = 9)) #add new column and calculate moving average for ammonium_N


# Create a data frame for the ggplot!

watersheds_ma <- watersheds_grouping %>%
  # select columns of interest for reshaping
  select(sites, sample_date, year, nitrate_N, potassium, magnesium, calcium, ammonium_N) %>%
  # reshape table from wide to long
  pivot_longer(cols = c("nitrate_N", "potassium", "magnesium", "calcium", "ammonium_N"),
               names_to = "ion", # give column name for variable
               values_to = "moving_avg_value") %>% # give column name for values
  filter(year >= 1988, year <= 1994) # choose the year of interest for computing

# Intermediate output, data frame for ggplot
saveRDS(watersheds_ma, "outputs/watersheds_ma.rds")

