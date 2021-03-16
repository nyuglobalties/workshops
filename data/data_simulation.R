# load in real data
library(tidyverse)

# load pre-cleaned data
load("/Users/michaelfive/Box/Box 3EA Team Folder/For Zezhen/SL data/Analysis/SL_data_MW.RData")

rm(list=setdiff(ls(), c("act", "egra", "attend", "tco_sel", "toca")))

# subset datasets

act.s <- act %>%
  select(class:m_act,bg_act) %>%
  mutate(m_act = sample(unique(act$m_act), size = nrow(act), replace = T),
         bg_act = sample(unique(act$bg_act), size = nrow(act), replace = T)
         ) %>%
  filter(class %in% 1:10)

id <- data.frame(s_id = sort(unique(attend$s_id)),
                 id = 1:length(unique(na.omit(attend$s_id))))

class_id <- attend %>% group_by(s_id) %>% summarise(class = mean(class, na.rm = T)) %>% na.omit()
id <- id %>%
  left_join(class_id, by = "s_id") %>%
  mutate(tx = ifelse(class %in% c(1:10), 1, 0)) %>%
  filter(class %in% 1:20)


attend.s <- attend %>%
  select(s_id, class, date, attend) %>%
  na.omit() %>%
  filter(class %in% 1:20) %>%
  left_join(id %>% select(-class), by = "s_id") %>%
  select(class, id, date, attend) %>%
  arrange(class, id, date)

attend.s <- attend.s %>% mutate(attend = sample(c(0,1),
                                                size = nrow(attend.s),
                                                prob = c(0.3,0.7),
                                                replace = T))

egra.s <- egra %>%
  left_join(id, by = "s_id") %>%
  select(id, class, tx, age:children_household, english_home:work, orient_b:letter_e) %>%
  filter(class %in% 1:20)

for (i in 4:length(names(egra.s))) {
  egra.s[,i] <- sample(unique(egra.s[,i]),
                       size = nrow(egra.s),
                       replace = T)

}

# create roadblocks for data cleaning

act.s2 <- act.s %>%
  mutate(m_act = paste(m_act, "_", sep = ""))


write.csv(act.s2, "data/activity_tracker.csv", row.names = F)
write.csv(attend.s, "data/attendance.csv", row.names = F)
write.csv(egra.s, "data/egra.csv", row.names = F)


