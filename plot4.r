## Set working directory in documents folder from default directory on my computer
# setwd("Coursera Exploritory Analysis")
## Create assignment folder
# if(!dir.exists("Assignment 1")){dir.create("Assignment 1")}
# setwd("Assignment 1")
## check if directory exists, if not, create it.

if(!dir.exists("./data")){dir.create("./data")}
if(!file.exists("./data/assignmentdataset.zip")){
    dataURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(dataURL,"./data/assignmentdataset.zip", method="libcurl")
	logstring <- gsub(":",".",paste0("./data/assignmentdataset obtained on ",date()))
    unzip("./data/assignmentdataset.zip", exdir="./data")
    
    file.create(logstring)
}
## Load libraries nneeded for analysis
library(lubridate) # Avoid all date problems

## Data file name must be known prior to running this
U<-read.csv("./data/household_power_consumption.txt", header = TRUE,sep=";",na.strings = c("","?","NA"))

U$Date <- dmy(U$Date)
U$Time <- hms(U$Time)
U<- U[U$Date==ymd('2007-02-01')| U$Date==ymd('2007-02-02'),]

## Create weekday factors
U$Days <- as.factor(weekdays(U$Date))
  
## Plot 4
  ## Turn on PNG graphics device
  png(filename = "./output/Plot 4.png")
  
  ## Set up grid
  par(mfrow=c(2,2))
  
  
  #(1,1)
  plot(U$Global_active_power,type="l",main="",ylab = "Global Active Power (kilowatts)",xaxt = "n", xlab="")
  axis(1,at=c(0,2885/2,2885),labels=c("Thu","Fri","Sat")) # On x-axis plot days at appropriaate values based on max x
  #(1,2)
  plot(U$Voltage,type="l",main="",ylab = "Voltage",xaxt = "n", xlab="datetime")
  axis(1,at=c(0,2885/2,2885),labels=c("Thu","Fri","Sat")) # On x-axis plot days at appropriaate values based on max x
  #(2,1)
  plot(U$Sub_metering_1,type="l",main="",ylab = "Energy sub metering",xaxt = "n", xlab="")
  axis(1,at=c(0,2885/2,2885),labels=c("Thu","Fri","Sat")) # On x-axis plot days at appropriaate values based on max x
  lines(U$Sub_metering_2,col="red")
  lines(U$Sub_metering_3,col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = c(1,1,1),lwd=c(1,1,1),bty="n")
  
  #(2,2)
  plot(U$Global_reactive_power,type="l",main="",xaxt = "n", xlab="datetime",ylab = "Global_reactive_power")
  axis(1,at=c(0,2885/2,2885),labels=c("Thu","Fri","Sat")) # On x-axis plot days at appropriaate values based on max x
  
  ## Disconnecct from the graphics device
  dev.off()