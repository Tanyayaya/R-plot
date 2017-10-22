#set the file directory as the working directory
setwd("C:/R/project")
#read the data
data<-readRDS("summarySCC_PM25.rds")
#subset the data about the emission,cities and the year
data_year<-data.frame(data$year,data$fips,data$Emissions)
#aggregate the data in each year by sum
data_year<-aggregate(data_year$data.Emissions,by=list(year=data_year$data.year,
                                                      city=data_year$data.fips),sum)
baltimore<-subset(data_year,city=="24510")
#make the plot
png( filename = "plot2.png", width = 480, height = 480 )
with(baltimore,plot(year,x,xlab = "year",ylab = "emission",
                    main = "Emissions in Baltimore from 1999 to 2008",type = "b"))
dev.off()