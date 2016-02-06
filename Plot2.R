#read in file
srd<- read.table("household_power_consumption.txt", header=TRUE,sep=";")
library(dplyr)

#filter to only include relevant dates
test.date <- c("1/2/2007", "2/2/2007")
filt.data <- filter(srd, Date %in% test.date)

#convert factor type to numeric
filt.data$Global_active_power <- as.numeric(as.character(filt.data$Global_active_power))

#combine date and time in one column
filt.data$DateTime <- strptime(paste(filt.data$Date, filt.data$Time), "%d/%m/%Y %H:%M:%S")

#Create plot and save as PNG file
plot(filt.data$DateTime, filt.data$Global_active_power,type = "l", ylab = 
"Global Active Power(kilowatts)", xlab="")
dev.copy(png, file = "plot2.png")
dev.off()