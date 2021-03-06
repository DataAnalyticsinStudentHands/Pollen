library(ggplot2)
library(scales)
library(grid)
library(RColorBrewer)
library(dplyr)
library(knitr)

setwd("~/Pollen")
pollen = read.delim("AApollen.csv", header = TRUE, sep = ",")
pollen = pollen[,-c(1)]
city_names = levels(pollen[,1])
pollen[is.na(pollen)] = 0
pollen_types = names(pollen[,-c(1:3)])



type_totals = data.frame(matrix(NA, nrow = length(pollen[1,])-3,
                                ncol = length(city_names)+1))
names(type_totals) = c("Type",city_names)
type_totals[,1] = pollen_types
for(j in 1:length(city_names)) {
  town = city_names[j]
  pollen %>%
    filter(City==town) -> temp
  
  temp_type_totals = c()
  for(i in 4:length(temp[1, ])) {
    temp_type_totals[i-3] = sum(temp[,i])
  }
  
  type_totals[,j+1] = temp_type_totals
}


type_totals2 = cbind(type_totals[ ,c(1,2)],names(type_totals)[2])
names(type_totals2) = c("Type","Total","City")
for(i in 3:length(names(type_totals))){
  temp = cbind(type_totals[ ,c(1,i)],names(type_totals)[i])
  names(temp) = names(type_totals2)
  type_totals2 = rbind(type_totals2,temp)
}
kable(type_totals2)

ggplot(type_totals2, aes(x = Type, y = Total)) +
  geom_bar(color="firebrick",stat = "identity") +
  coord_flip() +
  facet_grid(City ~ .,heightDetails(2.5))

test <- ggplot(type_totals, aes(x = Type, y = Total), title(main = town)) +
  geom_bar(color="firebrick",stat = "identity") +
  coord_flip()
print(test)


pollen %>%
  filter(City=="College Station") ->temp

