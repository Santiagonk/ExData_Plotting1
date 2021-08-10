
# Loading Data ------------------------------------------------------------
library(dplyr)

df <- read.table("data/household_power_consumption.txt", 
                header =TRUE,
                #nrows=100,
                sep =";",
                na.strings = "?")

str(df)
x <- paste(df$Date,df$Time)
df$Time <-strptime(x,format = "%d/%m/%Y %H:%M:%S", tz="")
df$Date <- as.Date(df$Date,"%d/%m/%Y")     
df <- subset(df, Date == "2007-02-01" | Date == "2007-02-02")
head(df)


# 1. Plot Global Active Power ---------------------------------------------

hist(df$Global_active_power, 
     breaks = 20, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power"
     )
dev.copy(png, file = "figure/Plot1.png")
dev.off()


# 2. Plot Global Active Power Time Series ----------------------------------

plot(df$Time, df$Global_active_power, 
     type = "n", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(df$Time, df$Global_active_power)
title("Global Active Power")
dev.copy(png, file = "figure/Plot2.png")
dev.off()


# 3. Plot Sub-Metering Time Series ----------------------------------------
par(mfrow = c(1,1), mar = c(4,4,2,1), oma=c(0,0,2,0))
plot(df$Time, df$Sub_metering_1, 
     type = "n", 
     xlab = "",
     ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_1, col = "black")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1, cex = 0.6, xjust = 0)
dev.copy(png, file = "figure/Plot3.png")
dev.off()
?legend

# 4. Multi-Plot -----------------------------------------------------------

par(mfrow = c(2,2), mar = c(4,4,2,1), oma=c(0,0,2,0))

# plot 1
plot(df$Time, df$Global_active_power, 
     type = "n", 
     xlab = "",
     ylab = "Global Active Power")
lines(df$Time, df$Global_active_power)

# plot 2
plot(df$Time, df$Voltage, 
     type = "n", 
     xlab = "datetime",
     ylab = "Voltaje")
lines(df$Time, df$Voltage)

#plot 3
plot(df$Time, df$Sub_metering_1, 
     type = "n", 
     xlab = "",
     ylab = "Energy sub metering")
lines(df$Time, df$Sub_metering_1, col = "black")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1, cex = 0.4)

#plot 4
plot(df$Time, df$Global_reactive_power, 
     type = "n", 
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(df$Time, df$Global_reactive_power)

dev.copy(png, file = "figure/Plot4.png")
dev.off()
