# function returning the time weight
# input:
#          d - number of elapsed days
# halfperiod - point, when the match is weighed 0.5

time_weight <- function(d, halfperiod) return(0.5^(d / halfperiod))
