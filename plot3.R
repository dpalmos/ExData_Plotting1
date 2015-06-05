#filter data for faster loading in R using read.csv.sql
require(sqldf)
consumption <- read.csv.sql("household_power_consumption.txt", sql = "select * from file 
                            where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE,
                            sep = ";")

#convert class of date and time variables, combine in new column called datetime
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
consumption$datetime <- as.POSIXct(paste(consumption$Date, consumption$Time), format="%Y-%m-%d %H:%M:%S")

#create plot 3, starting with sub_metering_1
plot(consumption$datetime, consumption$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")

#add sub_metering_2 and sub_metering_3 
lines(consumption$datetime, consumption$Sub_metering_2, col="red")
lines(consumption$datetime, consumption$Sub_metering_3, col="blue")

#add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 2, cex = 0.8, y.intersp = 0.8)

#copy plot to a PNG file
dev.copy(png, file = "plot3.png")
dev.off()