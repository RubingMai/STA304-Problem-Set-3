#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [https://doi.org/10.18128/D010.V10.0]
# Author: Rubing Mai
# Data: November 2, 2020
# Contact: rubing.mai@mail.utoronto.ca
# License: MIT



#### Workspace setup ####

library(haven)
library(tidyverse)

# Read in the raw data

setwd("/Users/zella/Desktop/STA304 PS3 DATA/Inputs")
raw_post_data <- read_dta("usa_00003.dta")

# Add the labels

raw_post_data <- labelled::to_factor(raw_post_data)

reduced_post_data <- 
  raw_post_data %>%
  select(age,
         sex, 
         region,
         empstat,
         race)
         

#### Clean date and make cells ####

reduced_post_data <- 
  reduced_post_data %>%
  filter(age != "less than 1 year old") %>%
  mutate(age = ifelse(age =="90 (90+ in 1980 and 1990)","90",age)) %>%
  filter(empstat != "n/a") %>%
  filter(race != "two major races") %>%
  filter(race != "three or more major races")
  

reduced_post_data$age <- as.integer(reduced_post_data$age)

reduced_post_data <- 
  reduced_post_data %>%
  filter(age >= 18)

reduced_post_data <- 
  reduced_post_data %>%
  count(age, sex, region, empstat, race) %>%
  group_by(age, sex, region, empstat, race) 

# Saving the census data as a csv file

write_csv(reduced_post_data, "/Users/zella/Desktop/STA304 PS3 DATA/Outputs/census_data.csv")



         