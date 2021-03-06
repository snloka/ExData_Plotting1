install.packages("RCurl")
library(RCurl)
install.packages("dplyr")
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(fileUrl, destfile = "./household_power_consumption.zip", method="libcurl")

#unz(description="household_power_consumption.zip", filename="household_power_consumption.txt", open="", encoding=getOption("encoding"))

unzip("household_power_consumption.zip")

#con <- gzfile("household_power_consumption.zip")
powerData <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings = c("NA", "?"), 
		      colClasses=c("character", "character", "numeric", "numeric", "numeric", 
				   "numeric", "numeric", "numeric", "numeric")
		      )
str(powerData)

powerData2 <- filter(powerData, as.Date(Date, "%d/%m/%Y") %in% as.Date(c("01/02/2007", "02/02/2007"),"%d/%m/%Y" ))
powerData2 <- mutate(powerData2, day = as.character(as.Date(Date, "%d/%m/%Y"), "%a"))
powerData2 <- mutate(powerData2, datetime = paste(Date, Time) )
str(powerData2)

#powerData2 <- powerData[as.Date(powerData$Date) %in%   as.Date(c("01-02-2007", "02-02-2007")), ]

library(datasets)

#hist(powerData2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(Kilowatts)")
#with(powerData2, plot(as.numeric(strptime(Time,"%H:%M:%S"), "%M") , Global_active_power, type="l") )
#with(powerData2, plot(strptime(Time,"%H:%M:%S") , Global_active_power, type="l") )
#with(powerData2, plot((strptime(datetime, "%d/%m/%Y %H:%M:%S")) , c(Sub_metering_1, sub_metering_2, Sub_metering_3), type="l", ylab="Energey sub metering" , xlab="" ) )
with(powerData2, plot((strptime(datetime, "%d/%m/%Y %H:%M:%S")) , Sub_metering_1, type="l", ylab="Energey sub metering" , xlab="" , col="black") )
with(powerData2, points((strptime(datetime, "%d/%m/%Y %H:%M:%S")) , Sub_metering_2, type="l", col="red") )
with(powerData2, points((strptime(datetime, "%d/%m/%Y %H:%M:%S")) , Sub_metering_3, type="l", col="blue") )
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()



