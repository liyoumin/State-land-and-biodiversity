data2 <- read.csv("/Users/macpro/Desktop/Youmin-phd/R/bio-land/Statewide_Land_Pai_Intersect1_ExportTable.csv")
str(data2)
summary(data2)

# Assuming your data is in a data frame called `df`

# Remove rows with any NA
clean <- data2[!is.na(data2$LNDVAL), ]

# Optional: reset row names
rownames(clean) <- NULL

# Check lengths
sapply(clean, length)


###
summary(clean)
str(clean)
library(dplyr)

table(clean$LANDUSE_DE)
clean$LANDUSE_CO <- as.numeric(data$LANDUSE_CO)
clean <- clean %>%
  mutate(
    agland = if_else(
      LANDUSE_CO >= 2100 & LANDUSE_CO <= 3000, 
      LNDSQFOOT,                              
      0                                        
    )
  )
summary(clean$agland)

clean <- clean %>%
  mutate(
    agland_p = if_else(
      Shape_Ar_1 != 0,
      pmin((agland / SHAPAREA) * 10000, 100),
      NA_real_
    )
  )
summary(clean$agland_p)

###resrvior
clean <- clean %>%
  mutate(
    reservior = if_else(
      LANDUSE_CO == 5300, 
      LNDSSQFOOT,                              
      0                                        
    )
  )

summary(data$reservior)
data <- data %>%
  mutate(
    reservior_p = if_else(
      Shape_Area != 0,
      pmin((reservior / Shape_Area) * 10000, 100),
      NA_real_
    )
  )
Summary(data$reservior_p)

# Example 2SLS formula (update "your_instrument" accordingly)
formula_iv <- LANDvalue ~ bio_priority | your_instrument

# Run the IV regression (2SLS)
model_iv <- ivreg(formula_iv, data=data)

# Display summary with robust standard errors
summary(model_iv, vcov = sandwich, diagnostics = TRUE)






