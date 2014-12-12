# load the protein
#prot='start_H3.pdb'
#cmd.load(prot)
 
# Set b value to zero
cmd.alter('start_H3',"b=0.0")
cmd.show_as("cartoon",'start_H3')
 
inFile = open("correlations/h1_25.correlations", 'r')
val_list = []
count = 1
for line in inFile.readlines()[1:]:
    split = line.split()
    bs = split[0]
    print(bs)
    cmd.alter("%s and resi %s and n. CA"%('start_H3', count), "b=%s"%bs)
    count += 1
 
#spectrum b, rainbow, minimum=-0.2, maximum=0.25
#as cartoon
#cartoon tube
#set cartoon_tube_radius, 0.8