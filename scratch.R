## Spaghetti code

## Load & run libraries
library(tidyverse)
library(here)
library(janitor)

## read data files

MPR <- read_csv(here::here("data", "RioMameyesPuenteRoto.csv"), na = c(" ", "NA")) %>%
  clean_names()

QB1 <- read_csv(here::here("data", "QuebradaCuenca1-Bisley.csv"), na = c(" ", "NA")) %>%
  clean_names()

QB2 <- read_csv(here::here("data", "QuebradaCuenca2-Bisley.csv"), na = c(" ", "NA")) %>%
  clean_names()

QB3 <- read_csv(here::here("data", "QuebradaCuenca3-Bisley.csv"), na = c(" ", "NA")) %>%
  clean_names()

df_join1 <- full_join(MPR, QB1)

df_join2 <- full_join(QB2, QB3)

df_join <- full_join(df_join1, df_join2)

df_join_selected <- df_join %>%
  select("sample_id", "sample_date", "no3_n", "k", "mg", "ca", "nh4_n")

library(lubridate)
library(dplyr)
library(slider)

library(zoo)

rolling <- df_join_selected %>%
  group_by(no3_n) %>%
  mutate(mean_9w_no3n = slide_index_dbl(
        .x = no3_n,
        .i = sample_date,
        .f = mean,
        .before = weeks (9)
        )
  )

rolling <- df_join_selected %>%
  group_by(sample_date, no3_n) %>% 
  mutate(across(.cols = starts_with("col"),
                .fns = ~ rollmean(x = .x, k = 9, fill = NA, align = "left"))) %>% 
  ungroup()