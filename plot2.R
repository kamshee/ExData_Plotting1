## EDA week 1 project
## Plot 2

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

## Create Plot 2
with(data3,plot(datetime,Global_active_power, type="l", lty=1,
        xlab="", ylab="Global Active Power (kilowatts)"))
dev.copy(png,file="plot2.png")
dev.off()



