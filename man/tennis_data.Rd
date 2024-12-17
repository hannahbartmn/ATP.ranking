\name{tennis_data}
\alias{tennis_data}
\docType{data}
\title{
ATP tennis matches
}
\description{
This dataset provides information for ATP tennis matches from 1968 to May 2024.
}
\usage{data("tennis_data")}
\format{
  A data frame with 818275 observations on 15 variables.
  \describe{
    \item{\code{[,1] tourney_id}}{character ID of the tournament}
    \item{\code{[,2] tourney_name}}{character name of the tournament}
    \item{\code{[,3] tourney_level}}{character that encodes the level of the tournament}
    \item{\code{[,4] player_id}}{numeric ID of the player}
    \item{\code{[,5] player_name}}{character name of the player}
    \item{\code{[,6] player_ioc}}{character that encodes the nationality of the player in IOC code}
    \item{\code{[,7] opponent_id}}{numeric ID of the opponent}
    \item{\code{[,8] opponent_name}}{character name of the opponent}
    \item{\code{[,9] opponent_ioc}}{character that encodes the nationality of the opponent in IOC code}
    \item{\code{[,10] win}}{numeric value indiating if the player won his match}
    \item{\code{[,11] tourney_date}}{date indicating the start of the tournament}
    \item{\code{[,12] date_difference}}{numeric number of elapsed days since the latest tournament}
    \item{\code{[,13] tourney_country}}{character country of the venue of the tournament}
    \item{\code{[,14] tourney_ioc}}{character country IOC code of the venue of the tournament}
    \item{\code{[,15] home_tourney}}{numeric indicating the home advantage of the player or opponent}
  }
}
\details{
For further information for the \code{tourney_level} see \code{\link{level_weight}}.

The variable \code{win} encodes a win of the player against the opponent with \code{1} and a loss of the player against the opponent with \code{0}.

The variable \code{home_tourney} is \code{1}, if the player has the home advantage, it is \code{-1}, if the opponent has the home advantage, and it is \code{0}, if both or neither have the home advantage.
The variable is \code{NA}, if the either the nationality of the player or opponent or the country of the venue of the tournament is unkown.
}
\source{
Kovalchik, S. (2019). deuce: Resources for Analysis of Professional Tennis Data. Last
viewed: 31-07-2024. url: https://github.com/skoval/deuce.

Sackmann, J. (2024). ATP Tennis Rankings, Results, and Stats. Last viewed: 31-07-2024.
url: https://github.com/JeffSackmann/tennis_atp.
}

%\examples{
%
%}
\keyword{datasets}
