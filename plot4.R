#filter data for faster loading in R using read.csv.sql
require(sqldf)
consumption <- read.csv.sql("household_power_consumption.txt", sql = "select * from file 
                            where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE,
                            sep = ";")

#convert class of date and time variables, combine in new column called datetime
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
consumption$datetime <- as.POSIXct(paste(consumption$Date, consumption$Time), format="%Y-%m-%d %H:%M:%S")

#set order of plots and other graphical parameters
par(mfcol=c(2,2), mar = c(5,5,2,2), cex = 0.6, cex.axis = 0.8)

#multiple plots using data from one data frame
with(consumption, {
      
      #plot 1,1
      plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
      
      #plot 2,1
      plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
      lines(datetime, Sub_metering_2, col="red")
      lines(datetime, Sub_metering_3, col="blue")
      legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             col = c("black", "red", "blue"), lwd = 2, cex = 0.7, y.intersp = 0.7, bty = "n")
      
      #plot 1,2
      plot(datetime, Voltage, type = "l")
      
      #plot 2,2
      plot(datetime, Global_reactive_power, type = "l", lwd = 0.3)
      
})


#copy plot to a PNG file
dev.copy(png, file = "plot4.png")
dev.off()