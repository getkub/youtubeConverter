#!/bin/sh

# =========================== =========================== #
# Wrapper Script to
# automatically pull library files
# call python converter scripts
# <scriptname>.sh <mediaURL> <fileFormat>
# =========================== =========================== #

mediaURL=$1

case "$2" in
    mp3)
        fileFormat="mp3"
        ;;
    mp4)
        fileFormat="mp4"
        ;;
    m4a)
        fileFormat="m4a"
        ;;
    *)
        echo "WARN: No valid fileFormat entered. Assuming m4a"
        fileFormat="m4a"
        ;;
esac

# Now pull the libraries youtube-dl from github
baseDir=`pwd`
libDir="../ytlibPackage"
finalConvertedDir="../convertedFiles"

if [ -d "$libDir" ]
then
    cd $libDir
    echo "INFO: Updating Libary Code"
    git reset --hard HEAD --quiet
    git pull https://github.com/ytdl-org/youtube-dl.git --quiet
    cd $baseDir
else
    echo "INFO: Creating & Updating Libary Code"
    mkdir -p $libDir
    git clone https://github.com/ytdl-org/youtube-dl.git $libDir --quiet
fi

# Now call relevant converter python scripts
mkdir -p $finalConvertedDir
if [ -d "$finalConvertedDir" ]
then
    echo "INFO: Files will be converted and placed in: $finalConvertedDir "
else
    echo "ERROR: Unable to Created directory to hold converted files. Exiting.."
    exit 201
fi

echo "INFO: Calling media Converter package.. with Final fileFormat of => $fileFormat"
python ./downloadConvert.py $libDir $mediaURL $fileFormat $finalConvertedDir
echo "INFO: Completed. Converted Files kept in : $finalConvertedDir"
