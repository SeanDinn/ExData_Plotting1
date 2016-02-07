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
filt.data$Global_active_power <- as.numeric(as.character(filt.data$Global_active_power))
filt.data$Global_reactive_power <- as.numeric(as.character(filt.data$Global_reactive_power))
filt.data$Voltage <- as.numeric(as.character(filt.data$Voltage))

#combine date and time in one column
filt.data$DateTime <- strptime(paste(filt.data$Date, filt.data$Time), "%d/%m/%Y %H:%M:%S")

#Create 4 plots 
par(mfrow = c(2,2), mar = c(4,4,1,1), oma = c(0,1,0,1), cex=0.75, cex.axis=0.75,
    cex.lab=0.75)
with(filt.data, {
  plot(filt.data$DateTime, filt.data$Global_active_power,type = "l", ylab = 
         "Global Active Power(kilowatts)", xlab="")  
  plot(filt.data$DateTime, filt.data$Voltage,type = "l", ylab = "Voltage",
       xlab="datetime") 
  plot(DateTime, Sub_metering_1, type="l", ylab = "Energy sub metering",
                     xlab = "")
  points(filt.data$DateTime, filt.data$Sub_metering_3, col = "blue", type="l")
  points(filt.data$DateTime, filt.data$Sub_metering_2, col = "orange", type="l")
  legend("topright", col = c("black", "orange", "blue"), legend = 
         c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty="n", cex=0.75,
         inset=0.09, lty=1)
  plot(filt.data$DateTime, filt.data$Global_reactive_power,type = "l", ylab =
         "Global_reactive_power", xlab="datetime") 
})

#plot and save as PNG file
dev.copy(png, file = "plot4.png")
dev.off()