# All executable code to accompany Session 1

library(readr)
library(here)

dat <- read_csv(here("data/sample_intervention_dataset.csv"))

# Looking at the data ----
str(dat)
print(dat)

head(dat, 1)
tail(dat, 2)

# Tidyverse/base R comparison ----
library(dplyr)

filter(dat, Cohort == "A")
dat[dat$Cohort == "A", ]

arrange(dat, Final_grade)
dat[order(dat$Final_grade), ]

summarize(dat, avg_score = mean(Final_score))
data.frame(avg_score = mean(dat$Final_score))

## Base R's routine overwrites the original `dat` variable, so I'll create a copy
## of `dat` for the Base R comparison.
mutate(dat, failed = Final_score < 60)
new_dat <- dat
new_dat$failed <- new_dat$Final_score < 60

# Learning dplyr ----
filter(dat, Cohort == "A")

arrange(dat, Final_score)
arrange(dat, -Final_score)

summarize(
  dat,
  avg_score = mean(Final_score),
  sd_score = sd(Final_score)
)

mutate(
  dat,
  # Deletes the `X1` variable.
  # NULL is a symbol in R that means "no value" (not "missing"!).
  X1 = NULL,
  # Changes Cohort to an index variable
  Cohort = ifelse(Cohort == "A", 1, 2)
)

# Combining operations ----
summarize(
  filter(dat, Intervention == 1),
  avg_final_score = mean(Final_score)
)

dat %>%
  filter(Intervention == 1) %>%
  summarize(avg_final_score = mean(Final_score))

## Grouping
dat %>%
  group_by(Intervention) %>%
  summarize(avg_final_score = mean(Final_score))

dat %>%
  group_by(Intervention, Cohort) %>%
  summarize(avg_final_score = mean(Final_score))

### Compared to base R

# dat %>%
#   group_by(Cohort) %>%
#   filter(Final_score > 85)

partioned <- lapply(
  unique(dat$Cohort),
  function(cohort) dat[dat$Cohort == cohort, ]
)

filtered <- lapply(
  partioned,
  function(part) part[part$Final_score > 85, ]
)

do.call(rbind, filtered)

# dat %>%
#   group_by(Cohort) %>%
#   mutate(median_stereotype = median(Baseline_stereotype_endorsement))

partioned <- lapply(
  unique(dat$Cohort),
  function(cohort) dat[dat$Cohort == cohort, ]
)

mutated <- lapply(
  partioned,
  function(part) {
    part$median_stereotype <- median(part$Baseline_stereotype_endorsement)
    part
  }
)

do.call(rbind, mutated)

# dat %>%
#   group_by(Intervention, Cohort) %>%
#   summarize(avg_final_score = mean(Final_score))

agg <- aggregate(Final_score ~ Intervention + Cohort, data = dat, FUN = mean)
names(agg) <- ifelse(names(agg) == "Final_score", "avg_final_score", names(agg))
agg
