#!/bin/bash

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -lt $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` <username-MPIIMD> <password-MPIIMD> [parallelDownloads=8] [firstLine=1] [numLines=1000000000]"
  exit $E_BADARGS
fi
usernameMD=$1
passwordMD=$2
parallelDownloads=$3
firstLine=$4
numLines=$5
dataSet=$6

if [ $# -lt 6 ]
then
  dataSet=0  # training set
fi

if [ $# -lt 5 ]
then
  numLines=1000000000  # 1 billion videos+descriptions
fi

if [ $# -lt 4 ]
then
  firstLine=1  # 21650
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
# redirects to: MPIIMD_downloadLinks.txt
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_training.csv --user=$usernameMD --password=$passwordMD

# Validation set
# redirects to: MVADaligned_downloadLinks.txt
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_val.csv --user=$usernameMD --password=$passwordMD

# Public_Test set
# ??? redirects to: BlindTest_downloadLinks.txt ???
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_test.csv --user=$usernameMD --password=$passwordMD

# Blind_Test set
# ??? redirects to: BlindTest_downloadLinks.txt ???
wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/LSMDC16_annos_blindtest.csv --user=$usernameMD --password=$passwordMD

########## download videos
# avi clips from MPII-MD

if [ $# -lt 6 ] || [ "$dataSet" -eq "0" ]
then
  filesToDownload="MPIIMD_downloadLinks.txt"
  wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/"$filesToDownload" --user=$usernameMD --password=$passwordMD
  cat $filesToDownload | wc
  cat $filesToDownload | tail -n +$firstLine | head -n $numLines | xargs "${FLAGS[@]}" wget -crnH -q --show-progress=on --cut-dirs=3 --user=$usernameMD --password=$passwordMD
fi

# avi clips from M-VAD-test-aligned
if [ $# -lt 6 ] || [ "$dataSet" -eq "1" ]
then
  filesToDownloadT="MVADaligned_downloadLinks.txt"
  wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/"$filesToDownload" --user=$usernameMD --password=$passwordMD
  cat $filesToDownload | wc
  cat $filesToDownload | tail -n +$firstLine | head -n $numLines | xargs "${FLAGS[@]}" wget -crnH -q --show-progress=on --cut-dirs=3 --user=$usernameMD --password=$passwordMD
fi

# avi clips from Blind Test set
if [ $# -lt 6 ] || [ "$dataSet" -eq "2" ]
then
  filesToDownload="BlindTest_downloadLinks.txt"
  wget -c http://datasets.d2.mpi-inf.mpg.de/movieDescription/protected/lsmdc2016/"$filesToDownload" --user=$usernameMD --password=$passwordMD
  cat $filesToDownload | wc
  cat $filesToDownload | tail -n +$firstLine | head -n $numLines | xargs "${FLAGS[@]}" wget -crnH -o $filesToDownload.log --cut-dirs=3 --user=$usernameMD --password=$passwordMD
fi

