data <- read.delim("~/Documents/R/Practical1data2.dat",
                   header=FALSE)
t.test(data$V1,data$V2,paired=TRUE)
summary(lm(V1 ~ V2, data=data))

library(BayesFactor)
bf <- ttestBF(x=data$V1,y=data$V2)
summary(bf)
summary(lmBF(V1 ~ V2, data=data))

libido <- c(3,2,1,1,4,5,2,4,2,3,7,4,5,3,6)
dose <- gl(3,5,labels = c("Placebo", "Low Dose", "High Dose"))
viagraData <- data.frame(dose, libido)
summary(anovaBF(libido ~ dose, data=viagraData))


p <- posterior(bf, iterations=1000)

bf <- ttestBF(x=data$V1,y=data$V2, rscale=1)
summary(bf)
