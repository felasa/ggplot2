% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/geom-smooth.r
\name{geom_smooth}
\alias{geom_smooth}
\title{Add a smoothed conditional mean.}
\usage{
geom_smooth(mapping = NULL, data = NULL, stat = "smooth",
  position = "identity", show_guide = NA, ...)
}
\arguments{
\item{mapping}{The aesthetic mapping, usually constructed with
\code{\link{aes}} or \code{\link{aes_string}}. Only needs to be set
at the layer level if you are overriding the plot defaults.}

\item{data}{A data frame. If specified, overrides the default data frame
defined at the top level of the plot.}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string.}

\item{position}{Postion adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{show_guide}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.}

\item{...}{Additional arguments passed on to \code{\link{stat_smooth}} and
the underlying statistical model.}
}
\description{
Add a smoothed conditional mean.
}
\section{Aesthetics}{

\Sexpr[results=rd,stage=build]{ggplot2:::rd_aesthetics("geom", "smooth")}
}
\examples{
ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  geom_smooth()

ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# See ?stat_smooth for more examples of using built in model fitting
# --------------------------------------------------------------

# If you need more flexibility, this example shows you how to do
# it by hand
ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point()

ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

model <- lm(mpg ~ wt + factor(cyl), data = mtcars)
grid <- with(mtcars, expand.grid(
  wt = seq(min(wt), max(wt), length = 20),
  cyl = levels(factor(cyl))
))
grid$mpg <- stats::predict(model, newdata = grid)

ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
  geom_point() +
  geom_line(data = grid, size = 1)

# or with standard errors
err <- stats::predict(model, newdata=grid, se = TRUE)
grid$ucl <- err$fit + 1.96 * err$se.fit
grid$lcl <- err$fit - 1.96 * err$se.fit

ggplot(mtcars, aes(wt, mpg)) +
  geom_point(aes(colour = factor(cyl))) +
  geom_ribbon(aes(ymin = lcl, ymax = ucl, group = cyl), data = grid,
    fill = alpha("grey60", 0.4)) +
  geom_line(aes(colour = factor(cyl)), data = grid, size = 1)
}
\seealso{
The default stat for this geom is \code{\link{stat_smooth}} see
  that documentation for more options to control the underlying statistical
  model.
}

