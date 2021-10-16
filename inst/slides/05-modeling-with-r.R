library(magrittr)
library(flair)

## ---- eval = F------------------------------------------------
# required packages
packages <- c("tidyverse", "psych", "here", "skimr", "tldr", "esquisse","broom", "texreg", "remotes")

# check package existence before installing them
install.packages(setdiff(packages, rownames(installed.packages())))

# rcoder by Patrick
remotes::install_github("nyuglobalties/rcoder")


## ---- results = "hide"----------------------------------------
library(tidyverse)
dat <- read_csv(here::here("data/sample_intervention_dataset.csv"))
head(dat)


## ---- echo = F------------------------------------------------
DT::datatable(
  head(dat),
  options = list(pageLength = 3,
  scrollX = T,
  scrollY = T,
  scrollCollapse = T,
  columnDefs = list(list(className = 'dt-center', targets="_all"))))


## ---- echo = F------------------------------------------------
library(rcoder)
coding(code("Treatment", 1), code("Control", -1))
coding(code("Female", 1), code("Male", 0))


## -------------------------------------------------------------
dat <- dat %>%
  mutate(Affirm = if_else(Intervention == 1, "Treatment", "Control"),
         Gender = if_else(Female == 1, "Female", "Male")
         )


## -------------------------------------------------------------
table(dat$Affirm, dat$Intervention)
table(dat$Gender, dat$Female)


## -------------------------------------------------------------
mean(dat$Final_grade, na.rm = T)
sd(dat$Final_grade, na.rm = T)
median(dat$Final_grade, na.rm = T)


## -------------------------------------------------------------
dat %>% group_by(Gender) %>%
  summarise(
    Final_grade_mean = mean(Final_grade, na.rm = T),
    Final_grade_sd = sd(Final_grade, na.rm = T),
    Final_grade_median = median(Final_grade, na.rm = T)
  )


## -------------------------------------------------------------
# a function to generate the model
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}

dat %>% group_by(Gender, Affirm) %>%
  summarise(
    Final_grade_mode = getmode(Final_grade)
  )


## ---- results = "hide"----------------------------------------
dat.s <- dat %>% select(Final_grade:Baseline_stereotype_endorsement)
df <- psych::describe(dat.s) %>%
  as.data.frame() %>%
  rownames_to_column(var = "varnames") %>%
  mutate_if(is.numeric, round, 3)


## ---- echo = F------------------------------------------------
DT::datatable(
  df,
  options = list(pageLength = 4,
  scrollX = T,
  scrollCollapse = F,
  columnDefs = list(list(className = 'dt-center', targets="_all"))))


## ---- results = "hide"----------------------------------------
df <- skimr::skim(dat.s) %>%
  mutate_if(is.numeric, round, 3)


## ---- echo = F------------------------------------------------
DT::datatable(
  df,
  options = list(pageLength = 4,
  scrollX = T,
  scrollCollapse = F,
  columnDefs = list(list(className = 'dt-center', targets="_all"))))


## ---- fig.height=4, dpi = 300---------------------------------
# histogram
hist(dat$Final_grade, main = "Final grades", xlab = "Distribution of final grades")


## ---- fig.height=4, dpi = 300---------------------------------
# boxplot
boxplot(dat$Final_grade, main = "Final grades", ylab = "Distribution of final grades")


## ---- fig.height=4, dpi = 300---------------------------------
# scatterplot
plot(dat$Final_grade, dat$Final_score, xlab = "Final grades", ylab = "Final scores")


## -------------------------------------------------------------
table(dat$Affirm)
table(dat$Affirm, dat$Gender)
prop.table(table(dat$Affirm, dat$Gender))


## ---- results = "hide"----------------------------------------
dat.s <- dat %>% select(Affirm, Gender, Cohort, Baseline_stereotype_endorsement)

gen.ftab <- function(data){

  x <- as.data.frame(sapply(data, as.character))

  ftab <- suppressMessages(tldr::KreateTableOne(x)) # suppress this
  var = rownames(ftab)
  ftab <- as.data.frame(ftab) %>% mutate(Variable = var, .before = 'Overall')

  return(ftab)
}

df <- gen.ftab(dat.s)


## ---- echo = F------------------------------------------------
DT::datatable(
  df,
  options = list(pageLength = 4,
  scrollX = T,
  scrollY = T,
  scrollCollapse = F,
  columnDefs = list(list(className = 'dt-center', targets="_all"))))


## ---- fig.height=4, dpi = 300---------------------------------
# histogram
barplot(table(dat$Gender), main = "Frequency of gender")


## ---- eval = F------------------------------------------------
## esquisse::esquisser()


## -------------------------------------------------------------
cont.table <- table(dat$Affirm, dat$Gender)
chisq.test(cont.table)


## -------------------------------------------------------------
chisq.test(cont.table)


## -------------------------------------------------------------
dat.s <- dat %>% select(Final_grade:Baseline_stereotype_endorsement)

# Pearson r correlation is the most widely used correlation statistic to measure the degree of the relationship between linearly related variables.
cor(dat.s, method = "pearson")



## -------------------------------------------------------------
# Spearman r correlation is a nonparametric measure of rank correlation (statistical dependence between the rankings of two variables)
cor(dat.s, method = "spearman")


