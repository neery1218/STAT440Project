require(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

# TODO: change to correct directory. Eventually I'll make this an R package.
setwd("~/STAT440/") 

test_fun <- function(x) {
  sin(x) + x
}

# generate some data  
n <- 1e5
mu <- runif(1, 0, 100)
sigma <- 1
y <- rnorm(n, test_fun(mu), 1)
data = list(N=n, y=y)

# compile and run autodiff stan model
fit_autodiff <- stan(file="test_fun_autodiff.stan", data = data, iter = 1e5) # needed a very large amount of iterations for this to converge
mu_autodiff <- mean(as.data.frame(fit_autodiff)$mu)

# should be almost identical
mu_autodiff - mu 

# Compile analytic gradient model
# in order for this to succeed, make sure to add "-w" to CXXFLAGS in ~/.R/Makevars (see Makevars instructions in email)
mod_analytic <- stan_model(
  file="test_fun_analytic.stan", 
  verbose = TRUE, 
  allow_undefined = TRUE, 
  includes = c(paste0('\n#include "', file.path(getwd(), 'test_fun.hpp'), '"\n'))
)

# sample analytic gradient model
fit_analytic <- sampling(mod_analytic, data=list(N=n, y=y), iter = 1e5)
mu_analytic <- mean(as.data.frame(fit_analytic)$mu)

# should be (close to) zero
mu_analytic - mu_autodiff