######## ROSALIND SOLUTIONS FOR:
# 1. Counting DNA Nucleotides
# 2. Transcribing RNA into DNA
# 3. Complementing a Strand of DNA
# 4. Translating RNA into Protein
# 5. Calculating Protein Mass

########################################################
# 1. Counting DNA Nucleotides
# read in a file of bases
with open("c:/Users/georg/Documents/Rosalind/rosalind_dna.txt", "r") as f:
    dna3 = f.read()

print(dna3)

# count how many nucleotides there are

baseDict = {"A":0, "C":0, "G":0, "T":0}

for base_req in baseDict:
    baseDict[base_req] += dna3.count(base_req)
print(baseDict)

#######################################################
# 2. Transcribing RNA into DNA
# read in a file of bases
with open("c:/Users/georg/Documents/Rosalind/rosalind_rna.txt", "r") as f1:
    trans = f1.read()

transcribed = trans.replace("T", "U")

print(transcribed)

#######################################################
# 3. Complementing a Strand of DNA

with open("c:/Users/georg/Documents/Rosalind/rosalind_revc.txt", "r") as f2:
    dnasource = f3.read()

compliment = dnasource.replace("T", "X").replace("G", "Y").replace("C", "G").replace("A", "T").replace("Y", "C").replace("X", "A")
## a really nice solution i saw afterwards was to replace them with lowercase
## and then just change them to upper, which negates the need for X and Y transitions

# reverse the compliment
def reverse(string):
    string = "".join(reversed(string))
    return(string)

print(reverse(compliment))

#######################################################
# 4. Translating RNA into Protein
with open("c:/Users/georg/Documents/Rosalind/rosalind_prot.txt", "r") as f4:
    rnasource = f4.read()

import pandas as pd

# read in the codon table as a dataframe and create colname
codes = pd.read_table("genetic_code.tsv", sep="\t", header=None)
codes.columns =["codon", "single", "triple", "amino-acid"]

# zip is a cool function that iterates tuples from dataframe cols
codedict = dict(zip(codes.codon, codes.single))
# create a vector for the result
protein = ""

for i in range(0, len(rnasource)-3, 3):
    protein += codedict[rnasource[i:i+3]]

print(protein)

#######################################################
# 5. Calculating Protein Mass
# Note: the monoisotopic mass of water is considered to be 18.01056 Da.
# Not sure what i need to do with this, so i ignored it!

with open("c:/Users/georg/Documents/Rosalind/rosalind_prtm.txt", "r") as f5:
    proteins = f5.read()

import pandas as pd

# read in the weights table as a dataframe and create colnames
pmass = pd.read_table("pmass.tsv", sep="   ", header=None)
pmass.columns = ["pcode", "mass"]
pmass["pcount"] = 0

# create dictionaries
pmassdict = dict(zip(pmass.pcode, pmass.mass))
pmasscount = dict(zip(pmass.pcode, pmass.pcount))

# count how many of each pcode there is
for i in pmasscount:
    pmasscount[i] += proteins.count(i)

# multiply the counts by the masses and update the count
for key in pmasscount:
    if key in pmassdict:
        pmasscount[key] = pmasscount[key] * pmassdict[key]
    else:
        pass

# this is another method using dictionary comprehension or something, it does work, but i don't get it tbh
# masses = {j:k * pmasscount[j] for j, k in pmassdict.items() if j in pmasscount}
# print(masses)

# now i need to add everything up
print(sum(pmasscount.values()))