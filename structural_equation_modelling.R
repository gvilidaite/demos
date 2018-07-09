library(lavaan)
library(semPlot)

# specifying the structure of the model:
# HS.model <- 'visual =~ x1 + x2 + x3
#              textual =~ x4 + x5 + x6
#              speed =~ x7 + x8 + x9'

# weighted x9 parameter
HS.model <- ' visual =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed =~ x7 + x8 + b1*x9 '

dataset <- HolzingerSwineford1939

dataset <- dataset[,7:15]
fit <- cfa(HS.model, data = dataset)
fit2 <- cfa(HS.model, data = dataset, estimator="GLS")
#summary(fit, fit.measures=TRUE)
#summary(fit2, fit.measures=TRUE)

semPaths(fit,whatLabels="par",edge.label.cex=1,layout="tree")

mi <- modindices(fit)
mi[mi$op == "=~",]

# sets x9 to 0 (x9*b1=0) and checks if the fit gets better:
lavTestWald(fit, constraints = 'b1 == 0')

# model without parameter x9. The fit gets better
HS.model <- ' visual =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed =~ x7 + x8'

fit3 <- cfa(HS.model, data = dataset)
#summary(fit3, fit.measures=TRUE)

