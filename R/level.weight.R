# function returns the level weight of the tournament

level_weight <- function(lv){
  weight <- NA
  if(lv == "G") weight <- 4
  if(lv == "O") weight <- 3.5
  if(lv %in% c("F", "M")) weight <- 3
  if(lv == "D") weight <- 2
  if(lv %in% c("A", "C")) weight <- 1
  return(weight)
}
