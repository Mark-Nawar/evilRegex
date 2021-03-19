# RE2R-back-on-CRAN
# R package that benchmark regular expression functions.
# To install this package follow the following steps carefully:

note: you have to have Rstudio installled on your machine follow the instructions [here](https://rstudio.com/products/rstudio/download/) to download it if you don't already have it.


1- Install Rtools:  [click here](https://cran.r-project.org/bin/windows/Rtools/) and type the following code in the R console
```
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
```
Now Restart R and write this code and check the output:
```
Sys.which("make")
## "C:\\rtools40\\usr\\bin\\make.exe"
```

2- Install devtools:
```
install. packages("devtools")
library(devtools)
```

3- Install the regular expression functions:
```
install.packages("microbenchmark")
install.packages("ggplot2")
install.packages("directlabels")
install.packages("stringi")
install_github("qinwf/re2r", build_vignettes = T)
```

4-Install this package evilRegex( RE2R-back-on-CRAN):
```
install_github("Mark-Nawar/RE2R-back-on-CRAN", build_vignettes = T)
```



