## This first line will likely take a few seconds. Be patient!
setwd("/home/ruben/R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
total_PM25 <- aggregate(Emissions ~ year, NEI, sum )
plot(total_PM25$year, total_PM25$Emissions,main ="Total PM25 Emissions over time", xlab ="year", ylab = "PM25 Emissions (tons)")
dev.copy(png,file="../git/ExData_Plotting2/plot1.png", width=480, height=480)
dev.off()