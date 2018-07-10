#!/bin/bash

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -lt $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` <username-MPIIMD> <password-MPIIMD> [parallelDownloads=8] [skipLines=40459]"
  exit $E_BADARGS
fi
usernameMD=$1
passwordMD=$2
parallelDownloads=$3
skipLines=$4

if [ $# -lt 4 ]
then
  skipLines=21650
fi

if [ $# -lt 3 ]
then
  parallelDownloads=8
fi

if [ "$parallelDownloads" -eq "1" ]; then
  export FLAGS=(-n 1)
  echo "Serial Download so no need for xargs"
  echo $FLAGS
  echo "${FLAGS[@]}"
else
  export FLAGS=(-n 1 -P $parallelDownloads)
  echo "parallelDownloads=$parallelDownloads"
  echo $FLAGS
  echo "${FLAGS[@]}"
fi

########## download annotations
# Training set
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_training.csv --user=$usernameMD --password=$passwordMD
# Validation set
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_val.csv --user=$usernameMD --password=$passwordMD
# Public_Test set
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_test.csv --user=$usernameMD --password=$passwordMD
# Blind_Test set
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_blindtest.csv --user=$usernameMD --password=$passwordMD

########## download videos
# avi clips from MPII-MD
filesToDownload="MPIIMD_downloadLinks.txt"
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/"$filesToDownload" --user=$usernameMD --password=$passwordMD
cat $filesToDownload | wc
cat $filesToDownload | tail -n +$skipLines | xargs "${FLAGS[@]}" wget -crnH -q --show-progress=on --cut-dirs=3 --user=$usernameMD --password=$passwordMD

# avi clips from M-VAD-test-aligned
filesToDownloadT="MVADaligned_downloadLinks.txt"
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/"$filesToDownload" --user=$usernameMD --password=$passwordMD
cat $filesToDownload | wc
cat $filesToDownload | xargs "${FLAGS[@]}" wget -crnH -o $filesToDownload.log --cut-dirs=3 --user=$usernameMD --password=$passwordMD

# avi clips from Blind Test set
filesToDownload="BlindTest_downloadLinks.txt"
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/"$filesToDownload" --user=$usernameMD --password=$passwordMD
cat $filesToDownload | wc
cat $filesToDownload | xargs "${FLAGS[@]}" wget -crnH -o $filesToDownload.log --cut-dirs=3 --user=$usernameMD --password=$passwordMD
