## This first line will likely take a few seconds. Be patient!
setwd("/home/ruben/R")
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
PM25_baltimore_city <- NEI[NEI$fips=="24510", ]
total_PM25_baltimore_city <- aggregate(Emissions ~ type + year, PM25_baltimore_city, sum)
ggplot() + geom_line(data = total_PM25_baltimore_city, aes(x=year,y=Emissions)) + facet_grid(type ~ .) + labs(title="PM25 Emission Evolution @ Baltimore City/Type of Source")
dev.copy(png,file="../git/ExData_Plotting2/plot3.png", width=480, height=480)
dev.off()