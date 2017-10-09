## EDA week 1 project
## Plot 1

library(data.table)
library(dplyr)

fileUrl <- 
 "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "dataset.zip")
unzip("dataset.zip")
# ? Extract subset to cut down on processing time....
        #data1 <- read.table("./EDAwk1project/household_power_consumption.txt")
        #data2 <- read.csv("./EDAwk1project/household_power_consumption.txt")
data3 <- fread("./household_power_consumption.txt")
   # coerces '?' values to all character, so creates more work with as.numeric
##powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';')

data3$Date <- as.Date(data3$Date, "%d/%m/%Y")
firstday <- subset(data3,Date=="2007-2-1")
secondday <- subset(data3,Date=="2007-2-2")
totalday<-rbind(firstday,secondday)

data<-select(totalday, -Global_intensity)
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)

datetime<-paste(data$Date,data$Time)
datetime<-strptime(datetime,"%Y-%m-%d %H:%M:%S")
datetime<-as.data.frame(datetime)
data <- cbind(data,datetime)

## Create Plot 1
with(data,hist(Global_active_power,main="Global Active Power",
               xlab="Global Active Power (kilowatts)", col="red"))
dev.copy(png,file="plot1.png") ## default pixel width 480 x height 480
dev.off()
