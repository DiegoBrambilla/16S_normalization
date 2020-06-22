# Contribution Guidelines

- Use Git to clone this repository and contributing through [pull requests](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) (PRs).
The [online walkthrough written by the CodeRefinery Team](https://coderefinery.github.io/git-intro/) will explain how to use Git for project contributions.
- **bonus**: [Git can be installed on Rstudio](http://www.geo.uzh.ch/microsite/reproducible_research/post/rr-rstudio-git/), useful for those who use Windows.

- Document code through [RMarkdown](https://guides.github.com/features/mastering-markdown/)

- Allow in-building of comments in RMarkdown through [knitr](https://yihui.org/knitr/)
(no need to write report of activities, see below)
  - **bonus**: you can build HTML/PDF files with knitr

- Use tydiverse, a meta-library that keeps codes and tables compact 
(that is, tidy).
  -Introduction and installation instructions [here](https://tidyverse.tidyverse.org/)
  - **warning**: you need to have R/Rstudio 3.4.4 or higher 

Below some best practice on coding with RMarkdown files (.Rmd)

Credits: [Daniel Lundin](https://github.com/erikrikarddaniel)


# RStudio and RMarkdown

## Good habits

- No `setwd()` and *relative* paths
  - Exception: set relative paths to files in this folder

- Keep max. 100 characters per line
  - **N.B.:** use code indentation!

- Define as *few* tables as possible

- Don't write intermediate tables to file

- *Scripts* (not RMarkdown) for heavy analyses

- RMarkdown for figures and tables with comments

- (Advanced: Use Make to run scripts that create data files)

# Demo: calculating relative abundance on test data

An example table and R script a have been prepared in [demo](../test/demo), jump to it!

# Tidyverse Books

- [R for Data Science](https://r4ds.had.co.nz/)

- [Advanced R](https://adv-r.hadley.nz/index.html)

