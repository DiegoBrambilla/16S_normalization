# Introduction to Git with RStudio

This tutorial will cover the first step for an interactive use of Git as part of the RStudio Integrated Development Environment (IDE).
Material taken from [the RStudio web page](https://support.rstudio.com/hc/en-us/articles/200532077?version=1.3.959&mode=desktop)

## Motivation

- What does it mean "version control"?
  
  A record of all the changes undergone into a project over its lifetime.
  
  If each change is a snapshot, the GitHub repository as a whole can be considered a "photo album".

- Git as fundamental skill ([source](https://dev.to/sublimegeek/want-to-learn-programming-learn-how-to-track-changes-first-2b8b)): useful for several situations, from collaboration to automation.

- motto: your worst enemy is yourself four months from now
   -  *anonymous*

## Requirements

RStudio supports the following open source version control systems:

- [Git](http://git-scm.com/)
- [Subversion](http://subversion.apache.org/)

To use version control with RStudio, you should first ensure that you have installed Git and/or Subversion tools on your workstation.

## Installation

This tutorial supports version control with Git.

### Git

Prior to using Git with RStudio you should install it using the appropriate method for your platform:

    Windows & OS X: http://git-scm.com/downloads
    Debian/Ubuntu: sudo apt-get update && sudo apt-get install git-core
    Fedora/RedHat: sudo yum install git-core

## Activation

Once you've installed Git, you'll need to activate it on your system by following these steps:

-  Open RStudio
-  From the toolbar, go to "tools" -> "Global Options"
-  Click "Git/SVN"
-  Click "Enable version control interface for RStudio projects"
-  If necessary, enter the path for your Git or SVN executable where provided.

**N.B.:** RStudio's version control features are tied to the use of Projects (which are a way of dividing work into multiple contexts, each with their own working directory).
The steps required to use version control with a project vary depending on whether the project is new or existing as well as whether it is already under version control.

## Importing this Git directory through RStudio

The current Git repository provides a [R project file](../16S_normalization.Rproj) which is already under version control.
We want to import this Git repository through RStudio:

 - Open RStudio
 - From the toolbar, select the "new project" symbol
 - Execute the "New Project" command
 - Choose "Version Control" to copy this directory from GitHub to your PC
 - Choose Git
 - paste the following link in the field "repository URL": https://github.com/DiegoBrambilla/16S_normalization/
   - *bonus:* This step can be performed on command line: ```git clone https://github.com/DiegoBrambilla/16S_normalization.git```
 - Provide the path you wish in the field "Crete project as a subdirectory of" 
 - Click "Create Project"

The remote repository will be cloned into the specified directory and RStudio's version control features will then be available for that directory.

## Outcome

When you will open the R project file, a new R session (process) is started.
 -  The project file can also be used as a shortcut for opening the project directly from the filesystem.
 -  The current working directory is set to the project directory.
   - you can refer to files in this directory with relative paths (`../path/to/file`)
   - **N.B.:** this means you no longer need to `getwd()` or `setwd()` to import files in the current project area.

# How to contribute to develop a project with Git

## 1.Open an “issue” as a change proposal

Go to the [Issue section](https://github.com/DiegoBrambilla/16S_normalization/issues) and open a new “Issue” on the central repository.
Note the issue number as part of the issue name (e.g. #1 improving tutorial documentaiton).
Each issue is a proposal where you describe your idea with the possibility to collect feedback from others.
Issues are also a way to report problems.

   
