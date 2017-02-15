#unfinished merge code for AAData


pollen_files = list.files(path = "/Volumes/KINGSTON/Pollen/AAData_csvs/", pattern="*.csv")

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
first_pollen = first_pollen[ ,2:length(first_pollen)]
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
pollen[,-c(1)] <- data.frame(lapply(pollen[,-c(1)], function(x) as.numeric(as.character(x))))
for (i in 2:length(pollen_files)) {
  temp1 = read.delim(file=pollen_files[i], header=TRUE, sep=",")
  temp1 = temp1[ ,2:length(temp1)]
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
  temp2[,-c(1)] <- data.frame(lapply(temp2[,-c(1)], function(x) as.numeric(as.character(x))))
  pollen = rbind(pollen,temp2)
}

pollen[pollen==0] = NA
#only if it is known that there are no missing dates
pollen = pollen[!is.na(pollen[,1]), ]
pollen = pollen[rowSums(is.na(pollen[ ,2:length(pollen[1, ])]))!=(length(pollen[1, ])-1), ]
pollen = pollen[ ,colSums(is.na(pollen))!=length(pollen[,1])]
rownames(pollen) = 1:length(pollen[,1])

write.csv(pollen,"/Volumes/KINGSTON/Pollen/pollen.csv")
#now go to excel, and rearrange the dates to be in order. check for duplicate dates













