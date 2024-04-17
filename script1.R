# Import data from Excel file sheet 5: sexual orientation by age and sex

library(readxl)
sexualorientationdetailedagesex <- read_excel("~/psy6422/sexualorientationdetailedagesex.xlsx", 
                                                +     sheet = "5. Nat_age_sex", col_types = c("skip", 
                                                                                              +         "skip", "text", "skip", "text", "skip", 
                                                                                              +         "text", "skip", "text", "text"), 
                                                +     skip = 1)
View(sexualorientationdetailedagesex)

# load/install packages

library(tidyverse)
library(shiny)
tinytex::install_tinytex()




# sheet 3 import data

View(sexualorientationdetailedagesex)
library(readxl)
sexualorientationdetailedagesex <- read_excel("~/psy6422/sexualorientationdetailedagesex.xlsx", 
                                                +     sheet = "3. Nat_sex", skip = 1)
View(sexualorientationdetailedagesex)

# Create a stacked bar chart
ggplot(sexualorientationdetailedagesex, aes(x = Sex, y = `Percentage of sex category`, fill = `Sexual orientation (9 categories)`)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Sexual Orientation Distribution by Sex",
       x = "Sex",
       y = "Percentage of Sex Category") +
  scale_fill_brewer(palette = "Set3") +  # Using a color palette that is distinct
  theme_minimal() +
  theme(legend.position = "bottom")  # Move the legend to the bottom


# load new dataset to explore religion and sexual orientation

library(readxl)
sexualorientationreligion <- read_excel("~/psy6422/sexualorientationfurtherpersonalcharacteristicsenglandandwalescensus2021.xlsx", 
                                                                                       sheet = "2a", col_types = c("skip", "text", 
                                                                                                                   "text", "text", "text", "text", "numeric"), 
                                                                                       skip = 4)
View(sexualorientationreligion)

# install vcd

install.packages("vcd")
library(vcd)
sexualorientationreligion_clean <- sexualorientationreligion[!apply(sexualorientationreligion, 1, function(x) any(grepl("\\[c\\]", x))), ]

# rename the columns

sexualorientationreligion_clean <- rename(sexualorientationreligion_clean, 
                                          c( "sexual_orientation" = "Sexual orientation", 
                                             "religion" = "Religion", 
                                             "age" = "Age group [note 2]" , 
                                             "sex" = "Sex [note 1]", 
                                             "percentage" = "Percentage estimate of group [note 3] [note 4]"))

view(sexualorientationreligion)

sexualorientationreligion$`Percentage estimate of group 
[note 3] [note 4]`
# Create a mosaic plot

# new table of counts

tab <- xtabs(percentage ~ religion + sexual_orientation, data = sexualorientationreligion_clean)
mosaicplot(tab, main = "Mosaic Plot of Age, Religion, and Sexual Orientation")
view(tab)





