==================================================================
Large Scale Movie Description and Understanding Challenge (LSMDC), at ECCV 2016
==================================================================
Movie Description
==================================================================

Get the Linux/Mac download script (downloadChallengeData.sh) and 
copy it to the location where you want to save the files and then run:
  downloadChallengeData.sh <username-MPIIMD> <password-MPIIMD>
  
Note: Instructions how to obtain the username/password information 
are here: https://sites.google.com/site/describingmovies/lsmdc-2016/download

In the following:
M-VAD: Montreal Video Annotation Dataset [1]
MPII-MD: MPII Movie Description dataset [2]

==================================================================
Annotations
==================================================================

= Files
- Training: LSMDC16_annos_training.csv
- Validation: LSMDC16_annos_val.csv
- Public test: LSMDC16_annos_test.csv
- Blind  test: LSMDC16_annos_blindtest.csv (no sentences)

= Format
- Each line of the annotation *.csv file contains:
  <CLIP_ID>\t<START_ALIGNED>\t<END_ALIGNED>\t<START_EXTRACTED>\t<END_EXTRACTED>\t<SENTENCE>
  where "\t" is a TAB character, <START_*> and <END_*> are time-stamps "hh.mm.ss.msmsms" (e.g. 01.02.27.034).
  Note, that in case where the manually aligned video clip is shorter than 2 seconds, we symmetrically 
  expand it (from beginning and end) to be exactly 2 seconds long. Thus, <START_ALIGNED> and <END_ALIGNED>
  correspond to precise manually obtained time-stamps, while <START_EXTRACTED>, <END_EXTRACTED> indicate
  the actual extracted clip's start and end.
- Most character names are replaced with "SOMEONE".

= Statistics
- Training: 101,079
- Validation: 7,408
- Public Test: 10,053
- Blind Test: 9,578

= Types of annotations
Depending on <CLIP_ID>, the annotations can be part of one of the following groups:

- 3XXX_<MOVIE>_<START>-<END> (e.g. 3011_BLIND_DATING_01.11.23.496-01.11.25.853)
Audio Descriptions manually aligned to HD movies, from M-VAD.
Part of training, validation and test data.

- 1XXX_<MOVIE>_<START>-<END> (e.g. 1006_Slumdog_Millionaire_01.25.49.077-01.25.54.718)
Audio Descriptions manually aligned to HD movies, from MPII-MD.
Part of training, validation and test data.

- 0XXX_<MOVIE>_<START>-<END> (e.g. 0001_American_Beauty_00.02.29.298-00.02.30.004)
Movie scripts manually aligned to HD movies, from MPII-MD.
Part of training data, optional to use.

Note: <CLIP_ID> is not a unique identifier, i.e. the same <CLIP_ID> 
can be associated with multiple sentences.

==================================================================
Video clips
==================================================================

= Files & disc space
- MPIIMD_downloadLinks.txt (655 GB)
- MVADaligned_downloadLinks.txt (486 GB)
- BlindTest_downloadLinks.txt (166 GB)

Total (1,307 GB)

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
