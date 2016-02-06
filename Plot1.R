#read in file
srd<- read.table("household_power_consumption.txt", header=TRUE,sep=";")
library(dplyr)

#filter to only include relevant dates
test.date <- c("1/2/2007", "2/2/2007")
filt.data <- filter(srd, Date %in% test.date)

#convert factor type to numeric
filt.data$Global_active_power <- as.numeric(as.character(filt.data$Global_active_power))

#Create histogram and save as PNG file
hist(filt.data$Global_active_power, col = "red", main = "Global Active Power",
xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()