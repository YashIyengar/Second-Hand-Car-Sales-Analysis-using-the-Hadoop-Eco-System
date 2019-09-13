setwd("D:/Downloads/Soccer/Used Cars/")

a <- data.frame(read.csv("craigslistVehicles.csv", stringsAsFactors = TRUE, na.strings = "", header = TRUE))
b <- data.frame(read.csv("craigslistVehiclesFull.csv", stringsAsFactors = TRUE, na.strings = "", header = TRUE))

half <- a
full <- b

head(half)
library(dplyr)
half <- tbl_df(half)
names(half)
half <- half[, c(-1,-3,-19)]

names(half)
colSums(is.na(half))
half <- half[, -10]
half <- half[, -11]
half <- half[, -15]
str(half)
half$make <- as.character(half$make)
summary(half)

half <- na.omit(half)
head(half)
tail(half)
write.csv(half, "clean_half.csv", row.names = FALSE)
###########################################################################################################################
full <- tbl_df(full)
names(full)
full <- full[, c(-1,-11,-13,-18,-21,-23,-24 )]
colSums(is.na(full))
full <- na.omit(full)
head(full)
tail(full)
str(full)
summary(full)
full$make <- as.character(full$make)
write.csv(full, "clean_full.csv", row.names = FALSE)
############################################################################################################################3
manu <- c$manufacturer
levels(manu)
manu <- as.character(manu)
str(manu)
levels(manu)
manu[manu == "alfa-romeo"] <- "alfaromeo"
manu[manu == "alfa"] <- "alfaromeo"
manu[manu == "aston-martin"] <- "astonmartin"
manu[manu == "aston"] <- "astonmartin"
manu[manu == "chev"] <- "chevrolet"
manu[manu == "chevy"] <- "chevrolet"
manu[manu == "harley-davidson"] <- "harleydavidson"
manu[manu == "harley"] <- "harleydavidson"
manu[manu == "infiniti"] <- "infinity"
manu[manu == "land rover"] <- "landrover"
manu[manu == "rover"] <- "landrover"
manu[manu == "mercedes-benz"] <- "mercedes"
manu[manu == "vw"] <- "volkswagen"

manu <- as.factor(manu)
levels(manu)

c$manufacturer <- manu
levels(c$manufacturer)
write.csv(c, "clean_full.csv", row.names = FALSE)
#####################################################################################################

c <- data.frame(read.csv("clean_full.csv", stringsAsFactors = TRUE,  na.strings = "", header = TRUE))
c.exp <- c
str(c.exp)
c.exp$city <- as.character(c.exp$city)

c.exp$city <- trimws(c.exp$city, which = "both")

c$city <- c.exp$city
c$city <- as.factor(c$city)
levels(c$city)
write.csv(c, "clean_full.csv", row.names = FALSE)
###########################################################################################################
c <- data.frame(read.csv("clean_full.csv", stringsAsFactors = TRUE,  na.strings = "", header = TRUE))
str(c)
levels(c$manufacturer)
levels(c$make)

c.make <- c$make
str(c.make)
c.make <- as.character(c.make)
c.make <- trimws(c.make, which = "both")
c$make <- c.make

str(c)
levels(c$condition)
summary(c$condition)
levels(c$cylinders)
levels(c$fuel)
levels(c$transmission)
levels(c$drive)
levels(c$size)


size <- c$size
size <- as.character(size)
size[size == "full-size"] <- "fullsize"
size[size == "mid-size"] <- "midsize"
size[size == "sub-compact"] <- "subcompact"

size <- as.factor(size)
levels(size)

c$size <- size
summary(c)
levels(c$type)
type <- c$type
type <- as.character(type)
type[type == "mini-van"] <- "minivan"
type <- as.factor(type)
c$type <- type
levels(c$paint_color)
levels(c$county_name)
str(c)
levels(c$state_name)
c$county_name <- as.character(c$county_name)
c$state_name <- as.character(c$state_name) 
c$county_name <- trimws(c$county_name, which = "both")
c$state_name <- trimws(c$state_name, which = "both")
str(c)

write.csv(c, "clean_full.csv")
#########################################################################################################################
setwd("D:/Downloads/Soccer/Used Cars/")
c <- data.frame(read.csv("clean_full.csv", stringsAsFactors = TRUE,  na.strings = "", header = TRUE))
summary(c)
c.price <- c$price
c.price <-  format(c.price, scientific = FALSE)
c$price <- c.price

idx <- sample(1:nrow(c), nrow(c)*0.05, replace = TRUE)
chota <- c[idx, ]
library("ggplot2")
c$price <- as.numeric(chota$price)
plot <- ggplot(data = chota, aes(x = manufacturer, y = price))

library("scales")
plot + geom_bar( stat = "identity") 

summary(chota$price)

options(scipen = 999)
