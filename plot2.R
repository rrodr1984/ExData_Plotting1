## Script file to generate plot2.png file

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

## Generate Plot 2 as continuous line diagram
## with Datetime as X axis and the variable Global_active_power in kilowatts as Y axis
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

## Save the generated plot to "png" file fixing the height and width to 480 pixels
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()