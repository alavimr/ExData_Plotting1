## PLOT 4 CODE

#clear the working space
rm(list=ls())
# set working directory
setwd("~/Coursera//DataScience/ExpData/Project1/")

# load packages
library(data.table)
library(dplyr)

# fast-read the text data file stored in the working directory 
data <- fread("household_power_consumption.txt", sep =";", na.string = "?", header =TRUE)

# filter selected days
selectedDays <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

# Add a variable to the selected data to make a new table
twoDays <- mutate(selectedDays, dateTime = paste(selectedDays$Date, selectedDays$Time))

# Transform data.table to a data.frame
twoDays <- data.frame(twoDays)

# Reformat the character strings in the variable dateTime to POSIXlt
twoDays$dateTime <- strptime(twoDays$dateTime, format = "%d/%m/%Y %H:%M:%S")

#-------------------------------------------------------------------------------------------

# PLOT MULTIPLE PANEL GRAPHS
# adjust outer margins to allow for adding plot label
par(oma = c(0, 1, 1, 0))
# set 2 x 2 panels (fill by row)
par(mfrow=c(2, 2))
# set panel margins
par(mar = c(4.9, 4.2, 2.8, 2))

# Plot panel 1
plot(twoDays$dateTime, twoDays$Global_active_power, type='l', ylab = "Global Active Power", xlab = "")

# Plot panel 2
plot(twoDays$dateTime, twoDays$Voltage, type='l', ylab = "Voltage", xlab = "datetime")

# Plot panel 3
plot(twoDays$dateTime, twoDays$Sub_metering_1, type='l', col = "black", ylab = "Energy sub metering", xlab = "")
# add layers
lines(twoDays$dateTime, twoDays$Sub_metering_2, col = "red")
lines(twoDays$dateTime, twoDays$Sub_metering_3, col = "blue")
# add legend
legend("topright", lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty ="n", cex = 0.7)

# Plot panel 4
plot(twoDays$dateTime, twoDays$Global_reactive_power, type='l', xlab = "datetime", ylab = "Global_reactive_power")

# Add plot label
mtext("Plot 4", side = 3, adj = 0, font = 2, outer = T, cex = 1.3, line = -1)

# copy screen device to a png file device and then close the device (width and length increased to make room for legend's text )
dev.copy(png, file = "plot4.png", width = 595, height = 595) 
dev.off()

par(mfrow = c(1,1))
par(oma = c(0,0,0,0))
par(mar = c(5.1, 4.1, 4.1, 2.1))