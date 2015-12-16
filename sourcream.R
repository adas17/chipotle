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
ggplot(foods, aes(factor(Sourcream)))+ geom_bar(aes(fill=Type)) + scale_x_discrete(limits=c(FALSE, TRUE), labels=c("No Sourcream", "Sourcream")) + labs(x = "Sourcream or not?", title = "Sourcream at Chipotle")

##Type of meal with those sourcream or not
food <- melt(foods, id="Type", measure="Sourcream")
ggplot(food, aes(x=Type, fill=value))+geom_bar(stat="bin", position="dodge")+labs(x = "Type of food")+ scale_fill_discrete("Sourcream or not?", 
+  breaks=c("FALSE", "TRUE"),   labels=c("No Sourcream", "Yes Sourcream"))
