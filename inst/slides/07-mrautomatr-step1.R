# Steps to use mrautomatr (Step 1)

# See details on this website:
# https://bookdown.org/wuzezhen33/mrautomatr/set-up-the-parameters.html

# You only need to run the following functions once!

# 1.  Download and install ------------------------------------------------

# Download R and Rstudio before opening this Rscript in Rstudio

# `usethis` generates the github token so that you can download it from a private repository
install.packages("usethis")

# `devtools` allows you to download the package from github
install.packages("devtools")

# load the packages into your R session
library(usethis)
library(devtools)
# note that if you use library() on a certain package, you will be able to use it
# without using the "::" in between the package name and the function name

# run this line to get the token
create_github_token()

# It'll take you through the process of creating a token by opening a new web page,
# and then GitHub will give you a string of characters.
# Copy that text to somewhere safe for now.

# run this line to put the token in R
edit_r_environ()

# copy the token and paste it into the .Renviron file after the "=" sign; e.g., GITHUB_PAT=ghp_...

# install mrautomatr from the nyuglobalties github repository
install_github("nyuglobalties/mrautomatr")

# load the package into your R session
library(mrautomatr)

# check what functions exist in mrautomatr
?mrautomatr






