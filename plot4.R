##plot4.R
## Read the data set. Only dates from 2007-02-01 and 2007-02-02
data <- read.table("household_power_consumption.txt", sep=";", header=FALSE, na.strings = "?", 
                   col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                               "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                   skip=66637, nrows=2880)

## Create a "datetime" column with date time information
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Create a new dataset with the information I need to plot
newdata <- data.frame(value=c(data$Sub_metering_1, data$Sub_metering_2, 
                              data$Sub_metering_3), 
                      datetime=c(data$datetime, data$datetime, 
                                 data$datetime), 
                      label=c(rep("Sub_metering_1", length(data$datetime)),
                              rep("Sub_metering_2", length(data$datetime)),
                              rep("Sub_metering_3", length(data$datetime))))

## Set the canvas for 4 plots
par(mfcol=c(2, 2))

## Create first plot
plot(data$datetime, data$Global_active_power, 
     type="l", ylab="Global Active Power", 
     xlab="")
####################################################################

## Create second plot and set the titles
plot(newdata$datetime, newdata$value, 
     type="n", ylab="Energy sub metering", 
     xlab="")
## Plot sub metering 1
with(subset(newdata, label=="Sub_metering_1"), 
     points(datetime, value, col="black", type="l"))
## Plot sub metering 2
with(subset(newdata, label=="Sub_metering_2"), 
     points(datetime, value, col="red", type="l"))
## Plot sub metering 3
with(subset(newdata, label=="Sub_metering_3"), 
     points(datetime, value, col="blue", type="l"))
## Set legends
legend("topright", lty=1, bty="n", cex=0.7, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/legend.html
####################################################################

## Create third plot and set the titles
plot(data$datetime, data$Voltage, 
     type="l", ylab="Voltage", 
     xlab="datetime")
####################################################################

## Create fourth plot and set the titles
plot(data$datetime, data$Global_reactive_power, 
     type="l", ylab="Global_reactive_power", 
     xlab="datetime")
####################################################################

## Copy the chart to disk
dev.copy(png, file="plot4.png")
dev.off()
## END