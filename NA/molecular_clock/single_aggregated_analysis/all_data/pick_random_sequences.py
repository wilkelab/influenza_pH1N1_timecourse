from Bio import SeqIO
import random, sys

def pick_seq(in_file, out_file, num_sequences):
    input_handle = open(in_file, 'r')
    records = list(SeqIO.parse(input_handle, "fasta"))
    input_handle.close()
    print(len(records))
    if len(records) > num_sequences:
        small_records = random.sample(records, num_sequences)
    else:
        small_records = records

    output_handle = open(out_file, 'w')
    SeqIO.write(small_records, output_handle, "fasta")
    output_handle.close

def main():
    if len(sys.argv) != 4:
        print "Please provide infile, outfile, and number of sequences as command-line arguments"
    else:
        pick_seq(sys.argv[1], sys.argv[2], int(sys.argv[3]))

main()
