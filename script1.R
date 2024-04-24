# List of packages to check and install if required

packages <- c("here", "readxl", "tidyverse", "shiny")

# Loop to check and install packages if required (quietly- without warnings)

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# Load necessary packages

library(tidyverse)
library(shiny)
library(here)

# Import data from Excel file sheet 5: sexual orientation by age and sex

library(readxl)
sexualorientationdetailedagesex <- read_excel("~/psy6422/sexualorientationdetailedagesex.xlsx", 
                                                +     sheet = "5. Nat_age_sex", col_types = c("skip", 
                                                                                              +         "skip", "text", "skip", "text", "skip", 
                                                                                              +         "text", "skip", "text", "text"), 
                                                +     skip = 1)
View(sexualorientationdetailedagesex)



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
                                             "percentage" = "Percentage estimate of group \r\n[note 3] [note 4]"))

view(sexualorientationreligion_clean)



tab <- xtabs(percentage ~ religion + sexual_orientation, data = sexualorientationreligion_clean)
mosaicplot(tab, main = "Mosaic Plot of Age, Religion, and Sexual Orientation")
view(tab)

 # create a stacked bar chart of religion and sexual orientation (this plot needed adjusting because it has incl. all of the data, will filter next time)

library(ggplot2)

ggplot(sexualorientationreligion_clean, aes(x = sexual_orientation, y = percentage, fill = religion)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Sexual Orientation Distribution by Religion",
       x = "Sexual Orientation",
       y = "Religious Identity (Percentage)") +
  scale_fill_brewer(palette = "Set3") +  # Using a color palette that is distinct
  theme_minimal() +
  theme(legend.position = "bottom")  # Move the legend to the bottom

library(dplyr)

# Filtering data using dplyr's filter

filtered_data <- sexualorientationreligion_clean %>%
  filter(sexual_orientation != "All usual residents", #exclude all usual residents line
         age == "All ages 16 years and over", #include all ages (instead of age group breakdowns)
         sex == "People")  #just include all people instead of breakdown of sex
view(filtered_data)

# New plot using the filtered data

library(ggplot2)

# Create the stacked bar chart

ggplot(filtered_data, aes(x = sexual_orientation, y = percentage, fill = religion)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Percentage Breakdown of Religious Identity by Sexual Orientation",
       x = "Sexual Orientation",
       y = "Percentage") +
  scale_y_continuous(labels = scales::percent) +  # Format y-axis as percentages
  scale_fill_brewer(palette = "Paired") +  # Use a color palette for clarity
  theme_minimal() +  # Use a minimal theme for a cleaner look
  theme(legend.position = "bottom")  # Position the legend at the bottom

# check data to ensure that each sexual orientation totals just 100% e.g. Gay and Lesbian percentage = 100% instead of 10,000 as the plot was showing
sum_percentage_gay_lesbian <- filtered_data %>%
  filter(sexual_orientation == "Gay or Lesbian") %>%
  summarise(total_percentage = sum(percentage))
sum_percentage_gay_lesbian

#corrected to fix 10,000% issue, 

ggplot(filtered_data, aes(x = sexual_orientation, y = percentage / 100, fill = religion)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Percentage Breakdown of Religious Identity by Sexual Orientation",
       x = "Sexual Orientation",
       y = "Percentage") +
  scale_y_continuous(labels = scales::percent_format()) +  # Correctly format y-axis as percentages (adjustment on prev. code)
  scale_fill_brewer(palette = "Paired") +
  theme_minimal() +
  theme(legend.position = "bottom")

 





