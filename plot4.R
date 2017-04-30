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

# Setup for the plots

par(mfcol = c(2,2))
datetime <- strptime(paste(housePower$Date,housePower$Time), format = "%d/%m/%Y %H:%M:%S")

# Top left plot
plot(datetime, housePower$Global_active_power,
     xlab = "",
     ylab = "Global Active Power",
     type = "l")

# Bottom left plot
plot(datetime, housePower$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

lines(datetime, housePower$Sub_metering_1)
lines(datetime, housePower$Sub_metering_2, col = "red")
lines(datetime, housePower$Sub_metering_3, col = "blue")

legend("topright", legend = colnames(housePower)[7:9], 
       lty = "solid",
       y.intersp = 0.5,
       inset = c(-0.1,-0.05),
       seg.len = 1.5,
       bty = "n",
       col = c("black", "red", "blue"))

# Top right plot
plot(datetime, housePower$Voltage,
     type = "l",
     ylab = "Voltage")

# Bottom right plot
plot(datetime, housePower$Global_reactive_power,
     type = "l",
     ylab = colnames(housePower)[4]) 

dev.copy(png, filename = "plot4.png")
dev.off()
