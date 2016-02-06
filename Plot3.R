#read in file
srd<- read.table("household_power_consumption.txt", header=TRUE,sep=";")
library(dplyr)

#filter to only include relevant dates
test.date <- c("1/2/2007", "2/2/2007")
filt.data <- filter(srd, Date %in% test.date)

#convert factor to numeric
filt.data$Sub_metering_1 <- as.numeric(as.character(filt.data$Sub_metering_1))
filt.data$Sub_metering_2 <- as.numeric(as.character(filt.data$Sub_metering_2))
filt.data$Sub_metering_3 <- as.numeric(as.character(filt.data$Sub_metering_3))

#combine date and time in one column
filt.data$DateTime <- strptime(paste(filt.data$Date, filt.data$Time), "%d/%m/%Y %H:%M:%S")

#Create plot and save as PNG file
with(filt.data, plot(DateTime, Sub_metering_1, type="l", ylab = "Energy sub metering",
                     xlab = ""))
points(filt.data$DateTime, filt.data$Sub_metering_3, col = "blue", type="l")
points(filt.data$DateTime, filt.data$Sub_metering_2, col = "orange", type="l")
legend("topright", pch = "_", col = c("black", "orange", "blue"), legend = 
         c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()