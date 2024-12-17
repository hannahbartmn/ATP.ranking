\name{time_weight}
\alias{time_weight}
%- Also NEED an '\alias' for EACH other topic documented here. was genau macht das?
\title{
Time Depreciation Factor
}
\description{
\code{time_weight} calculates the match importance factor of a given tennis match.
}
\usage{
time_weight(d, halfperiod)
}
\arguments{
  \item{d}{number of elapsed days}
  \item{halfperiod}{point, when the match is weighed 0.5}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
%\value{
%the numeric time depreciation weight for the match
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
\code{\link{level_weight}}
}
\examples{
# example for a time depreciation factor with a half period of 365 days
curve(time_weight(x, halfperiod = 365), from = 0, to = 4*365 + 100,
      xlab = 'Years Back', ylab = 'Time Weight', lwd = 2,
      xaxt = "n", cex.axis = 1.4, cex.lab = 1.5)
axis(1, at = 365*c(0:4), labels = 0:4,  cex = 5, cex.axis = 1.4)
segments(365, -0.1, 365, 0.5, lty = 2)
segments(-100, 0.5, 365, 0.5, lty = 2)
}

