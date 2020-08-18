# All executable code to accompany Session 1

library(readr)
library(here)

dat <- read_csv(here("data/sample_intervention_dataset.csv"))

str(dat)
print(dat)
