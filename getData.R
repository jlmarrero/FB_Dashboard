getPageData <- function(x) {
  hd <- read.csv(x, nrows = 1)
  df <- read.csv(x, skip = 2, stringsAsFactors = FALSE)
  
  colnames(df) <- colnames(hd)
  
  return(df) 
}

getPostData <- function(x) {
  hd <- read.csv(x, nrows = 1)
  df <- read.csv(x, skip = 2, stringsAsFactors = FALSE)
  
  colnames(df) <- colnames(hd)
  
  return(df) 
}