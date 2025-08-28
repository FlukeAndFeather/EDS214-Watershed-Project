Concentration calculation of Potassium, Nitrate, Magnesium, Calcium and Ammonium in four watersheds of Puerto Rico.

## Load packages


library(tidyverse)
library(janitor)
library(zoo)

## Read and clean data

PRM <- read_csv(here::here("data", "RioMameyesPuenteRoto.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

QB1 <- read_csv(here::here("data", "QuebradaCuenca1-Bisley.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

QB2 <- read_csv(here::here("data", "QuebradaCuenca2-Bisley.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

QB3 <- read_csv(here::here("data", "QuebradaCuenca3-Bisley.csv"),
                na = c(" ", "NA")) %>%
  clean_names() #clean data

## Joining four data sets into one dataframe

watersheds_joined <- rbind(PRM, QB1, QB2, QB3)

## Create a new dataframe

watersheds <- watersheds_joined %>%
  #only selecting the column that requires computation
  select(sample_id, sample_date, no3_n, k, mg, ca, nh4_n) %>%
  #add a new column  and change the sample dates into year for plotting
  mutate(year = year(sample_date)) %>%
  #reclocating the newly added column next to the sample dates
  relocate(year, .after = sample_date)

## Sourcing the function from different .R script

source(here::here("R", "revised-func-watershed.R"))

## Calculating rolling mean for each parameters

watersheds$no3_n_ma <- sapply(
  watersheds$sample_date,
  moving_average,
  dates = watersheds$sample_date,
  conc = watersheds$no3_n,
  win_size_wks = 9
)


watersheds$k_ma <- sapply(
  watersheds$sample_date,
  moving_average,
  dates = watersheds$sample_date,
  conc = watersheds$k,
  win_size_wks = 9
)


watersheds$mg_ma <- sapply(
  watersheds$sample_date,
  moving_average,
  dates = watersheds$sample_date,
  conc = watersheds$mg,
  win_size_wks = 9
)


watersheds$ca_ma <- sapply(
  watersheds$sample_date,
  moving_average,
  dates = watersheds$sample_date,
  conc = watersheds$ca,
  win_size_wks = 9
)


watersheds$nh4_n_ma <- sapply(
  watersheds$sample_date,
  moving_average,
  dates = watersheds$sample_date,
  conc = watersheds$nh4_n,
  win_size_wks = 9
)

#This code is working and is optional

# watershed_ma <- watersheds %>%
#   mutate(sample_date = as.Date(sample_date))
# 
# watershed_ma_final <- watershed_ma %>%
#   group_by(sample_id) %>%
#   arrange(sample_date) %>%
#   mutate(no3_n_ma63 = rollapply(data = no3_n,
#                                 width = 63,
#                                 FUN = mean,
#                                 align = "left",
#                                 fill = NA,
#                                 na.rm = TRUE)) %>%
#   ungroup()


# #this is alternative
# roll_mean <- df_join_working %>%
#   group_by(sample_id) %>%
#   mutate(rollmean_no3 = rollmean(x = no3_n, k = 9, fill = NA, align = "left")) %>%
#   ungroup() # optional code
# 
# #arrange(sample_date) %>% 

watersheds_cleaned <- watersheds %>%
  select(sample_id, sample_date, year, no3_n_ma, k_ma, mg_ma, ca_ma, nh4_n_ma) %>%
  pivot_longer(cols = c("no3_n_ma", "k_ma", "mg_ma", "ca_ma", "nh4_n_ma"),
               names_to = "ion",
               values_to = "amount") %>%
  drop_na() %>%
  filter(year >= 1988, year <= 1994)
```

#filter(!if_all(everything(), is.na)) remove rows where all columns are empty #drop_na() drops any row with at least one NA.

ggplot(data = watersheds_cleaned, aes(x = sample_date, y = amount)) +
  geom_line() +
  facet_wrap(~ion, scales = "free_y", ncol = 1)
