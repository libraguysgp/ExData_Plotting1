#==============================================================================
# R script (plot1.R):
# Notes:
# 1. The script only tested on windows 8.1 with R Studio only.
#==============================================================================

#------------------------------------------------------------------------------
# Define course project working directory
#------------------------------------------------------------------------------
setwd("~")
working.folder <- file.path(getwd(), '04_Exploratory_Data_Analysis')
dir.create((working.folder), showWarnings = FALSE)
setwd (working.folder)
data.file <- paste(working.folder, 'household_power_consumption.txt', sep = "/")

#------------------------------------------------------------------------------
# Store Web data source as data.url
#------------------------------------------------------------------------------
data.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

#==============================================================================
# Data set download function:
# 1. Downloads the Electric Power Consumption dataset if not exist locally
#==============================================================================
if (!file.exists(data.file)) {
  cat('Downloading the data set; this may take a few moments...')
  tmp <- tempfile()    
  head(tmp)
  download.file(data.url, tmp, cacheOK = FALSE)
  unzip(tmp)
  unlink(tmp)
}else {
  cat("Dataset already exist...")
}

#==============================================================================
# Load dataset: 
# 1. Loads dataset into a data.frame; 
#==============================================================================

#------------------------------------------------------------------------------  
# Load data from disk
#------------------------------------------------------------------------------
data<- read.table("household_power_consumption.txt", sep=";", header=T, quote= "", strip.white=TRUE, stringsAsFactors = F, na.strings= "?")

# Subsetting the full data to obtain the data related to two days: 
data<- subset(data, (data$Date == "1/2/2007" | data$Date== "2/2/2007"))

# Perform some conversions on the date and time values
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))

#------------------------------------------------------------------------------
# Creating Plot4 PNG File
#------------------------------------------------------------------------------
plot4 <- function() {
  message('Creating plot4.png....')
  png("plot4.png", width = 480, height = 480)
  # divide the plot device into four subplots
  par(mfrow=c(2,2)) 
  # Plot 1: top left
  plot(data$DateTime, data$Global_active_power, type="l", lwd=1, ylab="Global Active Power", xlab="") 
  # Plot 2: top right
  plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")   
  # Plot 3: bottom left
  plot(data$DateTime, data$Sub_metering_1, type="l", ylab= "Energy sub metering", xlab="")
  lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
  lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", col=c("black", "red", "blue")) 
  
  #Plot 4: bottom right
  plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")  
  dev.off()
  cat("plot4.png has been saved in", getwd())
}

plot4()
