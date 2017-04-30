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

with(housePower, hist(Global_active_power, 
                      col = "red",
                      main = "Global Active Power",
                      xlab = "Global Active Power (kilowatts)"))

dev.copy(png, filename = "plot1.png")
dev.off()
