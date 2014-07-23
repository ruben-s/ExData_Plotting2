## This first line will likely take a few seconds. Be patient!
setwd("/home/ruben/R")
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## find all SCC entries containing Coal -> rows contains the index positions of SCC entries containing "Coal"
rows_coal <- rowSums(apply(SCC, c(1,2), function(x) grepl("coal", x, ignore.case=TRUE) ))
## SCC values for coal => SCC[rows_coal>1, ]
SCC_coal <- SCC[rows_coal > 1,]
rows_combustion <- rowSums(apply(SCC_coal, c(1,2), function(x) grepl("combustion", x, ignore.case=TRUE) ))
## SCC Values for combustion => SCC_coal[rows_combustion>1, ]
SCC_coal_combustion <- SCC_coal[rows_combustion > 1, ]
PM25_coal_combustion <- NEI[NEI$SCC %in% SCC_coal_combustion$SCC, ]
total_PM25_coal_combustion <- aggregate(Emissions ~ year, PM25_coal_combustion, sum)
plot(total_PM25_coal_combustion$year, total_PM25_coal_combustion$Emissions, main ="Total PM25 Emissions through Coal Combustion", xlab ="year", ylab = "PM25 Emissions (tons)")
dev.copy(png,file="../git/ExData_Plotting2/plot4.png", width=480, height=480)
dev.off()