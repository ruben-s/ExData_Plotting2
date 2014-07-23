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
PM25_mv_cities <- PM25_motor_vehicle[PM25_motor_vehicle$fips=="24510" | PM25_motor_vehicle$fips=="06037", ]
total_PM25_mv_cities <- aggregate(Emissions ~ fips + year, PM25_mv_cities, sum)
ggplot() + geom_line(data = total_PM25_mv_cities, aes(x=year,y=Emissions)) + facet_grid(fips ~ .) + labs(title="PM25 Emission Evolution")
dev.copy(png,file="../git/ExData_Plotting2/plot6.png", width=480, height=480)
dev.off()