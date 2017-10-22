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
motor<-subset(data_year,data.SCC%in%code_motor)
motor$data.fips<-as.character(motor$data.fips)
motor<-subset(motor,data.fips=="24510"|data.fips=="06037")
library(stringr)
motor$data.fips<-str_replace_all(motor$data.fips,"24510","Baltimore")
motor$data.fips<-str_replace_all(motor$data.fips,"06037","Los Angeles")
#aggregate the data in each year by sum
motor<-aggregate(motor$data.Emissions,by=list(year=motor$data.year,
                                              SCC=motor$data.SCC,
                                              city=motor$data.fips),sum)
#sum the data in each year
library(reshape2)
motor<-melt(motor,id=c("year","SCC","city"))
motor<-dcast(motor,year+city~variable,fun.aggregate = sum,na.rm=T)
#make the plot
library(ggplot2)
png(filename = "plot6.png", width = 480, height = 480 )
plot6<-qplot(year,x,data=motor,facets=.~ city,
             xlab = "year",ylab = "emissions from motor vehicles",
             main="Emissions from Motorcycles in Baltimore and Los Angeles")
print(plot6)
dev.off()