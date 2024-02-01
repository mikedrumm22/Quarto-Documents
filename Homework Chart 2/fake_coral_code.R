library(RColorBrewer)
coul <- brewer.pal(5, "Set2") 
barplot(height=quantity, names=coral_genus, col=coul )
title(main= "Coral Species Versus Prevalernce", xlab= "Genus", ylab= "Quantity")