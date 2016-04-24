#############################################
          #SCRIPT NUMBER: 04
          #AUTHOR: Dheeraj Agarwal
          #PURPOSE: Create a universal clean regex function
          #DEPENDENCIES: Script 01
          #DATE: April 18, 2016
#############################################
CleanR <- function(file){
  file <- tolower(file)
  file <- str_replace_all(file, "([iu]n)-([a-z])", "\\1\\2")
  file <- str_replace_all(file, " \\'|\\' ", " ")
  file <- str_replace_all(file, "([abiep])\\.([cdegm])\\.", "\\1\\2")
  file <- str_replace_all(file, "[^a-z.' ]", " ")
  file <- str_replace_all(file, "([a-z])\\.([a-z])", "\\1 \\2")
  file <- str_replace_all(file, "([0-9])(st|nd|rd|th)", "\\1")
  file <- str_replace_all(file, "( [a-z])\\. ", "\\1 ")
  file <- str_replace_all(file, " (m[rs]|mrs)\\.", " \\1 ")
  file <- str_replace_all(file, " (dr|st|rd|av|ave|blvd|ct)\\.", " \\1 ")
  file <- str_replace_all(file, "\\.$", "")
  file <- str_replace_all(file, "^ +| +$|", "")
  file <- str_replace_all(file, " *\\. *","\\.")
  file <- str_replace_all(file, " {2,}", " ")
  file <- str_replace_all(file, "www [a-z]+ [a-z]+", "")
  file <- str_replace_all(file, " ([a-z])\\1+ |^([a-z])\\1+ | ([a-z])\\1+$|^([a-z])\\1+$", " ")
  file <- str_replace_all(file, "([a-z])\\1{2,}", "\\1\\1")
  file <- str_replace_all(file, "\\'+([a-z]+)\\'+", "\\1")
  file <- str_replace_all(file, "\\'+ \\'+", " ")
  file <- str_replace_all(file, "(\\'+ )+|( \\'+)+|^\\'+|\\'+$", " ")
  file <- str_replace_all(file, "^[a-z]+$", "")
  file <- str_replace_all(file, "( [^ai])+ |^([^ai] )+|( [^ai])+$", " ")
  file <- str_replace_all(file, " +$|^ +", "")
  return(file)
}

Splitter <- function(file){
  file <- str_split(file, "\\.")
  file <- unlist(file)
  file <- file[file != ""]
}