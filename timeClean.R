fbPostTimeClean <- function(x) {
  # Splitting the date and time into separate parts 
  # Parts: V1 = Date; V2 = Time; V3 = AM/PM;
  dfTime <- x
  dfTimeParts <- t(as.data.frame(strsplit(as.character(dfTime),' ')))
  dfTimeParts <- as.data.frame(dfTimeParts)
  dfTimeParts$V1 <- as.Date(dfTimeParts$V1, format = "%m/%d/%Y")
  dfTimeParts$V4 <- month(dfTimeParts$V1, label = TRUE)
  dfTimeParts$V5 <- weekdays(dfTimeParts$V1)
 
  return(dfTimeParts)
}

twTweetTimeClean <- function(x) {
  # Splitting the date and time into separate parts 
  # Parts: V1 = Date; V2 = Time; V3 = AM/PM;
  time <- x
  dfTimeParts <- t(as.data.frame(strsplit(as.character(time),' ')))
  dfTimeParts <- as.data.frame(dfTimeParts)
  dfTimeParts$V1 <- as.Date(dfTimeParts$V1, format = "%Y-%m-%d")
  dfTimeParts$V4 <- month(dfTimeParts$V1, label = TRUE)
  dfTimeParts$V5 <- weekdays(dfTimeParts$V1)
  
  return(dfTimeParts)
}

addPostParts <- function(df, time) {
  df$Posted <- as.Date(time$V1, format = "%m/%d/%Y")
  df$Time <- time$V2
  df$AMPM <- time$V3
  df$Month <- time$V4
  df$Weekday <- time$V5
  
  return(df)
}

addTweetParts <- function(df, time) {
  df$Posted <- as.Date(time$V1, format = "%Y-%m-%d/")
  df$Time <- time$V2
  df$AMPM <- time$V3
  df$Month <- time$V4
  df$Weekday <- time$V5
  
  return(df)
}