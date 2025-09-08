data1 <- read.csv("/Users/macpro/Desktop/Youmin-phd/R/OneDrive_1_3-23-2025/Parcel_PairwiseInter_ExportTable_ExportTable.csv")
str(data1)
summary(data1)
###land area
library(dplyr)
data1$PAUC <- as.numeric(data1$PAUC)
data1 <- data1 %>%
  mutate(
    agriland = if_else(
      PAUC >= 050 & PAUC <= 069, 
      LNDSQFOOT,                              
      0                                        
    )
  )
summary(data1$agriland)

data1 <- data1 %>%
  mutate(
    agriland_p = if_else(
      LNDSQFOOT != 0,
      pmin((agriland / Shape_Area)*100, 100),
      NA_real_
    )
  )
summary(data1$agriland_p)

data1 <- data1 %>%
  mutate(
    nonagriland = if_else(
      PAUC = 099, 
      LNDSQFOOT,                              
      0                                        
    )
  )

data1 <- data1 %>%
  mutate(
    nonagriland_p = if_else(
      LNDSQFOOT != 0,
      pmin((nonagriland / Shape_Area), 100),
      NA_real_
    )
  )
summary(data1$nonagriland)

cor <- cor(data1$Priority_i, data1$LNDVAL, method = "pearson")
cort <- cor.test(data1$Priority_i, data1$LNDVAL)
stars <- ifelse(cort$p < 0.001, "***",
                ifelse(cort$p < 0.01, "**",
                       ifelse(cort$p < 0.05, "*", "")))
cor_table <- paste(round(cort$r, 2), stars)
dim(cor_table) <- dim(cort$r)

###
lm.fit() <- lm(LNDVAL ~ Priority_i, data=data1)
summary(lm.fit)
plot(lm.fit())

lm2 <- rlm(LNDVAL ~ Priority_i + agriland_p, data=data1)
summary(lm2)
