#!/bin/bash
#$ -N gamma_rev
#$ -e error
#$ -o out
#$ -S /bin/bash

PATH=/opt/openmpi/bin:/home/agm854/NAMD:/home/agm854/rosetta_2013wk52_bundle/main/source/bin:/home/agm854/local/bin:/share/apps/python-2.7.2/bin:/opt/openmpi/bin:/usr/kerberos/bin:/usr/java/latest/bin:/bin:/usr/bin:/opt/bio/ncbi/bin:/opt/bio/mpiblast/bin/:/opt/bio/hmmer/bin:/op
LD_LIBRARY_PATH=/opt/openmpi/lib:/home/agm854/local/lib:/opt/gridengine/lib/lx26-amd64:/opt/openmpi/lib

module load BEAST

# Create Working Directory
WDIR=/state/partition1/$USER/$JOB_NAME-$JOB_ID
CDIR=/state/partition1/$USER
RDIR=/share/WilkeLab/work/agm854/Results/$JOB_NAME-$JOB_ID

FDIR=`pwd`

mkdir -p $WDIR

if [ ! -d $WDIR ]
then
  echo $WDIR not created
  exit
fi
cd $WDIR

# Copy Data and Config Files
cp $FDIR/* .

# Command to run
/share/apps/BEAST.v1.7.5/bin/beast -java -beagle -beagle_CPU -beagle_instances 16 -overwrite beast_runfile.xml

# Copy Results Back to Home Directory
mkdir -p $RDIR
cp * $RDIR

# Cleanup
rm -rf $WDIR
