Sys.setlocale(category = "LC_ALL", locale = "english")

#Read the file in
household_power_consumption <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")

#Clean up the file, so only having the data, that is needed
data <- data.frame(
  subset(
    household_power_consumption,
    household_power_consumption$Date %in% c("1/2/2007", "2/2/2007") & household_power_consumption$Global_active_power != "?",
    c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  )
)

# Convert all columns as they are needed
data <- data.frame(
  Global_active_power = as.numeric(data$Global_active_power),
  Global_reactive_power = as.numeric(data$Global_reactive_power),
  Voltage = as.numeric(data$Voltage),
  Sub_metering_1 = as.numeric(data$Sub_metering_1),
  Sub_metering_2 = as.numeric(data$Sub_metering_2),
  Sub_metering_3 = as.numeric(data$Sub_metering_3),
  Datetime = strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
)


#Open PNG device
png(filename = "plot4.png", width = 480, height = 480)

# Create a 4 frame "window"
par(mfrow = c(2, 2))

# Create the 4 plots and put them into the created "window"
# topleft
plot(
  data$Datetime,
  data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# topright
plot(
  data$Datetime,
  data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# bottomleft
plot(
  data$Datetime, data$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red", "blue"), lty = 1, bty = "n")

# bottomright
plot(
  data$Datetime,
  data$Global_reactive_power,
  type="l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

# Close device
dev.off()