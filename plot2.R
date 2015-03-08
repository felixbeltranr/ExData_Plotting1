##plot2.R
## Read the data set. Only dates from 2007-02-01 and 2007-02-02
data <- read.table("household_power_consumption.txt", sep=";", header=FALSE, na.strings = "?", 
                   col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                   skip=66637, nrows=2880)

## Create a "datetime" column with date time information
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Create plot and set the titles
plot(data$datetime, data$Global_active_power, 
     type="l", ylab="Global Active Power (kilowatts)", 
     xlab="")

## Copy the chart to disk
dev.copy(png, file="plot2.png")
dev.off()
## END