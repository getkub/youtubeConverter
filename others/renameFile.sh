# This script is under-development and needs fixing

dirLocation="../../convertedFiles"
fileFilters="mp3 mp4 m4a"
patternsList="regexPatterns.list"

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
    newName=$filename
    #echo "Filename is: $newName"
    for pattern in `cat ${patternsList}|egrep -v '^#'|egrep '^[[:space:]]*$'`
    do
      echo "Applying Pattern $pattern => to $newName"
      newName=`echo $newName | awk "{gsub${pattern};}1" `
    done
    echo "Renaming $i ==> $newName"
    # mv "${baseDir}/${filename}" ${baseDir}/${newName}
done
IFS="$OIFS"
}

# Pass each fileFilters to rename function to cater for various formats
for fileFilter in $fileFilters
do
    rename_file_extension $fileFilter
done
