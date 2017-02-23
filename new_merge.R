#this is to be edited for use in merging the data from other cities.

#broken


files = list.files(path = "~/Pollen/Pollen_csvs/", pattern="*.csv")
pollen_files = files[grep(pattern="Pollen|POLLEN",files)]
mold_files = files[grep(pattern="Mold|MOLD",files)]

setwd("~/Pollen/Pollen_csvs")
pollen_names = colnames(read.delim(file=pollen_files[1], header=TRUE, sep=","))
for (i in 2:length(pollen_files)){
  temp = colnames(read.delim(file=pollen_files[i], header=TRUE, sep=","))
  for (j in 1:length(temp)){
    if ((temp[j] %in% pollen_names)==FALSE) {
      pollen_names = c(pollen_names,temp[j])
    }
  }
}


setwd("~/Pollen/Pollen_csvs")
mold_names = colnames(read.delim(file=mold_files[1], header=TRUE, sep=","))
for (i in 2:length(mold_files)){
  temp = colnames(read.delim(file=mold_files[i], header=TRUE, sep=","))
  for (j in 1:length(temp)){
    if ((temp[j] %in% mold_names)==FALSE) {
      mold_names = c(mold_names,temp[j])
    }
  }
}
mold_names = mold_names[!mold_names %in% c("Date")]

setwd("~/Pollen/Pollen_csvs")
first_pollen = read.delim(file=pollen_files[1], header=TRUE, sep=",")
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

write.csv(pollen,"~/Pollen/HouPollen.csv")
#now go to excel, and rearrange the dates to be in order. check for duplicate dates










setwd("~/Pollen/Pollen_csvs")
first_mold = read.delim(file=mold_files[1], header=TRUE, sep=",")
mold = first_mold[,1]
for (i in 2:length(mold_names)) {
  if (mold_names[i] %in% colnames(first_mold)) {
    mold = cbind(mold,first_mold[mold_names[i]])
  }
  else {
    mold = cbind(mold, NA)
  }
}
colnames(mold) = mold_names
mold[,-c(1)] <- data.frame(lapply(mold[,-c(1)], function(x) as.numeric(as.character(x))))
for (i in 2:length(mold_files)) {
  temp1 = read.delim(file=mold_files[i], header=TRUE, sep=",")
  temp2 = temp1[,1]
  for (j in 2:length(mold_names)) {
    if (mold_names[j] %in% colnames(temp1)) {
      temp2 = cbind(temp2,temp1[mold_names[j]])
    }
    else {
      temp2 = cbind(temp2,NA)
    }
  }
  colnames(temp2) = mold_names
  temp2[ ,-c(1)] <- data.frame(lapply(temp2[ ,-c(1)], function(x) as.numeric(as.character(x))))
  mold = rbind(mold,temp2)
}

mold[mold==0] = NA
#only if it is known that there are no missing dates
mold = mold[!is.na(mold[,1]), ]
mold = mold[rowSums(is.na(mold[ ,2:length(mold[1, ])]))!=(length(mold[1, ])-1), ]
mold = mold[ ,colSums(is.na(mold))!=length(mold[ ,1])]
rownames(mold) = 1:length(mold[ ,1])

write.csv(mold,"~/Pollen/mold.csv")
#now go to excel, and rearrange the dates to be in order. check for duplicate dates









