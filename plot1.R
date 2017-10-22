#set the file directory as the working directory
setwd("C:/R/project")
#read the data
data<-readRDS("summarySCC_PM25.rds")
#subset the data about the emission and the year
#aggregate the data in each year by sum
data_year<-data.frame(data$year,data$Emissions)
data_year<-aggregate(data_year$data.Emissions,by=list(year=data_year$data.year),sum)
#make the plot
png( filename = "plot1.png", width = 480, height = 480 )
with(data_year,plot(year,x,xlab = "years",ylab = "emissions",
                    main = "Emissions from 1999 to 2008",type="b"))
dev.off()