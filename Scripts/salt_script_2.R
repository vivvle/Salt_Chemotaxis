#### Salt Chemotaxis ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-16 ####

#### Load libraries ####
library(tidyverse)
library(ggplot2)
library(here)
library(palettetown)
library(rstatix)

#### load data ####
salt <- read.csv(here("Data", "salt_CTX_data.csv"))
allgenes <- read.csv(here("Data", "salt_ctx_all_genes.csv"))

#### view data ####
glimpse(salt)
glimpse(allgenes)
view(salt)
view(allgenes)


salt_data <- salt %>%
  mutate(total = (A+C)) %>% #adding A and C for total worm participating in the assay
  mutate(CI = ((A-C)/(total))) %>% #calculating for the chemotaxis index with the worms participating in the assay
  mutate(participation = (total)/(total+Dispersed)) %>% #calculating for the fraction of worm participating from the population
  relocate("total", .before = "Dispersed") #moved total column before dispersed
view(salt_data)

gcy_data <- salt_data %>%
  select(Strain, Salt, CI) %>%
  group_by(Salt)
view(gcy_data)

