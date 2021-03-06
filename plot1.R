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
png(filename = "plot1.png", width = 480, height = 480)

#Making the Histogram for Plot1
hist(
  data$Global_active_power,
  breaks = 12,
  col = "red",
  xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power"
)

# Close device
dev.off()