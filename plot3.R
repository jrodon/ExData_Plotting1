# This assumes that the data file resides in the working directory
# Read the data, to save memory and make it faster we read just the 2 relevant days.

require(data.table)
housePower <- fread("./household_power_consumption.txt", 
                    sep = ";", 
                    na.strings = "?",
                    skip = "1/2/2007",
                    nrows = 2880)

colnames(housePower) <- colnames(fread("./household_power_consumption.txt", 
                                       sep = ";", 
                                       na.strings = "?",
                                       nrows = 0))

# Creates the plot

xaxis <- strptime(paste(housePower$Date,housePower$Time), format = "%d/%m/%Y %H:%M:%S")

plot(xaxis, housePower$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

lines(xaxis, housePower$Sub_metering_1)
lines(xaxis, housePower$Sub_metering_2, col = "red")
lines(xaxis, housePower$Sub_metering_3, col = "blue")

legend("topright", legend = colnames(housePower)[7:9], 
       lty = "solid", 
       y.intersp = 0.7,
       col = c("black", "red", "blue"))

dev.copy(png, filename = "plot3.png")
dev.off()
