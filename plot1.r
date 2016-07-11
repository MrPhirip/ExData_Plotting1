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

## Plot 1
  ## Turn on PNG graphics device
  png(filename = "./output/plot1.png")
  ## Plot graphic in teh graphics device
  hist(U$Global_active_power,col = "red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
  ## Disconnecct from the graphics device
  dev.off()