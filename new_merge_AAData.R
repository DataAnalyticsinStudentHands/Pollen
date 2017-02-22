pollen_files = list.files(path = "/Volumes/KINGSTON/Pollen/AAData_csvs/", pattern="*.csv")
city_names = c("College Station", "Flower Mound", "Georgetown", "Houston", "Knoxville", "Lexington", "Little Rock", 
               "Louisville", "Oklahoma City", "Rogers", "San Antonio", "Tulsa", "Waco")

setwd("/Volumes/KINGSTON/Pollen/AAData_csvs")
pollen_names = colnames(read.delim(file=pollen_files[1], header=TRUE, sep=","))
for (i in 2:length(pollen_files)){
  temp = colnames(read.delim(file=pollen_files[i], header=TRUE, sep=","))
  for (j in 1:length(temp)){
    if ((temp[j] %in% pollen_names)==FALSE) {
      pollen_names = c(pollen_names,temp[j])
    }
  }
}
pollen_names = pollen_names[2:length(pollen_names)]
pollen_names = c("City",pollen_names)


setwd("/Volumes/KINGSTON/Pollen/AAData_csvs")
first_pollen = read.delim(file=pollen_files[1], header=TRUE, sep=",")
for (City in city_names) {
  if (grepl(tolower(City),tolower(pollen_files[1]))) {
    first_pollen = cbind(City,first_pollen[ ,2:length(first_pollen)])
  }
}
pollen = first_pollen[,1]
for (i in 2:length(pollen_names)) {
  if (pollen_names[i] %in% colnames(first_pollen)) {
    pollen = cbind(pollen,first_pollen[pollen_names[i]])
  }
  else {
    pollen = cbind(pollen, NA)
  }
}
colnames(pollen) = pollen_names
pollen[,-c(1,2)] <- data.frame(lapply(pollen[,-c(1,2)], function(x) as.numeric(as.character(x))))
for (i in 2:length(pollen_files)) {
  temp1 = read.delim(file=pollen_files[i], header=TRUE, sep=",")
  for (City in city_names) {
    if (grepl(tolower(City),tolower(pollen_files[i]))) {
      temp1 = cbind(City,temp1[ ,2:length(temp1)])
    }
  }
  temp2 = temp1[,1]
  for (j in 2:length(pollen_names)) {
    if (pollen_names[j] %in% colnames(temp1)) {
      temp2 = cbind(temp2,temp1[pollen_names[j]])
    }
    else {
      temp2 = cbind(temp2,NA)
    }
  }
  colnames(temp2) = pollen_names
  temp2[,-c(1,2)] <- data.frame(lapply(temp2[,-c(1,2)], function(x) as.numeric(as.character(x))))
  pollen = rbind(pollen,temp2)
}

pollen[pollen==0] = NA
pollen = pollen[rowSums(is.na(pollen[ ,3:length(pollen[1, ])]))!=(length(pollen[1, ])-2), ]
pollen = pollen[ ,colSums(is.na(pollen))!=length(pollen[,1])]
rownames(pollen) = 1:length(pollen[,1])
names(pollen)[names(pollen)=="Asteraceae..Excluding.Ambrosia.and.Artemisia."] <- "Asteraceae"
pollen$Chenopodiaceae.Amaranthaceae = pollen$Chenopodiaceae.Amaranthaceae + pollen$Chenopodiaceae.Amaranthaceae.
pollen = subset(pollen, select=-c(Chenopodiaceae.Amaranthaceae.))


write.csv(pollen,"/Volumes/KINGSTON/Pollen/AApollen.csv")













