#PLOT 1


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


#open the png device and draw the plot
png("plot1.png", width=400, height=400)
#set color, title and labels
hist(subset$"Global_active_power", col="red", main="Global Active Power", xlab="Global active power (kilowatts)", ylab="Frequency")
dev.off()