#Contribution Guidelines

- Use git to clone this repository and contributing through [pull requests](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) (PRs). This online walkthrough will explain how to use Git
for contributiong to projects.
Namely, able to make a pull request (PR).

- Develop short codes in [RMarkdown](https://guides.github.com/features/mastering-markdown/)

- Allow in-building of comments in RMarkdown through [knitr](https://yihui.org/knitr/)
(no need to save resuilts to file, see recommendation)
  - **bonus**: you can build HTML/PDF files with knitr

- Use tydiverse, a meta-library that keeps codes and tables compact 
(that is, tidy).
  -Introduction and installation instructions [here](https://tidyverse.tidyverse.org/)
  - **warning**: you need to have R/Rstudio 3.4.4 or higher 

Below some best practice on coding with RMarkdown files (.Rmd)

Credits: [Daniel Lundin](https://github.com/erikrikarddaniel)


#RStudio and RMarkdown
========================================================

##Good habits
========================================================

- No `setwd()` and *relative* paths
  - Exception: set relative paths to files in this folder

- Define as *few* tables as possible

- Don't write intermediate tables to file

- *Scripts* (not RMarkdown) for heavy analyses

- RMarkdown for figures and tables with comments

- (Advanced: Use Make to run scripts that create data files)

#Demo: calculating relative abundance on test data
========================================================

#Tidyverse Books
========================================================

- [R for Data Science](https://r4ds.had.co.nz/)

- [Advanced R](https://adv-r.hadley.nz/index.html

