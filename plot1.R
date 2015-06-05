#filter data for faster loading in R using read.csv.sql
require(sqldf)
consumption <- read.csv.sql("household_power_consumption.txt",
                  sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                  header = TRUE, sep = ";")

#create plot 1
hist(consumption$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#copy plot to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()