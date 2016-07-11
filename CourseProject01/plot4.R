library(sqldf)
library(datasets)
# Read only lines from household_power_consumption.txt where Date is '1/2/2007' or '2/2/2007'
hpc <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")

# Create column datetime from columns Date and Time - %d/%m/%Y %H:%M:%S
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# PNG File - PS: dev.copy didn't autofit legend in the box
png("plot4.png", width=480, height=480)

# 4 plots in 2 rows and 2 columns
par(mfrow = c(2, 2))

# Draw Plot 1
plot(hpc$datetime, hpc$Global_active_power, ylab = "Global Active Power", xlab = NA, type = "l")

# Draw Plot 2
plot(hpc$datetime, hpc$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

# Draw Plot 3
plot(hpc$datetime, hpc$Sub_metering_1, ylab = "Energy sub metering", xlab = NA, type = "l", col = "black")
lines(hpc$datetime,hpc$Sub_metering_2, col = "red")
lines(hpc$datetime,hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# Draw Plot 4
plot(hpc$datetime, hpc$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off() ## Closing the PNG device