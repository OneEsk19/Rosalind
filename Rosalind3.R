## Finding a Protein Motif

# 1) will recieve a file with uniProt IDs
# 2) need to scrape protein sequence from ID
# 3) then need to search for sequence N{P}[ST]{P} and supply 
# the location of each motif per protein sequence

# 1_

## Read in the data
ProtMot <- read.table("rosalind_mprt.txt")
View(ProtMot)


## Loop through the data elements and generate a url for each
for(i in ProtMot) {
      fastaURLs = paste0('https://www.uniprot.org/uniprot/',i, '.fasta') # WORKS
}
View(fastaURLs)
##


if (!requireNamespace("BiocManager", quietly = TRUE))
   install.packages("BiocManager")

BiocManager::install("Biostrings")
library(Biostrings)


## Loop through list of URLs in fastaURLS and read the AA string from the corresponding webpage
x <- list()
for (i in fastaURLs) {
      fastafile <- readAAStringSet(i)
      seq_name = names(fastafile)
      seq = paste(fastafile)
      x[i] <- data.frame(seq)
}
## extract each sequence element from the list into a vector
ProtSeq <- c(x[[1]],x[[2]],x[[3]],x[[4]],x[[5]],x[[6]],x[[7]],x[[8]],x[[9]],x[[10]],
             x[[11]],x[[12]],x[[13]])
View(ProtSeq)

## produce a table of unique ID's, thier fasta webpage and extracted sequences
finaltable <- data.frame(ProtMot$V1, fastaURLs, ProtSeq) 

View(finaltable)
