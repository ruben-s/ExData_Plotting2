## This first line will likely take a few seconds. Be patient!
setwd("/home/ruben/R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
total_PM25_baltimore_city <- aggregate(Emissions ~ year, NEI[NEI$fips=="24510", ], sum )
plot(total_PM25_baltimore_city$year, total_PM25_baltimore_city$Emissions, main ="Total PM25 Emissions @ Baltimore City over time", xlab ="year", ylab = "PM25 Emissions (tons)")
dev.copy(png,file="../git/ExData_Plotting2/plot2.png", width=480, height=480)
dev.off()