## PLOT 3 CODE

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

#--------------------------------------------------------------------------------------

# PLOT LAYERD GRAPHS
# adjust outer margins to allow for adding plot label
par(oma = c(0, 1, 1, 0))

# plot
plot(twoDays$dateTime, twoDays$Sub_metering_1, type='l', col = "black", ylab = "Energy sub metering", xlab = "")

# Add layers
lines(twoDays$dateTime, twoDays$Sub_metering_2, col = "red")
lines(twoDays$dateTime, twoDays$Sub_metering_3, col = "blue")

# Add legend
legend("topright", lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7)

# Add plot label
mtext("Plot 3", side = 3, adj = 0, font = 2, outer = T, cex = 1.3, line = -1)

# # copy screen device to a png file device and then close the device (width increased to make room for legend's text )
dev.copy(png, file = "plot3.png", width = 590, height = 480) 
dev.off()


par(oma = c(0,0,0,0))
