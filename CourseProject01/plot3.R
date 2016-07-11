library(sqldf)
library(datasets)
# Read only lines from household_power_consumption.txt where Date is '1/2/2007' or '2/2/2007'
hpc <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", eol = "\n")

# Create column datetime from columns Date and Time - %d/%m/%Y %H:%M:%S
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# PNG File - PS: dev.copy didn't autofit legend in the box
png("plot3.png", width=480, height=480)

# Draw Plot
plot(hpc$datetime, hpc$Sub_metering_1, ylab = "Energy sub metering", xlab = NA, type = "l", col = "black")
lines(hpc$datetime,hpc$Sub_metering_2, col = "red")
lines(hpc$datetime,hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() ## Closing the PNG device