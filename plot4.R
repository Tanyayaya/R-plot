#set the file directory as the working directory
setwd("C:/R/project")
#read the data
data<-readRDS("summarySCC_PM25.rds")
code<-readRDS("Source_Classification_Code.rds")
#subset the data needed
data_year<-data.frame(data$year,data$SCC,data$Emissions)
#aggregate the data in each year by sum
data_year<-aggregate(data_year$data.Emissions,by=list(year=data_year$data.year,
                                                      SCC=data_year$data.SCC),sum)
#subset the data from coal combustion
code$EI.Sector<-as.character(code$EI.Sector)
iscoal<-grep("Coal",x=code$EI.Sector,fixed = TRUE)
code_coal<-as.character(code[,1][iscoal])
data_year$SCC<-as.character(data_year$SCC)
coal<-subset(data_year,SCC%in%code_coal)
#sum the data in each year
library(reshape2)
coal<-melt(coal,id=c("year","SCC"))
coal<-dcast(coal,year~variable,fun.aggregate = sum,na.rm=T)
#make the plot
png( filename = "plot4.png", width = 480, height = 480 )  
plot(coal$year,coal$x,xlab = "year",ylab="Emissions",type = "b",
     main = "Emissions from Coal Sources from 1999 to 2008")
dev.off()