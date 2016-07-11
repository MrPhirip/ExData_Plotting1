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


## Plot 2
  ## Turn on PNG graphics device
  png(filename = "./output/plot2.png")

  ## Plot line chart
  plot(U$Global_active_power,type="l",main="",ylab = "Global Active Power (kilowatts)",xaxt = "n", xlab="")
  axis(1,at=c(0,2885/2,2885),labels=c("Thu","Fri","Sat")) # On x-axis plot days at appropriaate values based on max x
  
  ## Disconnecct from the graphics device
  dev.off()