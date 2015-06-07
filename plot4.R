## Script file to generate plot4.png file

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

## Generate Plot 4 as 4 continuous line diagrams distributed in a matrix 2x2
## with Datetime as X axis
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,1,0))
with(data, {
      plot(Global_active_power~Datetime, type="l", 
           ylab="Global Active Power", xlab="")
      plot(Voltage~Datetime, type="l", 
           ylab="Voltage", xlab="datetime")
      plot(Sub_metering_1~Datetime, type="l", 
           ylab="Energy sub metering", xlab="")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='Blue')
      legend("top", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      # Use "top" to position better the legend in the generated png file.
      # To see better the legend in a screen device, please substitute "top" by "topright"
      plot(Global_reactive_power~Datetime, type="l", 
           ylab="Global_reactive_power",xlab="datetime")
})

## Save the generated plot to "png" file fixing the height and width to 480 pixels
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()