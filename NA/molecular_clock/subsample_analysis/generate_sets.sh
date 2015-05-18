rm -r original_data/*small*
rm -r set_*

for j in {1..25}; do

  for i in {1..10}; do 
    python pick_random_sequences.py original_data/${i}_cleaned.fasta original_data/${i}_small.fasta 25;
    cp -r beast_setup original_data/${i}_small 
    cat original_data/*small.fasta > original_data/${i}_small/${i}_small_aggregated.fasta;
    cd original_data/${i}_small
    python align.py ${i}_small_aggregated.fasta
    python format_for_beast.py
    cat taxa_sequence_input.xml parameter_input.xml > beast_runfile.xml 
    cd ../../
  done

  mkdir set_${j};
  cp -r original_data/*small set_${j}/;
  rm -r original_data/*small*;
done
