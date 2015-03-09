#!/usr/bin/python
from Bio import SeqIO
import numpy as np
from sets import Set
import sys


def count_codons(infile, outfile):
    handle = list(SeqIO.parse(open(infile, "rU"), 'fasta'))
    number_codons = [[] for i in range(len(handle[0])/3)]
    for sequence in handle:
      for site in range(len(number_codons)):
        number_codons[site].append(str(sequence.seq[site:site+3]))
   
    number_distinct_codons = [0 for i in range(len(handle[0])/3)]
    for site in range(len(number_codons)):
      number_distinct_codons[site] = len(Set(number_codons[site]))

    output_handle = open(outfile, "w")
    output_handle.write('num_codon\n')
    for site in number_distinct_codons:
      output_handle.write(str(site) + '\n')
    output_handle.close()

if len(sys.argv) != 3:
    print "Please provide infile and outfile as command-line arguments"
else:
    count_codons(sys.argv[1], sys.argv[2])
