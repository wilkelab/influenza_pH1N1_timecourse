from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC
import shutil, datetime, calendar 

def clean_sequences(folder):
    handle = open_alignment(folder + 'nucleotide.fasta')
    cleaned_sequences = []

    for seq in handle:
        date_formate = check_date(str(seq.id).split('|')[1])
        if not date_formate:
            continue

        cleaned_sequences.append(SeqRecord(Seq(str(seq.seq), IUPAC.unambiguous_dna), id=seq.id, description=''))

    shutil.copy('nucleotide.fasta', 'nucleotide.bak')    
    SeqIO.write(cleaned_sequences, open('nucleotide.fasta', 'w'), "fasta")

def format_taxa(folder):
    handle = open_alignment(folder + 'nucleotide.fasta')

    output = "  <taxa id=\"taxa\">\n"

    for seq in handle:
        split_id = str(seq.id).split('|')
        new_id = split_id[0].replace('/', '_').strip()

        year, time_in_year = format_date(split_id[1].strip())

        output += "    <taxon id=\"" + new_id + "\">\n      <date value=\"" + year + time_in_year[1:] + "\" direction=\"forwards\" units=\"years\" precision=\"0.0\"/>\n    </taxon>\n"

    output += "  </taxa>"
    
    return(output)

def format_sequences(folder):
    handle = open_alignment(folder + 'nucleotide.fasta')
    
    output = "  <alignment id=\"alignment\" dataType=\"nucleotide\">\n"

    for seq in handle:
        split_id = str(seq.id).split('|')
        new_id = split_id[0].replace('/', '_').strip()
        output += "    <sequence>\n      <taxon idref=\"" + str(new_id) + "\"/>\n      " + str(seq.seq) + "\n    </sequence>\n"

    output += "  </alignment>"
    
    return(output)

def open_alignment(path):
    return(list(SeqIO.parse(open(path, 'r'), 'fasta')))

def check_date(string_date):
    try:
        string_date = datetime.datetime.strptime(string_date, "%m/%d/%Y")
    except:
        return False

    return True

def format_date(string_date):
    string_date = datetime.datetime.strptime(string_date, "%m/%d/%Y")
    day_of_year = string_date.timetuple().tm_yday

    if calendar.isleap(string_date.year):
        time_in_year = day_of_year / float(366)
    else:
        time_in_year = day_of_year / float(365)

    return(str(string_date.year), str(time_in_year))

def main():
    clean_sequences('./')
    taxa = format_taxa('./')
    sequences = format_sequences('./')

    handle = open('taxa_sequence_input.xml', 'w')
    handle.write('<?xml version="1.0" standalone="yes"?>\n<beast>\n\n' + taxa + '\n' + sequences + '\n')
    handle.close()

main()
