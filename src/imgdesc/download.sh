mkdir -p /midata/imdesc
wget -c http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip -P /midata/imdesc/
unzip /midata/imdesc/captions_train-val2014.zip -d /midata/imdesc/
wget -c http://images.cocodataset.org/zips/train2014.zip -P /midata/imdesc/
unzip /midata/imdesc/train2014.zip -d /midata/imdesc/
wget -c http://images.cocodataset.org/zips/val2014.zip -P /midata/imdesc/
unzip /midata/imdesc/val2014.zip -d /midata/imdesc/ 

# unzip /midata/imdesc/captions_train-val2014.zip -d /midata/imdesc/
# rm /midata/imdesc/captions_train-val2014.zip
# unzip /midata/imdesc/train2014.zip -d /midata/imdesc/
# rm /midata/imdesc/train2014.zip 
# unzip /midata/imdesc/val2014.zip -d /midata/imdesc/ 
# rm /midata/imdesc/val2014.zip 