## ---- eval = F------------------------------------------------
## psych::corr.test(dat.s, use = "complete")
## psych::corr.test(dat.s, use = "pairwise")
## psych::corr.test(dat.s, method = "spearman", use = "pairwise")


## -------------------------------------------------------------
corstarsl <- function(x){
x <- as.matrix(x)
R <- Hmisc::rcorr(x)$r
p <- Hmisc::rcorr(x)$P

## define notions for significance levels; spacing is important.
mystars <- ifelse(p < .001, "***", ifelse(p < .01, "**", ifelse(p < .05, "*", "")))
## trunctuate the matrix that holds the correlations to two decimal
R <- format(round(cbind(rep(-1.11, ncol(x)), R), 3))[,-1]
## build a new matrix that includes the correlations with their apropriate stars
Rnew <- matrix(paste(R, mystars, sep=""), ncol=ncol(x))
diag(Rnew) <- paste(diag(R), " ", sep="")
rownames(Rnew) <- colnames(x)
colnames(Rnew) <- paste(colnames(x), "", sep="")
## remove upper triangle
Rnew <- as.matrix(Rnew)
Rnew[upper.tri(Rnew, diag = TRUE)] <- "--"
Rnew[upper.tri(Rnew)] <- ""
Rnew <- as.data.frame(Rnew)
## remove last column and return the matrix (which is now a data frame)
Rnew <- cbind(Rnew[1:length(Rnew)])
return(Rnew)
}


## ---- results="hide"------------------------------------------
corstarsl(dat.s)


## ---- echo = F------------------------------------------------
DT::datatable(
  corstarsl(dat.s),
  options = list(pageLength = 4,
  scrollX = T,
  scrollCollapse = F,
  columnDefs = list(list(className = 'dt-center', targets="_all"))))


## -------------------------------------------------------------
# compared a mean to a constant value
t.test(dat$Final_score, mu = 72)


## -------------------------------------------------------------
# compare two independent means
t.test(Final_score ~ Gender, data = dat)

# summary stats for reporting
dat %>% group_by(Gender) %>%
  summarize(m = mean(Final_score,na.rm = T),
            sd = sd(Final_score,na.rm = T))


## ---- eval = F------------------------------------------------
## t.test(Final_score ~ Gender, alternative = "greater", data = dat) # x has a larger mean than y
## t.test(Final_score ~ Gender, alternative = "less", data = dat) # x has a smaller mean than y
## t.test(Final_score ~ Gender, alternative = "two.sided", data = dat) # x has a equal mean as compared to y


## -------------------------------------------------------------
# single factor anova
fit <- aov(Final_score ~ Affirm, dat)
summary(fit)


## -------------------------------------------------------------
TukeyHSD(fit)


## ---- fig.height=4, dpi = 300---------------------------------
par(mfrow = c(1,1), mar = c(5,8,4,2), las = 1)
# MultiFrame rowwise layout (mfrow), margin size (mar), axis label locations (mgp), and axis label orientation (las).
plot(TukeyHSD(fit))


## -------------------------------------------------------------
# double factor anova
fit <- aov(Final_score ~ Affirm*Gender, dat)
summary(fit)


## ---- results = "hide", echo = F------------------------------
dev.off()


## ---- fig.height=4, dpi = 300---------------------------------
with(dat, interaction.plot( Gender, Affirm, Final_score,
                           type = "b", col = c("red", "blue"),
                           pch = c(16,18)))


## -------------------------------------------------------------
fit1 <- lm(Final_score ~ Baseline_math_score, dat)
summary(fit1)


## ---- fig.height=4, dpi = 300---------------------------------
ggplot(dat, aes(x = Baseline_math_score, y = Final_score)) +
  geom_point() +
  geom_smooth(method = "lm", fill = NA) +
  theme_bw()


## -------------------------------------------------------------
# add a quadratic term
fit2 <- lm(Final_score ~ Baseline_math_score + I(Baseline_math_score^2) + I(Baseline_math_score^3) , data = dat)
summary(fit2)


## ---- fig.height=4, dpi = 300---------------------------------
ggplot(dat, aes(x = Baseline_math_score, y = Final_score)) +
  geom_jitter() +
  geom_smooth(method = "lm", color = "blue", fill = NA) +
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), color = "red") +
    geom_smooth(method = "lm", formula = y ~ x + I(x^2) + I(x^3), color = "green")+
  theme_bw()


## -------------------------------------------------------------
M1 <- lm(Final_score ~ Baseline_math_score, data = dat)
M2 <- lm(Final_score ~ Baseline_math_score + Affirm, data = dat)
M3 <- lm(Final_score ~ Baseline_math_score + Affirm*Gender, data = dat)
M4 <- lm(Final_score ~ Baseline_math_score + Affirm*Gender + Cohort, data = dat)


## -------------------------------------------------------------
# estimates
broom::tidy(fit1)
# model fit
broom::glance(fit1)


## ---- results = "asis"----------------------------------------
texreg::htmlreg(
  list(M1,M2,M3,M4),
  custom.model.names = c("M1", "M2", "M3", "M4"),
  caption = "Test models",
  digits = 3
)


## ---- fig.height=5, dpi=300-----------------------------------
par(mfrow = c(2,2))
plot(M2)

