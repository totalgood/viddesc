==================================================================
Large Scale Movie Description and Understanding Challenge (LSMDC), at ECCV 2016
==================================================================
Movie Fill-In-The-Blank
==================================================================

Get the Linux/Mac download script (downloadChallengeDataFIB.sh) and 
copy it to the location where you want to save the files and then run:
  downloadChallengeDataFIB.sh <username-MPIIMD> <password-MPIIMD>
  
Note: Instructions how to obtain the username/password information 
are here: https://sites.google.com/site/describingmovies/lsmdc-2016/download

In the following:
M-VAD: Montreal Video Annotation Dataset [1]
MPII-MD: MPII Movie Description dataset [2]

==================================================================
Annotations
==================================================================

= Files
- Training: LSMDC16_annos_training_FIB.csv
- Validation: LSMDC16_annos_val_FIB.csv
- Public test: LSMDC16_annos_test_FIB.csv

= Format
- Each line of the annotation *.csv file contains:
  <CLIP_ID>\t<START_ALIGNED>\t<END_ALIGNED>\t<START_EXTRACTED>\t<END_EXTRACTED>\t<SENTENCE>\t<FILL_IN>\t<BLANK>
  where "\t" is a TAB character, <START_*> and <END_*> are time-stamps "hh.mm.ss.msmsms" (e.g. 01.02.27.034).
  Note, that in case where the manually aligned video clip is shorter than 2 seconds, we symmetrically 
  expand it (from beginning and end) to be exactly 2 seconds long. Thus, <START_ALIGNED> and <END_ALIGNED>
  correspond to precise manually obtained time-stamps, while <START_EXTRACTED>, <END_EXTRACTED> indicate
  the actual extracted clip's start and end.
- <SENTENCE> is a complete reference sentence
- <FILL_IN> is a sentence that has to be filled in
- <BLANK> is the removed part of the sentence
- The task is to train a model to fill in the <BLANK>, given the video clip and the <FILL_IN>.

= Statistics
- Training: 296,960
- Validation: 21,689
- Public Test: 30,349

==================================================================

[1]
@article{AtorabiM-VAD2015,
author = {Torabi, Atousa and Pal, Chris and Larochelle, Hugo and Courville, Aaron},
title = {Using Descriptive Video Services To Create a Large Data Source For Video Annotation Research},
journal = {arXiv preprint},
year = {2015},
url = {http://arxiv.org/pdf/1503.01070v1.pdf}}

[2]
@inproceedings{rohrbach15cvpr,
title={A Dataset for Movie Description},
author={Rohrbach, Anna and Rohrbach, Marcus and Tandon, Niket and Schiele, Bernt},
booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
url = {http://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Rohrbach_A_Dataset_for_2015_CVPR_paper.pdf}
year={2015}}
