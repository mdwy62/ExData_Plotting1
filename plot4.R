## Mark Dwyer
## 12-Aug-2015
## plot4.R

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

## isolate GAP, voltage, reactive power
gap<-as.numeric(as.character(twodays$Global_active_power))
vlt<-as.numeric(as.character(twodays$Voltage))
rap<-as.numeric(as.character(twodays$Global_reactive_power))

## isolate sub metering
smn<-data.frame(twodays$Sub_metering_1,twodays$Sub_metering_2,twodays$Sub_metering_3)

## create time series
par(mfrow=c(2,2))

## gap plot 
plot(dt,gap, type="l",ylab="Global Active Power (kilowatts)", xlab="")

## vlt plot
plot(dt,vlt, type="l",ylab="Voltage", xlab="datetime")

## sub-metering plot
plot(dt,smn[,1],ylim=range(smn),type="l",col="black",ylab="",xlab="")
par(new = TRUE)
plot(dt,smn[,2],ylim=range(smn),type="l",col="red"  ,ylab="",xlab="",axes=FALSE)
par(new = TRUE)
plot(dt,smn[,3],ylim=range(smn),type="l",col="blue" ,axes=FALSE,ylab="Energy sub metering", xlab="")
legend("topright",col=c("black","red","blue"),lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## rap plot
plot(dt,rap, type="l",ylab="Global_reactive_power ", xlab="datetime")

## matplot doesn't handle dates correctly

## make png file
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
