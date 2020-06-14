install.packages("tidyverse")

install.packages("stringr")
library(stringr)

######## ex1. "counting DNA nucleotides"
      rosalind1 <- readLines("rosalind_dna.txt") ## Base R
      str_count(rosalind1, c("A","C", "G", "T")) ## stringr

######## ex2. "Transcribing RNA into DNA"
      rosalind2 <- readLines("rosalind_rna.txt") 
      print(rosalind2)
      rosalind2a <- str_replace_all(rosalind2, "T", "U")
      print(rosalind2a)

######### ex3, "Complementing a Strand of DNA"
      ## reverse and complement an input DNA string
            library(stringi)

            ros3 <- readLines("rosalind_revc.txt")

## Sequential Changes to perform transcription                           
T_to_X <- str_replace_all(ros3, "T", "X") ## immunising original T's by changing to "X"
A_to_T <- str_replace_all(T_to_X, "A", "T") ## transcribing A to T
X_to_A <- str_replace_all(A_to_T, "X", "A") ## transcribing original T (X) to A
C_to_Y <- str_replace_all(X_to_A, "C", "Y") ## Immunising original C by replacing with "Y"
G_to_C <- str_replace_all(C_to_Y, "G", "C") ## transcribing G to C
Y_to_G <- str_replace_all(G_to_C, "Y", "G") ## transcribing original C (Y) to G

ros3revComp <- stri_reverse(Y_to_G) ## stringi
print(ros3revComp)


############# "Translating RNA into Protein"


# Installation of Biostrings package
if (!requireNamespace("BiocManager", quietly = TRUE))
      install.packages("BiocManager")
BiocManager::install("Biostrings")
library(Biostrings)

ros_translating <- readLines("rosalind_prot.txt")
print(ros_translating)
###///////could add an IF script here
##if U is found in string then run dna translate

## If Dna
dnasample <- DNAString(ros_translating)
translate(dnasample)

##if RNA
RNAsample <- RNAString(ros_translating)
Result <- translate(RNAsample) ## this saves the translated string as a special object "AAString", which will not print
## in its entirety
as.character(Result) ## This command converts it to a string which CAN be displayed in its entirety

#########################################################################################################################

########## Calculating Protein Mass

      # In a weighted alphabet, every symbol is assigned a positive real number called a weight. A string formed from a 
      # weighted alphabet is called a weighted string, and its weight is equal to the sum of the weights of its symbols.
      # The standard weight assigned to each member of the 20-symbol amino acid alphabet is the monoisotopic mass of 
      # the corresponding amino acid.
      # 
      # Given: A protein string P of length at most 1000 aa.
      # 
      # Return: The total weight of P. Consult the monoisotopic mass table.

setwd("~/R messin")

## this needs ti be installed for the str_count command in the loop to work
install.packages("stringr")
library(stringr) 

# read in the molecular weight table + store as datatable
      AA_MWs <- read.table("AA_MWs.txt", header = FALSE, sep = " ")

# store the amono acids in a list
      AAList <- list(AA_MWs$V1) 

# store the test string
      peptidestring <- readLines("rosalind_prtm.txt") 

## for each item in AAlist, count the occurence of that variable in peptidestring store the result in a vector named "Frequency"
            for(loopitem in AAList){
                  frequency <- str_count(peptidestring, loopitem) ## stringr package
                   }

## add the frequencies to the datable AAList
      AA_MWs <- cbind(AA_MWs, frequency)

## multiply the "Frequency" by the "molecular weight" and store this in another column? "Total Weight"
      totals <- (AA_MWs$V2 * AA_MWs$frequency)
      format(totals, nsmall = 5)

## add all values in "Total weight" and store as variable "PepWeight"
      pepweight <- format(sum(totals), nsmall = 3)
            print(pepweight)


