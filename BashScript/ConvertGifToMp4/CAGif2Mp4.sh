#/!bin/bash

FrameDirectory="Frames"
NullFile="NUL"
OutputFolder="./CompletedVideo"
OutputVideo="OutputVideo"

#filename=getGif.gif;

if [ -d "$FrameDirectory" ] 
then
  echo "Clear Frame Dir"
  rm Frames/*; # remove all files from Frames and WebMs to prevent errors
else 
  mkdir $FrameDirectory;
fi


if [ -d "CompletedVideo" ] 
then
  echo "Clear Frame Dir"
  rm CompletedVideo/*; # remove all files from Frames and WebMs to prevent errors
else 
  mkdir "CompletedVideo";
fi


count=0;
for FILE in *.gif
do
    #count=$(( $count + 1  ))
    #echo $file"$count"
    echo $FILE; 
    #mv $FILE $filename

ffmpeg -i "$FILE"  ./Frames/output_%04d.png 2>NUL ; # convert video into frames at 30fps, save output files to Frames
if [ -e "$NullFile" ] 
then
  rm ./NUL;
fi


#ffmpeg  -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -r 30 -i ./Frames/output_%04d.png -pix_fmt yuv420p output.mp4
ffmpeg -i ./Frames/output_%04d.png -vcodec libx264 \
-vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -r 24 \
 -y -an $OutputVideo".mp4" 

#cd "$OutputFolder"


count=$(ls "$OutputFolder" | wc -l)
echo "$(( $count + 1  ))" 

RenameFile=$OutputVideo"_$(( $count + 1  )).mp4"
mv $OutputVideo".mp4" $RenameFile

mv $RenameFile $OutputFolder

done

