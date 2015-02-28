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
Marek Hlavac   < hlavac at fas.harvard.edu > \cr
Harvard University, Political Economy and Government \cr
}
\section{Please cite as:}{
Hlavac, Marek (2015). ExtremeBounds: Extreme Bounds Analysis in R.\cr
R package version 0.1.5. http://CRAN.R-project.org/package=ExtremeBounds 
}
\seealso{
\code{\link{eba}}, \code{\link{hist.eba}}, \code{\link{print.eba}}
}

\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
\keyword{ robust }
\keyword{ multivariate }
