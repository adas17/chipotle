####Sahar Mozaffari
####More sourcream or less? - On Chipotle tacos, burritos, and bowls.

install.packages("ggplot2")
install.packages("reshape2")
library(ggplot2)
library(reshape2)

table <- read.table("orders.tsv",  sep="\t", header = T)
tacos <- table[grep("Taco", table$item_name),]
tacos <- cbind(tacos, "taco")
colnames(tacos)[6] <- "Type"
burritos <- table[grep("Burrito", table$item_name),]
burritos <- cbind(burritos, "burrito")
colnames(burritos)[6] <- "Type"
bowls <- table[grep("Bowl", table$item_name),]
bowls <- cbind(bowls, "bowl")
colnames(bowls)[6] <- "Type"

foods <- rbind(tacos,burritos,bowls)

var <- grepl("Sour Cream", foods$choice_description)
foods <- cbind(foods, var)
colnames(foods)[7] <- "Sourcream"

##Sour cream colored by type of meal
ggplot(foods, aes(Sourcream))+ geom_bar(aes(fill=Type))

##Type of meal with those sourcream or not
food <- melt(foods, id="Type", measure="Sourcream")
ggplot(food, aes(x=Type, fill=value))+geom_bar(stat="bin", position="dodge")
