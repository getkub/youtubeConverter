#!/bin/sh

# =========================== =========================== #
# Wrapper Script to
# automatically pull library files
# call python converter scripts
# =========================== =========================== #

regex='^(https?\:\/\/www\.)?(youtube\.com|youtu\.?be)\/.+$'

if [[ $1 =~ $regex ]]
then
    echo "Valid URL detected: $1"
    youtubeURL=$1
else
    echo "Youtube Link not valid. Exiting"
    echo "Script usage is: $0 <youtubeURL> <fileFormat>"
    exit 100
fi

case "$2" in
    mp3)
        fileFormat="mp3"
        ;;
    *)
        echo "No valid fileFormat entered. Assuming mp3"
        fileFormat="mp3"
        ;;
esac

# Now pull the libraries youtube-dl from github
baseDir=`pwd`
libDir="../ytlibPackage"
finalConvertedDir="../convertedFiles"

if [ -d "$libDir" ]
then
    cd $libDir
    git reset --hard HEAD
    git pull https://github.com/ytdl-org/youtube-dl.git
    cd $baseDir
else
    mkdir -p ../youtube-dl_local
    git clone https://github.com/ytdl-org/youtube-dl.git $libDir
fi

# Now call relevant converter python scripts
mkdir -p $finalConvertedDir
if [ -d "$finalConvertedDir" ]
then
    echo "Files will be converted and placed in: $finalConvertedDir "
else
    echo "Unable to Created directory to hold converted files. Exiting.."
    exit 201
fi

case "$fileFormat" in
    mp3)
        echo "Calling Converter package.."
        python ./mp3Convert.py $libDir $youtubeURL $finalConvertedDir
        exit 0
        ;;
    *)
        echo "No valid fileFormat entered. Exiting without action"
        exit 101
        ;;
esac
