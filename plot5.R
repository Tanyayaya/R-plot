#set the file directory as the working directory
setwd("C:/R/project")
#read the data
data<-readRDS("summarySCC_PM25.rds")
code<-readRDS("Source_Classification_Code.rds")
#subset the data needed
data_year<-data.frame(data$year,data$fips,data$SCC,data$Emissions)
#subset the data from motorcycles from Baltimore
code$Short.Name<-as.character(code$Short.Name)
ismotor<-grep("Motor",x=code$Short.Name,fixed = TRUE)
code_motor<-as.character(code[,1][ismotor])
data_year$data.SCC<-as.character(data_year$data.SCC)
motor<-subset(data_year,data.SCC%in%code_motor&data.fips=="24510")
#aggregate the data in each year by sum
motor<-aggregate(motor$data.Emissions,by=list(year=motor$data.year,
                                              SCC=motor$data.SCC,
                                              city=motor$data.fips),sum)
#sum the data in each year
library(reshape2)
motor<-melt(motor,id=c("year","SCC","city"))
motor<-dcast(motor,year~variable,fun.aggregate = sum,na.rm=T)
#make the plot
png( filename = "plot5.png", width = 480, height = 480 )
plot(motor$year,motor$x,xlab = "year",ylab = "emissions from motor vehicles",
     main="Emissions from Motorcycles in Baltimore")
dev.off()