#!/user/bin/env bash
# Download, train, and test an image desctiption model

# Error Will Robinson! Abort! Abort!
set -e

## Download and install the COCO dataset python API

git clone https://github.com/pdollar/coco.git
cd coco/PythonAPI/
make
python setup.py build
python setup.py install
cd ../../

## Download and install the pytorch tutorial code

# You already have this!
git clone https://github.com/yunjey/pytorch-tutorial.git
cd pytorch-tutorial/tutorials/03-advanced/image_captioning/
pip install -r requirements.txt

## Download the dataset

chmod +x download.sh
./download.sh

## Prepare the data

python build_vocab.py   
python resize.py  # image resizing

## Train the model

python train.py    

## 5. Test the model

python sample.py --image='png/example.png'