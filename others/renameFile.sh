dirLocation="../../convertedFiles"
fileFilters="mp3 mp4 m4a"

# Changes spaces, brackets => underscore
# strips off quotes, comma


#\x27 - single
#\x22 - double

rename_file_extension()
{
OIFS="$IFS"
IFS=$'\n'
for i in `ls ${dirLocation}/*.${1} 2>/dev/null`
do
    baseDir=$(dirname $i)
    filename=$(basename $i)
    #echo filename=$filename
    newName=`echo $filename | awk '{gsub(/(\s+|\)|\()/,"_");}1' `
    newName=`echo $newName | awk '{gsub(/(\x27|\x22)/,"");}1'`
    echo "Renaming $i .."
    mv "${baseDir}/${filename}" ${baseDir}/${newName}
done
IFS="$OIFS"
}

# Pass each fileFilters to rename function to cater for various formats
for fileFilter in $fileFilters
do
    rename_file_extension $fileFilter
done
