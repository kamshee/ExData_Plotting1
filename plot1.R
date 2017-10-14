## EDA week 1 project
## Plot 1

library(data.table)
library(dplyr)

fileUrl <- 
 "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "dataset.zip")
unzip("dataset.zip")

data2 <- fread("./household_power_consumption.txt",
        header = TRUE,na.strings = c("?","","NA"),
        colClasses = c(rep("character", 2), rep("numeric", 7)))

## Subset by data and convert to Date format
data3 <- subset(data2, Date=="1/2/2007" | Date=="2/2/2007")
##data3 <- data2[data2$Date %in% c("1/2/2007","2/2/2007"),]
data3$Date <- as.Date(data3$Date, "%d/%m/%Y")

## Create and add datetime column
datetime <-strptime(paste(data3$Date,data3$Time, sep=" "),"%Y-%m-%d %H:%M:%S")
data3 <- cbind(data3,datetime)

## Create Plot 1
par(mfrow=c(1,1))
## windows(480,480)
with(data3,hist(Global_active_power,main="Global Active Power",
               xlab="Global Active Power (kilowatts)", col="red"))
dev.copy(png,file="plot1.png") ## default pixel (width=480, height=480)
dev.off()
