################## Comparing death rates, Aboriginal and Torres Strait Islanders proportion of total population, Median income, Postgraduate and Certificate qualifications for 2011

#Import Data and create a data frame with Standardised Death Rate and Proportion of Indigenous Australians 
data1 <- read_excel("14100DS0002_2017-03.xlsx", skip = 9, col_names = FALSE)
data11 <- as.data.frame(data1)
Filtered1 <- data.frame("Suburbs" = c(data11[,2]), 
                        "Year" = c(data11[,3]),
                        "Standardised Death Rate (2011)" = as.numeric(as.character(c(data11[,77]))), 
                        "Proportion of Indigenous Aus (2011)" = as.numeric(as.character(c(data11[,79]))))

#Filter out only 2011 rows
AboriginalRate<- subset(Filtered1, Filtered1[,2] == "2011")

#Import 2011 Median Income Data
IncomeData <- read_excel("Income2011.xls", sheet = 6, skip = 7, col_names = FALSE)
dIncomeData <- as.data.frame(IncomeData)
MedianIncome2011 <- data.frame("Suburbs" = c(dIncomeData[,2]),
                               "Median Income (2011)" = as.numeric(as.character(c(dIncomeData[,19]))))

#Import and create a data frame on Education Statistics
Employment <- read_excel("14100DS0006_2017-03.xlsx", skip = 8, col_names = FALSE)
DEmployment <- as.data.frame(Employment)
Education <- data.frame("Suburbs" = c(DEmployment[,2]),
                        "Year" = c(DEmployment[,3]),
                        "Postgraduate (2011)" = as.numeric(as.character(c(DEmployment[,37]))), 
                        "Certificate (2011)" = as.numeric(as.character(c(DEmployment[,41]))))
Education2011 <- subset(Education, Education[,2] == "2011")

#Merge all data into one table
DataT <- merge(AboriginalRate, Education2011, by = c("Suburbs", "Year"))
DataTotal <- merge(DataT, MedianIncome2011, by = c("Suburbs"))

#Sort Data by top 4 death rate
DecreaseDRate <- DataTotal[order(-DataTotal[,3], decreasing = FALSE),]
DecreaseDRate <- DecreaseDRate[1:4,]

#Sort Data by top 4 proportion of postgraduate degrees
DecreasePost <- DataTotal[order(-DataTotal[,5], decreasing = FALSE),]
DecreasePost <- DecreasePost[1:4,]
