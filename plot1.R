##plot1.R
## Read the data set. Only dates from 2007-02-01 and 2007-02-02
data <- read.table("household_power_consumption.txt", sep=";", header=FALSE, na.strings = "?", 
                   col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                   skip=66637, nrows=2880)

## Create an histogram chart and set the titles
hist(data$Global_active_power, col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
## Copy the chart to disk
dev.copy(png, file="plot1.png")
dev.off()
## END