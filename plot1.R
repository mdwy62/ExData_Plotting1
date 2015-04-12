## Mark Dwyer
## 12-Aug-2015
## plot1.R
## clear workspace
rm(list = ls())

## define data classes
dclasses       <-c("character","character","numeric"            ,"numeric",              "numeric","numeric"         ,"numeric"       ,"numeric"       ,"numeric")
names(dclasses)<-c("Date"     ,"Time"     ,"Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
## read data
data <-read.table("household_power_consumption.txt",colClasses=dclasses,sep=";", header=TRUE,na.strings="?")
## subset to two days
twodays <-subset(data, subset = Date %in% c("2/2/2007","1/2/2007"))
## isolate GAP
gap<-as.numeric(as.character(twodays$Global_active_power))
## create histogram
hist(gap,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
## make png file
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
