library(plot3D)

# first example

timesinms1 <- 1:1000
s1 <- 5*sin(5*2*pi*timesinms/1000)
s2 <- 2*sin(16*2*pi*timesinms/1000)
s3 <- sin(27*2*pi*timesinms/1000)
composite <- s1 + s2 + s3 + rnorm(1000)

plot(timesinms1,composite,type="l")

fftwave <- abs(Re(fft(composite)))

plot(fftwave,type="l")
plot(0:49,fftwave[1:50],type="l")
lines(c(5,5),c(0,100),col="red")
lines(c(16,16),c(0,100),col="green")
lines(c(27,27),c(0,100),col="blue")


# second example

timesinms <- (1:2000)
s1 <- 5*sin(5*2*pi*timesinms/1000)
s2 <- 2*sin(16*2*pi*timesinms/1000)
s3 <- sin(27*2*pi*timesinms/1000)
composite <- s1 + s2 + s3
fftwave <- abs(Re(fft(composite)))
plot(((0:99)/2),fftwave[1:100],type="l", ann=FALSE)


# third example (inverse Fourier)

synthspec <- 0*(1:1000)
synthspec[5] <- 1
synthwave <- Re(fft(synthspec, inverse=TRUE))
plot(timesinms1,synthwave,type="l") # adapted from the first plot


# fourth example (phase scrambling)

nelements <- sqrt(length(dog))
par(pty="s")
# image(1:nelements,1:nelements, dog,
#      col=grey((0:255)/255),ann=FALSE)

fftdog <- Re(fft(dog))
newphase <- 2*pi*matrix(runif(nelements^2),nrow=nelements)
newspectrum <- fftdog*exp(sqrt(as.complex(-1)*newphase))
newdog <- Re(fft(newspectrum, inverse=TRUE))
image(1:nelements,1:nelements, fftdog,
    col=grey((0:255)/255),ann=FALSE)

