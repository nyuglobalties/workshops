# Steps to use mrautomatr (Step 1)

# See details on this website:
# https://bookdown.org/wuzezhen33/mrautomatr/set-up-the-parameters.html

# You only need to run the following functions once!

# 1.  Download and install from compressed file------------------------------------------------

# For this workshop, run the following line to install a compiled version of the package
# Change the path in the quotation marks to wherever you put the tar.gz file

# If you are a Mac user
# Go to Finder, locate the tar.gz file, single click to highlight the file
# Hit Command + Option + C
# Come back to R and paste in between the quotation marks below
file <- "/Users/michaelfive/Desktop/R Directory/Git learning/mrautomatr_0.0.0.9000.tar.gz"
install.packages(file, repos = NULL)

# If you are a Windows user
# Go to your folder, locate the tar.gz file, single click to highlight the file
# Right click and select "Copy as path" OR click Home and select "copy path"
# Come back to R and replace the quotes
# Manually add another "\" each time you see a "\" in the quote
file <- "C:\\Users\\michaelfive\\mrautomatr_0.0.0.9000.tar.gz"
install.packages(file, repos = NULL)

# For both Mac and Windows users
# load the package into your R session
library(mrautomatr)

# check what functions exist in mrautomatr
?mrautomatr

######################################################
###### IGNORE THE FOLLOWING DURING THE WORKSHOP ######
######################################################

# 2.  Download and install from Github ------------------------------------------------

# This allows you to search for updates of the package on GitHub

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

# restart R here

# install the package from github
devtools::install_github("nyuglobalties/mrautomatr")

# load the package into your R session
library(mrautomatr)

# check what functions exist in mrautomatr
?mrautomatr






