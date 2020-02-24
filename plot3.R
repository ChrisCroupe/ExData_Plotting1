## Getting and Cleaning Data Project
## Chris Croupe
## 02//2019

library(tidyverse)
library(plyr)
library(lubridate)

### Here are the data for the project
 filename <- "household_power_consumption.zip"
 url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
 ## Download and unzip the dataset:
 if (!file.exists(filename)){
        download.file(url, filename)
 }  
if (!file.exists("household_power_consumption.")) { 
        unzip(filename) 
 }

## 1
## Read the required data sets into the environment
## Data files
test_data <- read.delim("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
## Convert Date column to Date class
test_data <- mutate(test_data, Date = as.Date(Date, format = "%d/%m/%Y"))

## Select date range for the data
Date1 <- as.Date("2007-02-01")
Date2 <- as.Date("2007-02-02")
dates <- seq(Date1, Date2, by="days")
reduced_data <- subset(test_data, Date %in% dates)
## Clean-up memory
rm(test_data, dates, Date1, Date2, filename, url)

## Combine date and time variables
reduced_data <- mutate(reduced_data, "Date_Time" = ymd(Date) + hms(Time))

## Plot 3
with(reduced_data,  plot(Date_Time, as.character(Sub_metering_1), type = "l", col = "black", xlab = "",
        ylab = "Energy sub metering"))
with(reduced_data, lines(Date_Time, as.character(Sub_metering_2), type  = "l", col = "red"))
with(reduced_data, lines(Date_Time, Sub_metering_3, type  = "l", col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1          ", "Sub_metering_2          ",
        "Sub_metering_3          "), cex = 1)

## copy plot to pngc
dev.copy(png, file = "Plot3.png")
dev.off()
