## This first line will likely take a few seconds. Be patient!
setwd("/home/ruben/R")
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## find all SCC entries containing Coal -> rows contains the index positions of SCC entries containing "Coal"
rows_motor <- rowSums(apply(SCC, c(1,2), function(x) grepl("motor", x, ignore.case=TRUE) ))
## SCC values for motor => SCC[rows_motor>1, ]
SCC_motor <- SCC[rows_motor > 1,]
rows_vehicle <- rowSums(apply(SCC_motor, c(1,2), function(x) grepl("vehicle", x, ignore.case=TRUE) ))
## SCC Values for vehicle => SCC_coal[rows_vehicle>1, ]
SCC_motor_vehicle <- SCC_motor[rows_vehicle > 1, ]
PM25_motor_vehicle <- NEI[NEI$SCC %in% SCC_motor_vehicle$SCC, ]
total_PM25_motor_vehicle <- aggregate(Emissions ~ year, PM25_motor_vehicle, sum)
plot(total_PM25_motor_vehicle$year, total_PM25_motor_vehicle$Emissions, main ="Total PM25 Emissions through Motor Vehicles", xlab ="year", ylab = "PM25 Emissions (tons)")
dev.copy(png,file="../git/ExData_Plotting2/plot5.png", width=480, height=480)
dev.off()