#==============================================================================
# R script (plot1.R):
# Notes:
# 1. The script only tested on windows 8.1 with R Studio only.
#==============================================================================

#------------------------------------------------------------------------------
# Define course project working directory
#------------------------------------------------------------------------------
setwd("D:/R/MOOC/")
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
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
#------------------------------------------------------------------------------
# Creating Plot1 PNG File
#------------------------------------------------------------------------------

plot1 <- function() {
  message('Creating plot1.png....')
  png("plot1.png", width = 480, height = 480)
  hist(data$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}

plot1()
