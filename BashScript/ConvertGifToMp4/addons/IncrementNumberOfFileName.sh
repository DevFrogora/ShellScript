#/!bin/bash

shopt -s nullglob
array=(*.mp4)
echo "${#array[@]}";

RenameDirectory="RenameDirectory"
RFinishDirectory="RFinishDirectory"
if [ -d "$RenameDirectory" ] 
then
  echo "$RenameDirectory Exist"
 
else 
  mkdir $RenameDirectory;
fi

if [ -d "$RFinishDirectory" ] 
then
  echo "$RFinishDirectory Exist"
 
else 
  mkdir $RFinishDirectory;
fi


for file in ${array[@]}
do 

    removedMp4=$( echo $file | sed 's/\.mp4//' )
    extractNumber=$( echo $removedMp4 | sed 's/[^0-9]//g' )
    Increment=$(($extractNumber+1)) 
    mv $file $RenameDirectory
    cd $RenameDirectory
    NewName="OutputVideo_"$Increment".mp4"
    mv $file $NewName
    cd ..
    mv "./"$RenameDirectory"/"$NewName  $RFinishDirectory
    
done



# make two folder : move the file to a folder and rename and rename it , then move it to different folder