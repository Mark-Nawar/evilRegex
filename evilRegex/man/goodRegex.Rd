\name{goodRegex}
\alias{goodRegex}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
   A Good Regular Expression Example
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
goodRegex()
}
%- maybe also 'usage' for other objects documented here.
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function ()
{
    homicides <- readLines("homicides.txt")
    max.N <- 25
    times.list <- list()
    for (N in 1:max.N) {
        cat(sprintf("subject/pattern size \%4d / \%4d\n", N, max.N))
        x <- paste(homicides[1:N], collapse = " ")
        N.times <- microbenchmark::microbenchmark(ICU = stringi::stri_match(x,
            regex = "<dd>[F|f]ound(.*?)</dd>"), PCRE = regexpr("<dd>[F|f]ound(.*?)</dd>",
            x, perl = TRUE), TRE = regexpr("<dd>[F|f]ound(.*?)</dd>",
            x, perl = FALSE), RE2 = re2r::re2_match(x, "<dd>[F|f]ound(?P<Date>.*?)</dd>"),
            times = 10)
        times.list[[N]] <- data.frame(N, N.times)
    }
    times <- do.call(rbind, times.list)
    save(times, file = "times.RData")
    library(ggplot2)
    library(directlabels)
    linear.legend <- ggplot() + ggtitle("Timing regular expressions in R, linear scale") +
        scale_y_continuous("seconds") + scale_x_continuous("subject/pattern size",
        limits = c(1, 27), breaks = c(1, 5, 10, 15, 20, 25)) +
        geom_point(aes(N, time/1e+09, color = expr), shape = 1,
            data = times)
    (linear.dl <- direct.label(linear.legend, "last.polygons"))
    png("figure-complexity-linear.png")
    print(linear.dl)
    dev.off()
    log.legend <- ggplot() + ggtitle("Timing regular expressions in R, log scale") +
        scale_y_log10("seconds") + scale_x_log10("subject/pattern size",
        limits = c(1, 30), breaks = c(1, 5, 10, 15, 20, 25)) +
        geom_point(aes(N, time/1e+09, color = expr), shape = 1,
            data = times)
    (log.dl <- direct.label(log.legend, "last.polygons"))
    png("figure-complexity-log.png")
    print(log.dl)
    dev.off()
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
