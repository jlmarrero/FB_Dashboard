timeClean <- function(x) {
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
