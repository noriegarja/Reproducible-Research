## Loading and processing the data

data<-read.csv("activity.csv",header = TRUE,na.strings = "NA")
head(data)

library(knitr)
library(ggplot2)
library(knitr)
opts_chunk$set(fig.path = "./figure/")

## What is mean total number of steps taken per day?

StepsPerDay<-tapply(data$steps,data$date,sum,na.rm = TRUE)
MeanStepPerDay<-mean(StepsPerDay)
MeanStepPerDay

qplot(StepsPerDay,xlab = "Total Steps per day", ylab = "Frecuency",binwidth=500)

    
## What is the average daily activity pattern?

## Median Steps per day
MedianStepPerDay<-median(StepsPerDay)
MedianStepPerDay

AveDayActPatt<-aggregate(x=list(meanSteps=data$steps),by=list(interval=data$interval),
                         FUN=mean,na.rm=TRUE)

ggplot(data = AveDayActPatt,aes(x=interval,y=meanSteps))+geom_line()+
    ggtitle("Average Number of Steps Per Day")+xlab("5-minute interval")+ylab("Average Number of steps")

## Calculation of 5-Minutes Interval
MaxSteps<-which.max(AveDayActPatt$meanSteps)
MostOfSteps<-gsub("([0-9]{1,2})([0-9]{2})","\\1:\\2",AveDayActPatt[MaxSteps,"interval"])
MostOfSteps

#Missing Values
MissingValues<-length(which(is.na(data$steps)))
MissingValues

## Make an Histogram of the number of total steps taken by day

activity<-data.table::fread(input="activity.csv")
TotalSteps<-activity[,c(lapply(.SD,sum)),.SDcols=c("steps"),by=.(date)]
TotalSteps[,.(MeanSteps=mean(steps),MedianSteps=median(steps))]

ggplot(TotalSteps,aes(x=steps))+geom_histogram(fill="blue",binwidth = 1000)+
    labs(title="Daily Steps",x="Steps",y="Frequency")
print(ggplot)

##Are there differences in activity patterns between weekdays and weekends?
data<-read.csv("activity.csv",header = TRUE,na.strings = "NA")
data$date<-as.POSIXct(data$date)
dataFix <-data
for(i in unique(dataFix$interval)) {
    dataFix$steps[is.na(dataFix$steps) & dataFix$interval == i] <- 
        round(mean(dataFix$steps[data$interval == i],na.rm = TRUE))
}
dataFix$weekDay<-as.POSIXlt(data$date)$wday == 0 | as.POSIXlt(data$date)$wday ==6
dataFix$weekDay<-factor(dataFix$weekDay,levels =c(F, T), labels=c("weekday","weekend"))

stepsWeekDay<-tapply(dataFix$steps[dataFix$weekDay=="weekday"],
                     dataFix$interval[dataFix$weekDay=="weekday"],mean)
stepsWeekEnd<-tapply(dataFix$steps[dataFix$weekDay=="weekend"],
                     dataFix$interval[dataFix$weekDay=="weekend"],mean)

par(mfrow = c(2,1))
plot(stepsWeekDay,type = "l",main = "weekdays",xlab = "the 5-minute interval",ylab = "the average steps")
plot(stepsWeekEnd,type = "l",main = "weekends",xlab = "the 5-minute interval",ylab = "the average steps")
