## PLOT 2 CODE

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

#--------------------------------------------------------------------------------------------

# PLOT LINE GRAPH
# adjust outer margins to allow for adding plot label: "Plot 1"
par(oma = c(0, 1, 1, 0))

# plot
plot(twoDays$dateTime, twoDays$Global_active_power, type='l', ylab = "Global Active Power (Kilowatts)", xlab = "")

# Add plot label
mtext("Plot 2", side = 3, adj = 0, font = 2, outer = T, cex = 1.3, line = -1)

# copy screen device to a png file device and then close the device
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()


par(oma = c(0,0,0,0))
