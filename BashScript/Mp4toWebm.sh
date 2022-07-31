#!/bin/bash

maxwidth=200;
maxheight=200;

filename=getVideo.mp4;

FrameDirectory="Frames"
ResizeFrameDir="ResizeFrames"
WebMsDir="WebMs"

OutputFileName="output.webm"
NullFile="NUL"

if [ -d "$FrameDirectory" ] 
then
  echo "Clear Frame Dir"
  rm Frames/*; # remove all files from Frames and WebMs to prevent errors
else 
  mkdir $FrameDirectory;
fi


if [ -d "$ResizeFrameDir" ] 
then
  echo "Clear Resize Dir"
  rm ResizeFrames/*;
else 
  mkdir $ResizeFrameDir;
fi


if [ -d "$WebMsDir" ] 
then
  echo "WebMs Dir"
  rm WebMs/*;
else 
  mkdir $WebMsDir;
fi



r=maxheight;



ffmpeg -i $filename -r 30 ./Frames/output_%04d.png 2>NUL ; # convert video into frames at 30fps, save output files to Frames
if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi

echo "Resizing_Frames ";
cd Frames;
totalFrame=$(ls | wc -l);
i=0;
for f in *.png
do
    i=$(($i + 1));

    echo "Resizing_Frames : ${i} / ${totalFrame}";

    r=$((r- 1));  # ditto 1
    ffmpeg -i $f -vf scale=$maxwidth:$r ../ResizeFrames/$f 2>NUL;
done;
if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi
cd ..;

cd ResizeFrames;
i=0;
for f in *.png
do
    i=$(($i + 1));
    echo "convert Png To Webm :  ${i} / ${totalFrame}";
    ffmpeg -framerate 30 -f image2 -i $f -c:v libvpx-vp9 -pix_fmt yuva420p ../WebMs/$f.webm 2>NUL; # convert image into single-framed WebM file
done;
if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi
cd ..;
cd WebMs;


if [ -e "$OutputFileName" ] 
then
  rm ../output.webm;
fi



echo "Bundeling Webm .... ";
find *.webm | sed 's:\ :\\\ :g'| sed 's/^/file /' > fl.txt; ffmpeg -f concat -i fl.txt -c copy ../output.webm 2>NUL;  # combine everything into one WebM

if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi


cd ..;
if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi
audioname=yolo.mp3
videoname=output.webm;

echo "Wait For 2 sec to add audio";

sleep 2

# ffmpeg -i -i $videoname final_video.webm
# ffmpeg -i $videoname -i $audioname -b:a 48K -map 0:v -map 1:a  -c:v copy -shortest final_video.webm
ffmpeg -i $videoname -i $audioname  -map 0:v -map 1:a -c:v copy -shortest final_video.webm 2>NUL
if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi
echo "Done";
exit;