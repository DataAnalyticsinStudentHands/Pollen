#converts xlsx and xls files into csv files in another folder
library(gdata)
library(openxlsx)

# Create a vector of Excel files to read
xlsx_list = list.files(path = "~/Pollen/AAData", pattern = "*.xlsx")
all_list = list.files(path = "~/Pollen/AAData")
xls_list = all_list[!all_list %in% xlsx_list]

setwd("~/Pollen/AAData/")
# Read each file and write it to csv
for (xlsx in xlsx_list){
  write.csv(read.xlsx(xlsx, startRow = 5, detectDates = TRUE), 
            paste("~/Pollen/AAData_csvs/", gsub(".xlsx" ,"" , basename(xlsx)), ".csv", sep=""))
}
for (xls in xls_list){
  write.csv(read.xls(xls, pattern = "Total Pollen"),
            paste("~/Pollen/AAData_csvs/", gsub(".xls" ,"" , basename(xls)), ".csv", sep=""))
}

