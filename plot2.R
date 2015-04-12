## Mark Dwyer
## 12-Aug-2015
## plot2.R

## clear workspace
rm(list = ls())

## define data classes
dclasses       <-c("character","character","numeric"            ,"numeric",              "numeric","numeric"         ,"numeric"       ,"numeric"       ,"numeric")
names(dclasses)<-c("Date"     ,"Time"     ,"Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
## read data
data <-read.table("household_power_consumption.txt",colClasses=dclasses,sep=";", header=TRUE,na.strings="?",nrows=2075259)
## subset to two days
twodays <-subset(data, subset = Date %in% c("2/2/2007","1/2/2007"))

## date/time variable
dt <- as.POSIXct(paste(twodays$Date, twodays$Time), format="%d/%m/%Y %H:%M:%S")

## isolate GAP
gap<-as.numeric(as.character(twodays$Global_active_power))
## create time series
plot(dt,gap, type="l",ylab="Global Active Power (kilowatts)", xlab="")

## make png file
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
