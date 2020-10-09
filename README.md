
<!-- README.md is generated from README.Rmd. Please edit that file -->

Data Team Workshops
===================

<!-- badges: start -->
<!-- badges: end -->

Welcome to the Data Team workshops page! If you want to learn R or use
the tools in our data pipeline, you’ve come to the right place. Over
time we’ll add more and more tutorials to cover a breadth of topics so
that you can explore the R ecosystem and see how it could benefit your
workflow.

Tutorial References
-------------------

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

Get Materials
-------------

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

Get Set Up
----------

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
    three commands in order:

<!-- -->

    install.packages("devtools")
    devtools::install_deps(dependencies = TRUE)

All of the packages that all materials depend upon should now be
installed.
