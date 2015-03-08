# This script creates a histogram plot from household power consumption data
# collected by University of California Irvine (UCI).
# 
# Original data description, info and download location: 
#     https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# 
# Note: Data requires approx. 145MB of memory when read in by R
#
# Script created for Coursera: Exploratory Data Analysis from JHU
# To run, place script in working directory, then execute statement in console:
#    > source('./plot2.R')

# Download and unzip data file into working directory:
# fileURL0 <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dateDownloaded <- date()
download.file(fileURL, destfile="./HPC.zip", method="curl")
unzip("./HPC.zip")
datafile <- "household_power_consumption.txt"

# [Optional] Detect column classes, for use as 'colClasses' parameter:
# initial <- read.table(datafile, header=TRUE, sep=";", nrows = 100)
# classes <- sapply(initial, class)

# Read datafile into data frame variable:
powerdata <- read.table(datafile, header=TRUE, sep=";", colClasses="character")

# Reclassify "Date" column, specify two dates of interest:
powerdata$Date <- strptime(powerdata$Date,"%d/%m/%Y")
dayone <- strptime("2007-02-01","%Y-%m-%d") # ?OR? as.Date("2007-02-01")
daytwo <- strptime("2007-02-02","%Y-%m-%d")

# Subset data and reclassify "Global Active Power" to numeric:
powerdata <- powerdata[powerdata$Date == dayone | powerdata$Date == daytwo,];
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

# Concatenate "Date" and "Time" columns, reclassify, add to data frame:
powerdata$DateTime <- do.call(paste,c(powerdata[c("Date","Time")],sep=" "))
powerdata$DateTime <- strptime(powerdata$DateTime,"%Y-%m-%d %H:%M:%S")

# Create PNG file with line plot:
png(filename="plot2.png", width=480, height=480, units="px")
with(powerdata,plot(DateTime,Global_active_power, type="l",main="",
                    ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()