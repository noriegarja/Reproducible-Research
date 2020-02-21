---
title: 'Assignment 1, Reproducible Research, Monitoring Activity'
author: "Jose Noriega"
date: "15/2/2020"
output:
  html_document: 
    keep_md: TRUE
  pdf_document: default
  word_document: default
  md_document: default
  html_notebook: 
    toc: yes
editor_options: 
  chunk_output_type: console
---
This assigment is about to describe in multiple parts a monitoring example project using R Markdown. We will need to write a report that answers the questions detailed in "Instruction.pdf" file using the data sample download in the "activity.zip" file. completing the entire assignment in this single R markdown document which can be processed by knitr and be transformed into an HTML file.
Following the results per questions:

## Loading and preprocessing the data
To load the data I used read.csv funtion, considering firt file as the headers and all the missing vaues, as follow:


```r
library(knitr)
opts_chunk$set(fig.path = "./figure/")
data<-read.csv("activity.csv",header = TRUE,na.strings = "NA")
head(data)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```


## What is mean total number of steps taken per day?

I will calculate the mean total number steps taken by day, considery a tapply funtion which sum total steps by date, then calculate the mean of the StepsPerDay
The result is the next:


```r
StepsPerDay<-tapply(data$steps,data$date,sum,na.rm = TRUE)
MeanStepPerDay<-mean(StepsPerDay)
MeanStepPerDay
```

```
## [1] 9354.23
```

An histogram of the Total of number of steps by day is calculate and plot by the next code:


```r
library(ggplot2)
qplot(StepsPerDay,xlab = "Total Steps per day", 
      ylab = "Frecuency",binwidth=500)
```

![](./figure/unnamed-chunk-2-1.png)<!-- -->


