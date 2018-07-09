library(neldermead)
library(optimsimplex)
library(optimbase)
library(R.matlab)

data <- readMat('~/Documents/R/eegwave.mat')
waveform <<- data$waveform # double arrow allows any functions see these variables
timesinms <<- (1:1000)
plot(timesinms,waveform,type="l")

sinewave <- sin(2*pi*5*timesinms/1000)
lines(timesinms, sinewave, type="l", col="red")

p <- c(0.7,0.5)
sinewave <- p[1]*sin(2*pi*5*timesinms/1000 + p[2])
lines(timesinms,sinewave,type="l",col="green")

errorfit <- function(p)
{
  pred <- 1*sin(2*pi*5*timesinms/1000 + p[2]) # to fix a value change it to a constant here
  rms <- sqrt(sum((pred-waveform)^2)/length(waveform))
  return(rms)
}

opt <- optimset(MaxFunEvals=2000)
sout <- fminsearch(errorfit, p, opt)

p <- sout$optbase$xopt
print(p)
print(errorfit(p))

sinewave <- p[1]*sin(2*pi*5*timesinms/1000 + p[2]) # and also fix the parameter here for plotting
lines(timesinms,sinewave,type="l",col="blue")
