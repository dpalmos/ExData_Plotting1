#filter data for faster loading in R using read.csv.sql
require(sqldf)
consumption <- read.csv.sql("household_power_consumption.txt", sql = "select * from file 
                            where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE,
                            sep = ";")

#convert class of date and time variables, combine in new column called datetime
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
consumption$datetime <- as.POSIXct(paste(consumption$Date, consumption$Time), format="%Y-%m-%d %H:%M:%S")

#create plot 2
plot(consumption$datetime, consumption$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")

#copy plot to a PNG file
dev.copy(png, file = "plot2.png")
dev.off()