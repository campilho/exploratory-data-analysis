library(sqldf)
library(datasets)
# Read only lines from household_power_consumption.txt where Date is '1/2/2007' or '2/2/2007'
hpc <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")

# Create column datetime from columns Date and Time - %d/%m/%Y %H:%M:%S
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# Draw Histogram
hist(hpc$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

# Copy Histogram to a PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off() ## Closing the PNG device