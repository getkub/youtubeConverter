dirLocation="../../convertedFiles"
fileFilter="mp3"

# Changes spaces, brackets => underscore
# strips off quotes, comma
OIFS="$IFS"
IFS=$'\n'

for i in `ls ${dirLocation}/*.${fileFilter}`
do
    baseDir=$(dirname $i)
    filename=$(basename $i)
    #echo filename=$filename
    newName=`echo $filename | awk '{gsub(/(\s+|\)|\()/,"_");}1' `
    echo "Renaming $i .."
    mv "${baseDir}/${filename}" ${baseDir}/${newName}
done
IFS="$OIFS"
