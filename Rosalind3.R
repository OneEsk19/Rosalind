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


library(Biostrings)

## Loop through list of URLs in fastaURLS and read the AA string from the corresponding webpage
x <- list()
for (i in fastaURLs) {
      fastafile <- readAAStringSet(i)
      seq_name = names(fastafile)
      seq = paste(fastafile)
      x[i] <- data.frame(seq)
}


## extract each sequence element from the list into a dataframe
testdf <- data.frame(unlist(x))
## remove rownames and convert to variable
testdf1 <- cbind(rownames(testdf), data.frame(testdf, row.names=NULL))
## add protein IDs from which the URLs were generated as a variable and renmae columns
pro_table <- cbind(ProtMot, testdf1)
colnames(pro_table) <- c("ID", "URL", "SEQUENCE")


View(pro_table)

###### NEXT STAGE IS TO find the n glycosylation motif 



