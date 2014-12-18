#!/bin/csh

# Create Working Directory
set WDIR = $MD_RESULTS/H1/HA/molecular_clock/1
set FDIR = `pwd`

if ( -d $WDIR ) then
  rm -r $WDIR
endif

mkdir -p $WDIR

if ( ! -d $WDIR ) then
  echo $WDIR not created
  exit
endif

cd $WDIR

# Copy Data and Config Files
cp $FDIR/* .

module load jdk64
module load beast

echo '#\!/bin/bash' > run.q
echo '#$ -cwd' >> run.q
echo '#$ -V' >> run.q
echo '#$ -S /bin/bash' >> run.q
echo '#$ -N HA' >> run.q
echo '#$ -o run.log' >> run.q
echo '#$ -e run.err' >> run.q
echo '#$ -q normal' >> run.q
echo '#$ -pe 12way 120' >> run.q
echo '#$ -l h_rt=24:00:00' >> run.q
echo '#$ -A A-bio7' >> run.q

echo 'env' >> run.q

echo 'beast beast_runfile.xml' >> run.q

qsub run.q

