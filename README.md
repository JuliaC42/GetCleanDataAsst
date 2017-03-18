---
title: "README"
output: github_document
---

##Explanation of process and script

As instructed I downloaded the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I opened the files first in Notepad++ to see what I had.

Firstly, these seem to be basic space separated tables that can be opened in a basic read.table()

There are 3 pairs of tables (training set and test set) that will make up the main data frame.

I decided first to rbind each pair (training set first in all cases). This gave me a vector for the subjects, a categorical vector for the activities (the y sets) and a dataframe (from the x) of all the measures (of the features).

Before joining them together, having realised that the features file contained the column names, I read the features file in and used grep to reduce the x dataset to only those columns relating to a feature containing mean() or std(). It was left open in the instructions as to what we should include, I chose to only include those - this meant I had to escape the (, ie use \\(.

I checked and it seemed to have worked out right.
As I was going to be using this for names I created a character vector feat2 for the names relating to those columns.
newfeat wasn't strictly necessary but allowed me to double check that the names tied up.

I joined the data together using rbind, gave the activities names using a nested ifelse statement, then named the columns using names I prepared above,

I created the final output dataset using group_by and summarise.


The script can all be run in one go.

##The dataset 

The dataset is tidy, each variable forms a column, and each observation is a row. The rubric allows for either long or wide forms.

The dataset can be read into R using read.table("path", header = T)

##Code book

Details about the data can be found in the file CodeBook.md


I would like to thank David Hood for his extensive post under his "thoughtfulbloke" blog, it has been of great help in project managing this assignment.
