evilRegex<-function(){
max.N <- 25
times.list <- list()
for(N in 1:max.N){
  cat(sprintf("subject/pattern size %4d / %4d\n", N, max.N))
  subject <- paste(rep(c("a","X"), c(N,1)), collapse="")
  pattern <- "^(a+)+$"
  N.times <- microbenchmark::microbenchmark(
    ICU=stringi::stri_match(subject, regex=pattern),
    PCRE=regexpr(pattern, subject, perl=TRUE),
    TRE=regexpr(pattern, subject, perl=FALSE),
    RE2=re2r::re2_match(subject, pattern),
    times=10)
  times.list[[N]] <- data.frame(N, N.times)
}
times <- do.call(rbind, times.list)
save(times, file="times.RData")

library(ggplot2)
library(directlabels)
linear.legend <- ggplot()+
  ggtitle("Timing regular expressions in R, linear scale")+
  scale_y_continuous("seconds")+
  scale_x_continuous("subject/pattern size",
                     limits=c(1, 27),
                     breaks=c(1, 5, 10, 15, 20, 25))+
  geom_point(aes(N, time/1e9, color=expr),
             shape=1,
             data=times)
(linear.dl <- direct.label(linear.legend, "last.polygons"))
png("figure-complexity-linear.png")
print(linear.dl)
dev.off()

log.legend <- ggplot()+
  ggtitle("Timing regular expressions in R, log scale")+
  scale_y_log10("seconds")+
  scale_x_log10("subject/pattern size",
                limits=c(1, 30),
                breaks=c(1, 5, 10, 15, 20, 25))+
  geom_point(aes(N, time/1e9, color=expr),
             shape=1,
             data=times)
(log.dl <- direct.label(log.legend, "last.polygons"))
png("figure-complexity-log.png")
print(log.dl)
dev.off()
}

goodRegex<-function(){

  homicides <- readLines("homicides.txt")
  max.N <- 25
  times.list <- list()
  for(N in 1:max.N){
    cat(sprintf("subject/pattern size %4d / %4d\n", N, max.N))
    x<-paste(homicides[1:N], collapse=" ")
    N.times <- microbenchmark::microbenchmark(
      ICU= stringi::stri_match(x, regex="<dd>[F|f]ound(.*?)</dd>"),
      PCRE= regexpr("<dd>[F|f]ound(.*?)</dd>", x, perl=TRUE),
      TRE=regexpr("<dd>[F|f]ound(.*?)</dd>", x, perl=FALSE),
      RE2=re2r::re2_match(x,"<dd>[F|f]ound(?P<Date>.*?)</dd>" ),
      times=10)

    times.list[[N]] <- data.frame(N, N.times)
  }
  times <- do.call(rbind, times.list)
  save(times, file="times.RData")

  library(ggplot2)
  library(directlabels)
  linear.legend <- ggplot()+
    ggtitle("Timing regular expressions in R, linear scale")+
    scale_y_continuous("seconds")+
    scale_x_continuous("subject/pattern size",
                       limits=c(1, 27),
                       breaks=c(1, 5, 10, 15, 20, 25))+
    geom_point(aes(N, time/1e9, color=expr),
               shape=1,
               data=times)
  (linear.dl <- direct.label(linear.legend, "last.polygons"))
  png("figure-complexity-linear-good.png")
  print(linear.dl)
  dev.off()

  log.legend <- ggplot()+
    ggtitle("Timing regular expressions in R, log scale")+
    scale_y_log10("seconds")+
    scale_x_log10("subject/pattern size",
                  limits=c(1, 30),
                  breaks=c(1, 5, 10, 15, 20, 25))+
    geom_point(aes(N, time/1e9, color=expr),
               shape=1,
               data=times)
  (log.dl <- direct.label(log.legend, "last.polygons"))
  png("figure-complexity-log-good.png")
  print(log.dl)
  dev.off()
}
