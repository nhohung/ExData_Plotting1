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

# plot1=================================
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA)
with(data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()