\name{eba}
\alias{eba}
\alias{summary.eba}
\alias{coefficients.eba}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Extreme Bounds Analysis
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
\code{eba} is used to perform extreme bounds analysis (EBA), a global sensitivity test that examines the robustness of the association between a dependent variable and a variety of possible determinants. The \code{eba} function performs a demanding version of EBA, proposed by Leamer (1985), that focuses on the upper and lower extreme bounds of regression estimates, as well as a more flexible version proposed by Sala-i-Martin (1997). Sala-i-Martin's EBA considers the entire distribution of regression coefficients. For Sala-i-Martin's version of extreme bounds analysis, \code{eba} estimates results for both the normal model (in which regression coefficients are assumed to be normally distributed across models) and the generic model (where no such assumption is made).
}
\usage{
eba(data, y, free = NULL, doubtful = NULL, focus = NULL,
    k = 0:3, mu = 0, level = 0.95, vif = NULL, exclusive = NULL, 
    draws = NULL, reg.fun = lm, se.fun = NULL, include.fun = NULL,
    weights = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{a data frame containing the variables used in the extreme bounds analysis.}
  \item{y}{a character string that specifies the dependent variable.}
  \item{free}{a character vector that specifies the 'free' variables to be used in the analysis. These variables are included in each regression model.}
  \item{doubtful}{a character vector that specifies the 'doubtful' variables to be used in the analysis. These variables will be included, in various combinations, in the estimated regression models.}
  \item{focus}{a character vector that specifies the 'focus' variables of the extreme bounds analysis. These are the variables whose robustness the user wants to test. The focus variables must be a subset of the variables included in the argument \code{doubtful}. Since these are the variables of interest, \code{eba} will only run regressions with doubtful variable combinations that contain at least one focus variable.}
  \item{k}{a vector of integers that specifies the number of doubtful variables that will be included in each estimated regression model in addition to the focus variable. Following Levine and Renelt (1992), the default is set to \code{0:3}, meaning that up to three additional doubtful variables will be included in each model on top of the focus variable.}
  \item{mu}{a named vector of numeric values that specifies regression coefficients under the null hypothesis. The names of the vector's components indicate which variable the null hypothesis coefficients belong to. These null hypothesis coefficient values will be used in all hypothesis testing. Alternatively, the argument \code{mu} can be a single numeric value that will set the null hypothesis values for all variables' coefficients. By default, \code{mu} will be equal to zero for all examined variables, as is standard in most applications of extreme bounds analysis.}
  \item{level}{a numeric value between 0 and 1 that indicates the confidence level to be used in determining the robustness/fragility of determinants.}
  \item{vif}{a numeric value that sets the maximum limit on a coefficient's variance inflation factor (VIF), a rule-of-thumb indicator of multicollinearity. Only coefficient estimates whose VIF does not exceed the limit will be considered in the analysis. If \code{NULL} (default), no limit on the VIF is imposed.}
  \item{exclusive}{a list of character vectors. Each character vector specifies a set of mutually exclusive doubtful variables. These variables will never be included in the same regression model. Specifying which doubtful variables may not be included together in the same model can help alleviate concerns about regressor multicollinearity, and can also be useful when several doubtful variables measure the same substantive concept.}
  \item{draws}{a positive integer value that specifies how many regressions \code{eba} should run. These regressions will be randomly drawn (without replacement, and each with equal probability) from the full set of doubtful variable combinations (that, of course, contain the variables specified in \code{focus}). Such a random draw can be useful when estimating the full set of regressions would require too much time. If NULL (default), there will be no random sampling of regression model and all combinations will be estimated.}
  \item{reg.fun}{a function that estimates the desired regression model. The function must accept arguments \code{formula} and \code{data} in the same way that the standard functions \code{lm} and \code{glm} do. Additional arguments can be passed on via the \code{\dots} argument. In this way, the user can make \code{eba} estimate, say, a logistic or probit regression by setting \code{reg.fun = glm} and passing on the appropriate values for \code{glm}'s \code{family} argument through \code{eba}'s \code{\dots} argument. By default, an Ordinary Least Squares (OLS) regression is performed via the \code{lm} function.}
  \item{se.fun}{a function that calculates the standard errors for regression coefficient estimates. The function must accept the regression model object as its first argument, and must return a numeric vector with element names that identify the corresponding regressors.}
  \item{include.fun}{a function that determines whether the results from a particular regression model will be included in the analysis. The function must accept the regression model object as its first argument, and must return a logical value. Only regression models for which the function returns a value of TRUE will be included in the extreme bounds analysis.}
  \item{weights}{a character string or a function that specifies what weights will be applied to the results from each estimated regression model. The default value of \code{NULL} means that each model will have an equal weight. If the argument is set to \code{"adj.r.squared"}, \code{"lri"}, \code{"r.squared"}, the regression results will be weighted based on the adjusted R-squared, the likelihood ratio index (McFadden, 1974), or the R-squared, respectively.}
  \item{\dots}{additional arguments that will be passed on to the regression function specified by \code{reg.fun}.}
%%     ~~Describe \code{\dots} here~~
}
  
\details{ 
If the argument \code{focus} is NULL, it is populated by the content of \code{doubtful}. Conversely, if \code{doubtful} is NULL, it will be filled in with values from \code{focus}. It is thus sufficient to specify only one of \code{doubtful} or \code{focus} to test the robustness of all doubtful variables.

The character strings in arguments \code{y}, \code{free}, \code{doubtful}, \code{focus} and \code{exclusive} can contain model formula operators described in \code{\link{formula}} (such as \code{:}, \code{*}, \code{^}, \code{\%in\%}), as well as the function \code{\link{I}}. In addition, the variables in character strings can be enclosed within other functions: \code{"log(x)"}, for instance, represents the natural logarithm of \code{x}.

The \code{summary} object obtained from the regression function specified in argument \code{reg.fun} should contain a \code{coefficients} matrix component. \code{eba} will collect the coefficient estimates, standard errors, test statistics and p-values from the first, second, third and fourth columns of the \code{coefficients} matrix, respectively. The number of observations is equal to \code{length(x$residuals)}, where \code{x} is the regression model object. 

The calculation of weights based on McFadden's likelihood ratio index (see argument \code{weights}) relies on the generic accessor function \code{logLik}. If \code{weights} are based on the regression's R-squared and adjusted R-squared, \code{eba} obtains the values of these statistics from the model object's components \code{r.squared} and \code{adj.r.squared}, respectively.
%%  ~~ If necessary, more details than the description above ~~
}
\value{
\code{eba} returns an object of class \code{"eba"}. The corresponding \code{summary} function (i.e., \code{summary.eba}) returns the same object.

An object of class \code{"eba"} is a list containing the following components:
\item{bounds}{a data frame with the results of the extreme bounds analysis. The data frame \code{bounds} contains the following columns:
 \itemize{
    \item \code{type}: type of reported variable - either \code{"free"} or \code{"focus"}.
    \item \code{mu}: the regression coefficient under the null hypothesis.
    \item \code{beta.below.mu}: proportion of estimated regression coefficients whose value is less than \code{mu}.
    \item \code{beta.above.mu}: proportion of estimated regression coefficients whose value is greater than \code{mu}.
    \item \code{beta.significant}: proportion of regression models in which the estimated coefficient is statistically significantly different from \code{mu}.
    \item \code{beta.significant.below.mu}: proportion of estimated regression coefficients that are both statistically significantly different from and whose value is less than \code{mu}.
    \item \code{beta.significant.above.mu}: proportion of estimated regression coefficients that are both statistically significantly different from and whose value is greater than \code{mu}.
    \item \code{leamer.lower}: Leamer's lower extreme bound at the specified confidence level.
    \item \code{leamer.upper}: Leamer's upper extreme bound at the specified confidence level.
    \item \code{leamer.robust}: logical value indicating whether the variable is robust based on Leamer's extreme bounds analysis. If \code{leamer.lower} and \code{leamer.upper} have the same sign, the value will be \code{TRUE}. If they have opposite signs, \code{leamer.robust} will be \code{FALSE}.
    \item \code{cdf.mu.normal}: the value of the cumulative density function at CDF(\code{mu}) - i.e., the proportion of coefficients that are estimated to be lower or equal to \code{mu} - based on Sala-i-Martin's EBA that assumes that regression coefficients are normally distributed across the estimated models. Weights specified by \code{eba}'s argument \code{weights} are applied.
    \item \code{cdf.above.mu.normal}: equal to \code{1 - cdf.mu.normal}. This value represents the proportion of coefficients that are estimated to be greater than \code{mu}, based on Sala-i-Martin's EBA that assumes that regression coefficients are normally distributed across the estimated models. Weights specified by \code{eba}'s argument \code{weights} are applied.
        \item \code{cdf.mu.generic}: the value of the cumulative density function at CDF(\code{mu}) based on Sala-i-Martin's EBA that does not assume any particular distribution of regression coefficients across the estimated models. Weights specified by \code{eba}'s argument \code{weights} are applied.
    \item \code{cdf.above.mu.generic}: equal to \code{1 - cdf.mu.generic}. This value represents the proportion of coefficients that are estimated to be greater than \code{mu}, based on Sala-i-Martin's EBA that does not assume any particular distribution of regression coefficients across the estimated models. Weights specified by \code{eba}'s argument \code{weights} are applied.
  }
}
\item{call}{the matched call.}
\item{coefficients}{a list that contains data frames with selected quantities of interest that emerge from the extreme bounds analysis. This list can also be extracted by calling the generic accessor function \code{coefficients} on the \code{"eba"} object. The list \code{coefficients} contains the following data frame components:
  \itemize{
    \item \code{cdf.generic.unweighted}: the CDF(\code{mu}) and (1-CDF(\code{mu})) based on Sala-i-Martin's generic EBA that does not assume any distribution of regression coefficients across models. Each regression model receives an equal weight.
    \item \code{cdf.generic.weighted}: the CDF(\code{mu}) and (1-CDF(\code{mu})) based on Sala-i-Martin's generic EBA that does not assume any distribution of regression coefficients across models. Individual regression models receive a weight specified by the argument \code{weights}.
    \item \code{min}: the value of the lowest regression coefficient across the estimated models, along with additional statistics.
    \item \code{max}: the value of the highest regression coefficient across the estimated models, along with additional statistics.
    \item \code{mean}: the mean of the estimated regression coefficients, standard errors and variances. Each regression model receives an equal weight. Note that the mean of the variances will generally not be equal to the square of standard errors.
    \item \code{weighted.mean}: the weighted mean of the estimated regression coefficients, standard errors and variances. Individual regression models receive a weight specified by the argument \code{weights}. Note that the weighted mean of the variances will generally not be equal to the square of standard errors.
    \item \code{median}: the value of the median regression coefficient across the estimated models, along with additional statistics. If no unambiguous median value exists, \code{NA} is reported.
    \item \code{median.lower}: the value of the median regression coefficient across the estimated models, along with additional statistics. If no unambiguous median value exists, the lower of the two 'potential median' coefficients is reported.
    \item \code{median.higher}: the value of the median regression coefficient across the estimated models, along with additional statistics. If no unambiguous median value exists, the higher of the two 'potential median' coefficients is reported.
    \item \code{min.ci.lower}: the minimum value of the lower bound of the confidence interval (at the requested confidence level) across the estimated models, along with additional statistics. This value represents the lower extreme bound in Leamer's EBA.
    \item \code{max.ci.upper}: the maximum value of the upper bound of the confidence interval (at the requested confidence level) across the estimated models, along with additional statistics. This value represents the upper extreme bound in Leamer's EBA.
  }
}
\item{mu}{a named vector of regression coefficients under the null hypothesis for each variable.}
\item{level}{a number between 0 and 1 that indicates the confidence level for hypothesis testing.}
\item{ncomb}{total number of doubtful variable combinations that include at least one focus variable.}
\item{nreg}{total number of regressions that were estimated as part of the extreme bounds analysis. When \code{draws} is NULL (i.e., no random sampling of regression models is requested), \code{ncomb} and \code{nreg} will be equal.}
\item{nreg.variable}{a named vector containing the the number of estimated regressions that included each variable.}
\item{ncoef.variable}{a named vector containing the the number of estimated coefficients that were used in the extreme bounds analysis. This number can differ from \code{nreg.variable} when \code{vif} or \code{include.fun} is specified.}
\item{regressions}{a list that contains estimation results for each regression that was run as part of the extreme bounds analysis. This list contains several components which store quantities such as coefficient or standard error estimates for each of the estimated regressions. Each of these components is a matrix whose number of rows corresponds to the total number of regressions (equal to \code{nreg}) and whose columns represent individual regressors. In each of the component matrices, results from a particular regression model will be included in the same row. The list \code{regressions} contains the following components:
  \itemize{
    \item \code{beta}: regression coefficients.
    \item \code{se}: standard errors.
    \item \code{var}: variances of the regression coefficients. This value is equal to the square of \code{se}.
    \item \code{t}: test statistics (typically t- or z-statistics; might depend on the regression function used - see argument \code{reg.fun}).
    \item \code{p}: p-values.
    \item \code{ci.lower}: lower bound of the confidence interval for the requested confidence level (see argument \code{level}).
    \item \code{ci.upper}: upper bound of the confidence interval for the requested confidence level (see argument \code{level}).
    \item \code{nobs}: number of observations.
    \item \code{vif}: variance inflation factor (VIF).
    \item \code{vif.satisfied}: a logical value that indicates whether the variance inflation factor is within the set maximum limit (see argument \code{vif}).
    \item \code{formula}: a character string containing the model formula, a symbolic description of the model that was fitted.
    \item \code{weight}: a numerical value that represents the weight that is given to a particular regression model in the extreme bounds analysis.
    \item \code{cdf.mu.generic}: the value of cumulative distribution function of the regression coefficients at the value of \code{mu}. The coefficients are assumed to be distributed normally with a mean given by the regression model's coefficient estimate and with a standard deviation given by the estimated standard error. This value is used in estimating the generic version of Sala-i-Martin's EBA.
    \item \code{include}: a logical value (TRUE or FALSE) that indicates whether the corresponding model's estimation results are included in the extreme bounds analysis (based on the argument \code{include.fun}).
    }
  }
}
\references{
McFadden, Daniel L. (1974). Conditional Logit Analysis of Qualitative Choice Behavior. In: P. Zarembka (Ed.), \emph{Frontiers in Econometrics}, Academic Press: New York, 105-142.

Leamer, Edward E. (1985). Sensitivity Analysis Would Help. \emph{American Economic Review}, 57(3), 308-313.

Levine, Ross, and David Renelt. (1992). A Sensitivity Analysis of Cross-Country Growth Regressions. \emph{American Economic Review}, 82(4), 942-963.

Sala-i-Martin, Xavier. (1997). I Just Ran Two Million Regressions. \emph{American Economic Review}, 87(2), 178-183.
}
\author{
%%  ~~who you are~~
Marek Hlavac   < hlavac at fas.harvard.edu > \cr
Harvard University, Political Economy and Government \cr
}
\section{Please cite as:}{
Hlavac, Marek (2014). ExtremeBounds: Extreme Bounds Analysis in R.\cr
R package version 0.1.2. http://CRAN.R-project.org/package=ExtremeBounds 
}
\seealso{
\code{\link{hist.eba}}, \code{\link{print.eba}}
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
# perform Extreme Bound Analysis
eba.results <- eba(data = mtcars[1:10, ], y = "mpg", free = "wt",
                   doubtful = c("cyl","disp","hp","drat","qsec","vs","am","gear","carb"),
                   focus = c("hp","gear"), 
                   exclusive = list(c("cyl","disp","hp"), c("am","gear")))

# print out results
print(eba.results)

# create histograms
hist(eba.results, variables = c("hp","gear"),
     main = c("hp" = "Gross horsepower", "gear" = "Number of forward gears"))
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
}
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
\keyword{ robust }
\keyword{ multivariate }

