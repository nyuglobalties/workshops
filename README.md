
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Data Team Workshops

<!-- badges: start -->
<!-- badges: end -->

Welcome to the Data Team workshops page! If you want to learn R or use
the tools in our data pipeline, you’ve come to the right place. Over
time we’ll add more and more tutorials to cover a breadth of topics so
that you can explore the R ecosystem and see how it could benefit your
workflow.

## Tutorial References

Much of our R tutorials are based on the exceptionally handy [*R for
Data Science*](https://r4ds.had.co.nz/) by Grolemund and Wickham. Rather
than following a standard “computer science”-like approach of teaching
the language fundamentals without application, Grolemund and Wickham
take an application-first approach by going through the basics of data
import, munging, and analysis while teaching the language on the side.
For extra reading and exercises, we highly encourage perusing this text.

Once you feel comfortable working with R, the [RStudio
cheatsheets](https://rstudio.com/resources/cheatsheets/) are an
invaluable resource when you need some form of quick reference. The
sheets are designed so that you can *visually* understand what the
functions are doing, which builds a stronger intuition than just reading
the function documentation.

For working with regular expressions, I highly recommend
[regex101](https://regex101.com). Do note that you *don’t* need to
escape your backslashes on this platform, but you *do* need to do so
with R!

# Workshop Recordings

Access to all recordings requires an NYU login (choose the “Sign in with
SSO” button)

1.  [Session 1: Getting to Know Your
    Data](https://nyu.zoom.us/rec/share/VLku7fo5upo3bVs8xdS8K92Q2UPwzrfzCHUxVGPCJh6XZtQqLGlElp2H4aUvEQr3.NghErP0lw2NxupVV)
2.  [Session 2: Finding Relationships in Your
    Data](https://nyu.zoom.us/rec/share/zSF42XLuzubrBt9fwP2sMPriZvSAp9uq4hU5Qdc1CZI6TjZ6Vu7Cle-Id1Pny54r.cO3UymskhDJVXyWr)
3.  [Session 3: Making R Work for
    You](https://nyu.zoom.us/rec/share/55nw_SkaeuhaCXAtZSNbCemnwi9trTvgKLiSKNjaoEew8Qb7mb3UTwKE6eT7rRyg.sg0ApiMqrMhP7B_D)
4.  [Session 4: Workflows in R – Recommended
    practices](https://nyu.zoom.us/rec/share/w1QiqFhfCjfSkPvrUjobg4_1xERFT3_v6FO9RjvggmfNzdjbG-TTpWYZtKfJvRD4.NHpuJlT-HIR-qihP)

# Setup

There are a couple steps to take to get ready:

## 1 - Get Materials

All materials for the workshops are contained in this repository. You’ll
need to download this repo to get started. There are a couple methods
you can use.

### ZIP Download

Github provides downloadable ZIP archives of entire repositories for
ease of use. Use the “Download ZIP” menu item via the “Code” button
shown below:

![](man/figures/github-download-zip.png)

Extract the ZIP in a folder you remember, and you’ll be all set.

### Git-based

We’ll have a git & Github tutorial soon, but for now we’ll cover the
basics just to get you started:

1.  Install [Github Desktop](https://desktop.github.com/). This
    application takes care of most git workflow tasks.
2.  Once installed, open Github Desktop, navigate to the menu, and
    select `File > Clone Repository...`.
3.  In the dialog box that pops up, select the “URL” tab, and put
    “Global-TIES-for-Children/workshops” into the “Repository URL or
    GitHub username and repository” field. Choose whichever local path
    that you want.

![Clone repository box](man/figures/clone-repository.png)

## 2 - Get Set Up

At this point, you should have downloaded this repository. Now we need
to set up this repository:

1.  Download and install [R](https://cran.r-project.org/) *and*
    [RStudio](https://rstudio.com/). Note: R and RStudio are *not* the
    same thing. R is the language and execution environment, and RStudio
    is an integrated development environment (IDE) *for* R. In other
    words, you write code using RStudio, and then you run your code
    in R.
2.  Navigate to where you downloaded this repository, and open
    `workshops.Rproj` with RStudio (double-clicking the file should do).
3.  In the “Console” tab that should appear in the left pane, run these
    two commands in order:

``` r
install.packages("devtools")
devtools::install_deps(dependencies = TRUE)
```

All of the packages that all materials depend upon should now be
installed.
