#### Salt Chemotaxis ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-16 ####

#### Load libraries ####
library(tidyverse)
library(ggplot2)
library(here)
library(palettetown)

#### load data ####
salt <- read.csv(here("Data", "salt_CTX_data.csv"))
allgenes <- read.csv(here("Data", "salt_ctx_all_genes.csv"))

#### view data ####
glimpse(salt)
glimpse(allgenes)
view(salt)
view(allgenes)

#### data analysis for gcy-22 (salt) ####
salt$total <- (salt$A + salt$C) #adding A and C for total worms participating
salt$CI <-((salt$A - salt$C)/(salt$total)) #calculating for chemotaxis index
salt$participation <- ((salt$total/(salt$total + salt$Dispersed))) #calculating for worms who participated in the assay
view(salt)

salt_data <- salt %>%
  relocate("total", .before = "Dispersed") %>% #moved total column before dispersed
  write.csv(here("Output","salt_CI.csv")) #saved as an output with calculations
view(salt_data)

#### data analysis for all genes ####
allgenes$total <- (allgenes$A + allgenes$C)
allgenes$CI <- ((allgenes$A - allgenes$C)/(allgenes$total))
allgenes$participation <- ((allgenes$total)/(allgenes$total + allgenes$Dispersed))
view(allgenes)

allgenes_data <- allgenes %>%
  relocate("total", .before = "Dispersed") %>%
  write.csv(here("Output", "allgenes_CI.csv"))
view(allgenes_data)

allgenes_CI <- allgenes_data %>%
  select(Strain, Salt, CI)
view(allgenes_CI)


#### plotting data ####
p1 <- salt_data %>%
  ggplot(mapping = aes(x = Strain, y = CI, group = Salt)) +
  geom_point()

