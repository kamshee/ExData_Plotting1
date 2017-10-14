## EDA week 1 project
## Plot 3

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
data3$Date <- as.Date(data3$Date, "%d/%m/%Y")

## Create and add datetime column
datetime <-strptime(paste(data3$Date,data3$Time, sep=" "),"%Y-%m-%d %H:%M:%S")
data3 <- cbind(data3,datetime)

#Create Plot 3
with(data3,{
        plot(datetime,Sub_metering_1, type="l", lty=1,
             xlab="", ylab="Energy sub metering")
        lines(datetime,Sub_metering_2, type="l", lty=1,col="red")
        lines(datetime,Sub_metering_3, type="l", lty=1,col="blue")
        })

#Add legend
legend("topright", lty=1, col=c("black","red","blue"),
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file="plot3.png")
dev.off()

