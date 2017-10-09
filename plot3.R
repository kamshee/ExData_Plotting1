## EDA week 1 project
## Plot 3

library(data.table)
library(dplyr)

fileUrl <- 
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "dataset.zip")
unzip("dataset.zip")
data3 <- fread("./household_power_consumption.txt")

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

#Create Plot 3
with(data,{
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

