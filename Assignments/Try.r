setwd('C:/Users/Jiawei Liang/Documents/WeChat Files/wxid_ob6tgcp1ldju22/FileStorage/File/2022-10')
library(tidyverse)
library(lubridate)

# read in all csv files
EPA_PM_2018 <- read.csv("EPAair_PM25_NC2018_raw.csv", header = TRUE, sep = ",")
EPA_PM_2019 <- read.csv("EPAair_PM25_NC2019_raw.csv", header = TRUE, sep = ",")
EPA_o3_2018 <- read.csv("EPAair_O3_NC2018_raw.csv", header = TRUE, sep = ",")
EPA_o3_2019 <- read.csv("EPAair_O3_NC2019_raw.csv", header = TRUE, sep = ",")

EPA_PM_2018$Date = as.Date(EPA_PM_2018$Date, format = "%m/%d/%Y")
EPA_PM_2019$Date = as.Date(EPA_PM_2019$Date, format = "%m/%d/%Y")
EPA_o3_2018$Date = as.Date(EPA_o3_2018$Date, format = "%m/%d/%Y")
EPA_o3_2019$Date = as.Date(EPA_o3_2019$Date, format = "%m/%d/%Y")

EPA_PM_2018$AQS_PARAMETER_DESC <- "PM2.5"
EPA_PM_2019$AQS_PARAMETER_DESC <- "PM2.5"

#7
colnames(EPA_PM_2019)<-colnames(EPA_PM_2018)<-colnames(EPA_o3_2019)<-colnames(EPA_o3_2018)
All_Four_data <-rbind(EPA_PM_2019,EPA_PM_2018,EPA_o3_2019,EPA_o3_2018)

common_sites <- c("Linville Falls", "Durham Armory", "Leggett", "Hattie Avenue", "Clemmons Middle", "Mendenhall School", "Frying Pan Mountain", "West Johnston Co.", "Garinger High School", "Castle Hayne", "Pitt Agri. Center", "Bryson City", "Millbrook School")

EPA_o3PM25_1819 <- All_Four_data[All_Four_data$Site.Name %in% common_sites,]%>%
group_by(Date, Site.Name, COUNTY, AQS_PARAMETER_DESC)%>% 
summarise(AQI = mean(DAILY_AQI_VALUE), Latitude = mean(SITE_LATITUDE), Longitude = mean(SITE_LONGITUDE))

EPA_o3PM25_1819$Month <- month(EPA_o3PM25_1819$Date)
EPA_o3PM25_1819$Year <- year(EPA_o3PM25_1819$Date)
