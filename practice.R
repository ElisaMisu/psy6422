# load new sheet to play with packages and explore options

library(readxl)
sexualityethnicity <- read_excel("~/psy6422/sexualorientationfurtherpersonalcharacteristicsenglandandwalescensus2021.xlsx", 
                                                                                       sheet = "1a", skip = 4)
View(sexualityethnicity)
 
# some minor modifications

head(sexualityethnicity)
str(sexualityethnicity)
summary(sexualityethnicity)
