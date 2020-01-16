# Media Download and Convert script for MAC & Linux

## Wrapper script made using youtube-dl to make it easy for end-users
#### Download media (mp4, m4a, mp3) from various sites using command line (eg Youtube, Facebook)

## Installation/Copying
Just clone this repository as follows
- go to a directory in your laptop with required storage space
- Install HomeBrew if NOT already installed for MACOS
- Ensure FFMPEG library present by Running ```brew install ffmpeg``` OR ```sudo apt-get install ffmpeg``` in respective OS
- Then clone this repository: ```git clone https://github.com/getkub/youtubeConverter.git```


## Running and Execution

Call the wrapper script in below format

```
./mediaConverter.sh <mediaURL> <finalMediaFormat>
```

eg Youtube video to MP4 video
```
./mediaConverter.sh https://www.youtube.com/watch?v=9pra4CM_njM mp4
```

eg Facebook video to MP3
```
./mediaConverter.sh https://www.facebook.com/MrBean/videos/988287084707700/ mp3
```


## Ensure
- You have enough space in your filesystem where you copy this repository
- Ensure the parent directory is writable
- Ensure this is run in *macos* OR *Linux*
- Ensure python is installed in your system
- Ensure internet connectivity to pull libraries
- Cleanup your Converted Files directory often to keep filesystem space in-tact

## Default settings
- This script hardcodes certain values to make it easier for end-users
- Default audio format is m4a
- Default mp3 settings is 192kbps
- Downloads final media into "../convertedFiles" directory (i.e. Creates directory above your parent directory)
