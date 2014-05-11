# Load data --------------------------
    fileUrl              <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    filename             <- 'household_power_consumption.txt'
    download.file(fileUrl, destfile = "household_power_consumption.zip")
    dataset              <-  read.table(unz('household_power_consumption.zip', filename),header = TRUE, sep=';', stringsAsFactor = FALSE)
    # Convert Date from Character to Date type and subset data
    dataset$Date         <-  as.Date(strptime(dataset$Date, format = "%d/%m/%Y"))
    subdataset           <-  subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02" )
    # Obtain numeric values for column 3:9
    subdataset[3:9]      <-  sapply(3:9, function(x,y) {as.numeric(y[, x])}, y = subdataset)
    # Get weekday to count how many observations per day
    subdataset$weekday   <- weekdays(subdataset$Date)
    countt               <-  table(subdataset$weekday)
# Plotting -----------------------------
    png(filename = "plot3.png", width = 480, height = 480, units = "px")
    plot(subdataset$Sub_metering_1, col='black',  xaxt='n',
         type ='l', xlab ="", ylab = 'Energy sub metering')
    lines(subdataset$Sub_metering_2, col='red')
    lines(subdataset$Sub_metering_3, col='blue')
    axis(1, at=c(1, countt[1]+1, nrow(subdataset)+1), labels=c("Thu", "Fri", "Sat"))
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           box.lwd = 1, lty = rep(1, 3), col= c('black', 'red', 'blue'))
    dev.off()
