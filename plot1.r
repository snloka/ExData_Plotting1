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
str(powerData2)

#powerData2 <- powerData[as.Date(powerData$Date) %in%   as.Date(c("01-02-2007", "02-02-2007")), ]

library(datasets)

hist(powerData2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(Kilowatts)")
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()



