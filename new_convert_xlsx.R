#converts xlsx and xls files into csv files in another folder

library(openxlsx)

# Create a vector of Excel files to read
xlsx_list = list.files(path = "/Volumes/KINGSTON/Pollen/AAData", pattern = "*.xlsx")
all_list = list.files(path = "/Volumes/KINGSTON/Pollen/AAData")
xls_list = all_list[!all_list %in% xlsx_list]

setwd("/Volumes/KINGSTON/Pollen/AAData/")
# Read each file and write it to csv
for (xlsx in xlsx_list){
  write.csv(read.xlsx(xlsx, startRow = 5, detectDates = TRUE), 
            paste("/Volumes/KINGSTON/Pollen/AAData_csvs/", gsub(".xlsx" ,"" , basename(xlsx)), ".csv", sep=""))
}
for (xls in xls_list){
  write.csv(read.xls(xls, pattern = "Total Pollen"),
            paste("/Volumes/KINGSTON/Pollen/AAData_csvs/", gsub(".xls" ,"" , basename(xls)), ".csv", sep=""))
}

