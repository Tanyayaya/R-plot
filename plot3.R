#set the file directory as the working directory
setwd("C:/R/project")
#read the data
data<-readRDS("summarySCC_PM25.rds")
#subset the data about the emission,cities and the year
data_year<-data.frame(data$year,data$fips,data$type,data$Emissions)
#aggregate the data in each year by sum
data_year<-aggregate(data_year$data.Emissions,by=list(year=data_year$data.year,
                                                      city=data_year$data.fips,
                                                      type=data_year$data.type),sum)
baltimore<-subset(data_year,city=="24510")
#make the plot
library(ggplot2)
png(filename = "plot3.png")
plot3<-qplot(year,x,data=baltimore,facets=.~type,ylab="Emissions")
print(plot3)
dev.off()