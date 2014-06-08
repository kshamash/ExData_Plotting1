#PLOT 4


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


png("plot4.png", width=400, height=400)
#set the parameters: 2x2 grid, fill columnwise, inner and outer margins
par(mfcol = c(2, 2),  mar =  c(1,4, 4, 1, oma = c(0, 0, 0, 0))
with(subset, {
  #Plot1
  plot(Date, Global_active_power, type="n", main="", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Date, Global_active_power)
  
  #Plot2
  plot(Date, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(Date, Sub_metering_1)
  lines(Date, Sub_metering_2, col="red")
  lines(Date, Sub_metering_3, col="blue")
  legend("topright", pch="", bty="n", lwd=1.5, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Plot3
  plot(Date, Voltage, type="n", ylab="Voltage", xlab="datetime")
  lines(Date, Voltage)
  
  #Plot4
  plot(Date, Global_reactive_power, xlab="datetime", ylab="Globa_reactive_power", type="n")
  lines(Date, Global_reactive_power)
})
dev.off()