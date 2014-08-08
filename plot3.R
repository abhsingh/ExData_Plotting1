# download the file if its not there, create directory, unzip
if (is.na(file.info("ExData_Plotting1")$isdir) || !(file.info("ExData_Plotting1")$isdir) ) {
  dataFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dir.create("ExData_Plotting1")
  download.file(dataFile, "ExData_Plotting1/exdata-data-household_power_consumption.zip")
  unzip("ExData_Plotting1/exdata-data-household_power_consumption.zip", exdir="Exdata_Plotting1")
}
# Set default for Date, so we can read the date column
library(Defaults)
setDefaults('as.Date.character', format = '%d/%m/%Y')
# Read the entire table
PCDF<-read.table("ExData_Plotting1/household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("Date", "character", rep("numeric", 7)), na.strings="?")
# Subset it here for the 2 dates, couldnt figure out how to do subsetting before reading the entire file
PCDF1<-PCDF[PCDF$Date == "1/2/2007" | PCDF$Date == "2/2/2007",]

# plot and copy to png
with(PCDF1, plot(strptime(paste(PCDF1[,1],PCDF1[,2]), "%Y-%m-%d %H:%M:%S"), PCDF1[,7], type="n", ylab="Energy sub metering", xlab=""))
points(strptime(paste(PCDF1[,1],PCDF1[,2]), "%Y-%m-%d %H:%M:%S"), PCDF1[,7], col="black", type="l")
points(strptime(paste(PCDF1[,1],PCDF1[,2]), "%Y-%m-%d %H:%M:%S"), PCDF1[,8], col="red", type="l")
points(strptime(paste(PCDF1[,1],PCDF1[,2]), "%Y-%m-%d %H:%M:%S"), PCDF1[,9], col="blue", type="l")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  lwd=1)

dev.copy(png, file = "ExData_Plotting1/plot3.png")  
dev.off()