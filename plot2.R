# extract Date column===================
day <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", rep("NULL", 8)))

# find index of requested dates
tmp_read_start <- grep("1/2/2007", day$Date, fixed = TRUE)[1]
tmp_read_end <- grep("3/2/2007", day$Date, fixed = TRUE)[1]

# extract data==========================

## read header first
## read data with skipped lines (will lose header)
## reattach header
header <- read.table("./household_power_consumption.txt", header = FALSE, sep =';', nrows = 1, stringsAsFactors = FALSE)
data <- read.table("./household_power_consumption.txt", header = FALSE, sep =';', skip=tmp_read_start, nrows=tmp_read_end-tmp_read_start)
colnames(data) <- unlist(header)

# convert Date
library(dplyr)
data2 <- mutate(data, DayTmp = paste(Date,Time))   # merge Date and Time
data2 <- mutate(data2, DayFormat = as.POSIXct(strptime(DayTmp, "%d/%m/%Y %H:%M:%S")))   # convert to Formatted Date

# plot2=================================
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA)
plot(data2$Global_active_power ~ data2$DayFormat, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(data2$Global_active_power ~ data2$DayFormat)
dev.off()