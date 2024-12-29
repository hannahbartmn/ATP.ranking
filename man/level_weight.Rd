\name{level_weight}
\alias{level_weight}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Match Importance Factor
}
\description{
\code{level_weight} calculates the match importance factor of a given tennis match.
}
\usage{
level_weight(lv)
}
\arguments{
  \item{lv}{a character indicating the level of the match. Must be \code{"G"}, \code{"O"}, \code{"F"},
            \code{"M"}, \code{"D"}, \code{"A"} or \code{"C"}.
}
}
\details{
\code{lv} should be chosen according to the tournament, the match was played in. Encode Grand Slams (G), Olympics (O),
Finals (F), Masters 1000s (M), Davis Cup (D), other Tour Events (A) or Challenger (C) matches.
Returns \code{NA} if any other level is chosen.
}
%\value{
%\item{weight}{the numeric match importance weight for the match}
%}
\references{
Ley, C., T. Van de Wiele and H. Van Eetvelde (2019). ‘Ranking soccer teams on basis of their current strength: A comparison of maximum likelihood approaches’.
In: Statistical Modelling 19.1, pp. 55–73. doi: 10.1177/1471082X18817650.
}
\author{
Hannah Bartmann
}
\note{

}

\seealso{
\code{\link{time_weight}}
}
\examples{

data("tennis_data")

date <- max(tennis_data$tourney_date)

subset <- tennis_data[tennis_data$tourney_date > date - 365*2, ]
subset <- na.omit(subset)

#library(tidyverse)
player_info <- data.frame(id = subset$player_id, name = subset$player_name)
player_info <- rbind(player_info, data.frame(id = subset$opponent_id, name = subset$opponent_name))
player_info <- distinct(player_info)

#determine outlier
outlier <- c()

for(i in 1:dim(player_info)[1]){
  temp <- player_info$name[i]
  #only win
  win <- subset[(subset$player_name == temp & subset$win == 1) | (subset$opponent_name == temp & subset$win == 0),]
  #only loss
  loss <- subset[(subset$player_name == temp & subset$win == 0) | (subset$opponent_name == temp & subset$win == 1),]

  if(dim(win)[1] == 0 | dim(loss)[1] == 0) #players with only wins or losses
    outlier <- c(outlier, temp)
}

subset[subset$player_name \%in\% outlier, "player_id"] <- 400000 #outliers get the same id
subset[subset$player_name \%in\% outlier, "player_name"] <- "Outlier"

subset[subset$opponent_name \%in\% outlier, "opponent_id"] <- 400000 #outliers get the same id
subset[subset$opponent_name \%in\% outlier, "opponent_name"] <- "Outlier"

#update player_info with the outliers
player_info <- data.frame(id = subset$player_id, name = subset$player_name)
player_info <- rbind(player_info, data.frame(id = subset$opponent_id, name = subset$opponent_name))
player_info <- distinct(player_info)

#prep design matrix
subset$player_id <- factor(subset$player_id, levels = player_info$id, labels = player_info$name)
subset$player_id <- relevel(subset$player_id, "Outlier")
subset$opponent_id <- factor(subset$opponent_id, levels = player_info$id, labels = player_info$name)
subset$opponent_id <-  relevel(subset$opponent_id, "Outlier")

#remove games where a outlier plays against a outlier
index <- which(subset$player_id == "Outlier" & subset$opponent_id == "Outlier")
if(length(index) > 0){
  subset <- subset[-index,]
}

#determine design matrix
X_1 <- model.matrix(~ -1 + player_id, data = subset)
X_2 <- model.matrix(~ -1 + opponent_id, data = subset)
X <- cbind(subset$home_tourney, X_1-X_2)
colnames(X)[1] <- "home"

#check for zero-columns, because some ids appear under a different name
check.zero <- function(x){
  sum(x != 0)
}

index <- c()
for(i in 1:dim(X)[2]){
  if(check.zero(X[,i]) == 0)
    index <- c(index, i)
}

if(length(index) > 0){
  X <- X[, -index]
}

y <- subset$win

#remove outlier column for identifiability
X <- X[,-2]

#convert to data.frame
X <- data.frame(X)

#determine weights
w_level <- sapply(subset$tourney_level, level_weight)
w_time <- time_weight(d = subset$date_difference, halfperiod = 100)

weights <- w_level * w_time

model <- glm(y ~ -1 + ., data = X, family = binomial, weights = weights)
}
