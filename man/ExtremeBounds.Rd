\name{ExtremeBounds}
\alias{ExtremeBounds}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ExtremeBounds: Extreme Bounds Analysis in R
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
The package \code{ExtremeBounds} performs extreme bounds analysis (EBA), a global sensitivity test that examines the robustness of the association between a dependent variable and a variety of possible determinants. It supports a demanding version of EBA, proposed by Leamer (1985), that focuses on the upper and lower extreme bounds of regression estimates, as well as a more flexible version proposed by Sala-i-Martin (1997). Sala-i-Martin's EBA considers the entire distribution of regression coefficients. For Sala-i-Martin's version of extreme bounds analysis, the package \code{ExtremeBounds} estimates results for both the normal model (in which regression coefficients are assumed to be normally distributed across models) and the generic model (where no such assumption is made).

The most important function is \code{\link{eba}}, which performs the extreme bounds analysis and stores the results in an object of class \code{"eba"}. This object can then be passed on to the \code{\link{print.eba}} and \code{\link{hist.eba}} functions to obtain, respectively, a printed summary of EBA results and a set of histograms that illustrate the EBA results graphically.

If you have any comments or suggestions, please do not hesitate to contact the author.
}
\author{
%%  ~~who you are~~
Dr. Marek Hlavac < mhlavac at alumni.princeton.edu > \cr
Department of Economics, UWC Adriatic, Duino, Italy \cr
Research Fellow, Central European Labour Studies Institute (CELSI), Bratislava, Slovakia \cr
}
\section{Please cite as:}{
Hlavac, Marek (2016). ExtremeBounds: Extreme Bounds Analysis in R. \emph{Journal of Statistical Software}, 72(9), 1-22. doi: 10.18637/jss.v072.i09. \cr
}
\seealso{
\code{\link{eba}}, \code{\link{hist.eba}}, \code{\link{print.eba}}
}

\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
\keyword{ robust }
\keyword{ multivariate }
