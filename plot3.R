#PLOT 3


#check if file exists. Otherwise download and unzip
if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method="curl")
  unzip("household_power_consumption.zip")
}


#read in the data from the text file
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

#subset the desired dates
subset <- data[data$"Date"=="1/2/2007" | data$"Date"=="2/2/2007", ]

#Convert the date and time character fields to a single Date object
subset$"Date" <- paste(subset$"Date", subset$"Time", sep = ";")
subset$"Date" <- strptime(subset$Date, format="%d/%m/%Y;%H:%M:%S")
subset$"Time" <- NULL


png("plot3.png", width=400, height=400)
with(subset, {
  #construct a plot with no points
  plot(Date, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  #add lines in different colors for the 3 submeterings
  lines(Date, Sub_metering_1)
  lines(Date, Sub_metering_2, col="red")
  lines(Date, Sub_metering_3, col="blue")
  #add the legend
  legend("topright", pch="", lwd=1.5, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
         })
dev.off()