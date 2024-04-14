# Import data from Excel file sheet 5: sexual orientation by age and sex

library(readxl)
sexualorientationdetailedagesex <- read_excel("~/psy6422/sexualorientationdetailedagesex.xlsx", 
                                                +     sheet = "5. Nat_age_sex", col_types = c("skip", 
                                                                                              +         "skip", "text", "skip", "text", "skip", 
                                                                                              +         "text", "skip", "text", "text"), 
                                                +     skip = 1)
View(sexualorientationdetailedagesex)

# load packages

library(tidyverse)
library(shiny)

# plot a barchart
ggplot(sexualorientationdetailedagesex, aes(x = `Age code`, y = `Percentage of age-sex category`, fill = `Sexual orientation (9 categories) code`)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(title = "Stacked Bar Chart of Sexual Orientation by Age Group",
       x = "Age Group",
       y = "Sexual Orientation") +
  theme_minimal()

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
sexualorientationreligion_clean <- rename(sexualorientationreligion_clean, c( "sexual_orientation" = "Sexual orientation", "religion" = "Religion", "age" = "Age group [note 2]" , "sex" = "Sex [note 1]", "percentage" = "Percentage estimate of group [note 3] [note 4]"))
view(sexualorientationreligion)

# Create a mosaic plot
# new table of counts
tab <- table(sexualorientationfurtherpersonalcharacteristicsenglandandwalescensus2021$religion, sexualorientationfurtherpersonalcharacteristicsenglandandwalescensus2021$sexual_orientation, sexualorientationfurtherpersonalcharacteristicsenglandandwalescensus2021$age, sexualorientationfurtherpersonalcharacteristicsenglandandwalescensus2021$`Percentage estimate of group 
[note 3] [note 4]`)
mosaicplot(tab, main = "Mosaic Plot of Age, Religion, and Sexual Orientation")
view(tab)
