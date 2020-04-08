

# Find rolling doubling times
require(tidyquant)

calc_slope <- function(y){
  y = as.numeric(na.omit(y))
  x = 1:length(y)
  regression = summary(lm(log(y)~x))
  return(as.numeric(regression$coefficients[2,1]))
}

rollingmean <- function(CasesOverTime,total_cases,width){
  
rollmean <- US_cases_by_day %>%
  tq_mutate(
    # tq_mutate args
    select     = total_cases,
    mutate_fun = rollapply, 
    width      = 7,
    align      = "right",
    FUN        = calc_slope,
    col_rename = "mean_7"
  ) 

}

