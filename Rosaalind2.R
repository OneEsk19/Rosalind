######## ROSALIND SOLUTIONS FOR:
# 1. Computjing GC content
# 2. Finding a Motif in DNA
# 3. Counting Point Mutations
# 4. Finding a Protein Motif


########### Computing GC Content

library(seqinr)
library(LncFinder)

RosGCC <- read.fasta("rosalind_gc.txt") ## seqinr package
View(RosGCC)

compute_GC(RosGCC, label = NULL, on.ORF = FALSE, ## LncFinder package
           auto.full = FALSE, parallel.cores = -1)

###########################################################################

############ Finding a Motif in DNA

RosMotif <- read.table("rosalind_subs.txt") ## Base R
      View(RosMotif)

Motif <- RosMotif[2,1]
      View(Motif)

TestSeq <- RosMotif[1,1]
      View(TestSeq)
      
#### --------------     DId NOT ACCOUNT FOR OVERLAPS!
start_end <- str_locate_all(TestSeq, Motif) ## stringr
SEdf <- as.data.frame(start_end)
print(SEdf$start)
View(SEdf)
#### -----------

library(pracma) ### can detect overlaps!
strfind(TestSeq, Motif, overlap = TRUE) ## pracma

######################################################################

##### Counting Point Mutations

CountingMut <- read.table("rosalind_hamm.txt") ## Base R


str1 <- CountingMut[1,]
str2 <- CountingMut[2,]


library(stringdist)
stringdist(str1, str2, method ="hamming")

## non-package solution:
# from: https://github.com/cdeterman/Rosalind/commit/b4b46a69c7c2ae14dec71a3d7a64acc5d1c5f5f4
      # seq1 = unlist(strsplit(raw_data[1], split = ""))
      # seq2 = unlist(strsplit(raw_data[2], split = ""))
      # 
      # mutations = 0
      # for (i in seq(nchar(raw_data[1]))){
      #       if(seq1[i] != seq2[i]){
      #             mutations = mutations + 1
      #       }
      # }
      # mutations

#####################################################################

## Finding a Protein Motif

# 1) will recieve a file with uniProt IDs
# 2) need to scrape protein sequence from ID
# 3) then need to search for sequence N{P}[ST]{P} and sum
# the occurrences in each protein sequence

# 1_

ProtMot <- read.table("rosalind_mprt.txt")
View(ProtMot)


source("https://bioconductor.org/biocLite.R")
biocLite("Rcpi")

id = c('P00750', 'P00751', 'P00752')



getFASTAFromUniProt(id)






