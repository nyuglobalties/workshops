# Setup ----
suppressPackageStartupMessages(library(tidyverse))

intervention <- read_csv(
  here::here("data/sample_intervention_dataset.csv"),
  col_types = cols()
)

# Row binding ----
cohort_a <- intervention %>% filter(Cohort == "A")
cohort_b <- intervention %>% filter(Cohort == "B")

head(cohort_a, 2)
head(cohort_b, 2)

set.seed(1283) # Always set an RNG seed to get reproducible results!

bind_rows(cohort_a, cohort_b) %>%
  slice_sample(n = 5)

different_cohort_b <-
  cohort_b %>%
  select(Coded_ID, Intervention:Final_score)

cohort_b %>%
  head(n = 3) %>%
  bind_rows(head(different_cohort_b, 3))

# Joins & Relational Data ----
library(nycflights13)

x <- tibble(key = c(1, 2, 3), val_x = c("x1", "x2", "x3"))
y <- tibble(key = c(1, 2, 4), val_y = c("y1", "y2", "y3"))

x %>%
  inner_join(y, by = "key")

flights %>%
  filter(origin == "JFK" & carrier == "B6") %>%
  inner_join(
    weather,
    by = c("year", "month", "day", "hour", "origin")
  ) %>%
  head(n = 4)

airlines %>% filter(carrier == "B6")

# ggplot2 ----
jfk_weather <-
  weather %>%
  filter(origin == "JFK")

jfk_weather %>%
  ggplot(aes(x = precip))

jfk_weather %>%
  ggplot(aes(x = precip)) + # Note the plus!! In ggplot, you "add" layers like a stack.
  geom_histogram()

jfk_flights_weather <-
  flights %>%
  filter(origin == "JFK") %>%
  inner_join(
    weather %>%
      select(-time_hour),                            # Deselect columns with `-`
    by = c("year", "month", "day", "hour", "origin")
  )

jfk_flights_weather %>%
  filter(precip > 0) %>%
  select(dep_delay, precip)

jfk_flights_weather %>%
  filter(precip > 0) %>%
  select(dep_delay, precip) %>%
  ggplot(aes(x = precip, y = dep_delay)) +
  geom_point()

jfk_flights_weather %>%
  filter(precip > 0) %>%
  select(dep_delay, precip) %>%
  ggplot(aes(x = precip, y = dep_delay)) +
  geom_point(alpha = 0.4) +
  stat_smooth(method = "lm")

jfk_flights_weather %>%
  filter(precip > 0) %>%
  select(dep_delay, precip) %>%
  ggplot(aes(x = precip, y = dep_delay)) +
  geom_jitter(alpha = 0.4) +
  stat_smooth(method = "lm")

jfk_flights_weather %>%
  mutate(carrier = as.factor(carrier)) %>% #<<
  group_by(carrier, month) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(
    x = month,
    y = avg_dep_delay,
    color = carrier
  )) +
  geom_point()

current_plot <- jfk_flights_weather %>%
  left_join(airlines, by = "carrier") %>%
  mutate(name = as.factor(name)) %>%
  group_by(name, month) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(
    x = month,
    y = avg_dep_delay,
    color = name
  )) +
  geom_line()

current_plot

current_plot +
  labs(
    x = "Month",
    y = "Average departure delay (minutes)",
    title = "Monthly Trend of Departure Delays from JFK",
    color = "Airline"
  ) +
  ggthemes::theme_clean() +
  ggthemes::scale_color_calc()

jfk_flights_weather %>%
  left_join(airlines, by = "carrier") %>%
  mutate(name = as.factor(name)) %>%
  group_by(name, month) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(
    x = month,
    y = avg_dep_delay
  )) +
  geom_line() +
  facet_wrap(~ name) + #<<
  labs(
    x = "Month",
    y = "Average departure delay (minutes)",
    title = "Monthly Trend of Departure Delays from JFK"
  ) +
  ggthemes::theme_clean()

# Esquisse ----
esquisse::esquisser()
