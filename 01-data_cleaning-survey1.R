#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [https://www.voterstudygroup.org/downloads?key=676e2373-8473-4faa-8fe9-f9935b043aeb]
# Author: Rubing Mai
# Data: November 2, 2020
# Contact: rubing.mai@mail.utoronto.ca
# License: MIT



#### Workspace setup ####

library(haven)
library(tidyverse)

# Read in the raw data

setwd("/Users/zella/Desktop/STA304 PS3 DATA/Inputs")
raw_survey_data <- read_dta("ns20200625.dta")

# Add the labels

raw_survey_data <- labelled::to_factor(raw_survey_data)

reduced_survey_data <- 
  raw_survey_data %>% 
  select(registration,
         vote_intention,
         vote_2020,
         employment,
         gender,
         census_region,
         race_ethnicity,
         education,
         state,
         age)


#### Clean data ####

reduced_survey_data<-
  reduced_survey_data %>%
  filter(vote_2020 != "I would not vote") %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0)) %>%
  mutate(vote_biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0)) %>%
  filter(employment!= "Other:")

# Saving the survey/sample data as a csv file

write_csv(reduced_survey_data, "/Users/zella/Desktop/STA304 PS3 DATA/Outputs/survey_data.csv")

