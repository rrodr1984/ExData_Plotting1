## Script file to generate plot3.png file

## Get full dataset from source file
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Format Date variable
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subset the data for only 2 days
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove data_full dataset
rm(data_full)

## Convert dates to Date/Time classes
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Generate Plot 3 as graph with 3 continuous line diagram
## with Datetime as X axis and the variables Sub_metering_1, Sub_metering_2 and Sub_metering_3 in watt-hour as Y axis
with(data, {
      plot(Sub_metering_1~Datetime, type="l",
           ylab="Energy sub metering", xlab="")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save the generated plot to "png" file fixing the height and width to 480 pixels
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()