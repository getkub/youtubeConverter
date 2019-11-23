from __future__ import unicode_literals
import sys
import re

# Python Wrapper to Call MP3 conversion settings and to ensure youtube URL is passed with error checks
# DO NOT CALL THIS manually, but only via the wrapper shell script
#   call is made like=>      python ./mp3Convert.py $libDir $youtubeURL $finalConvertedDir

libDir = sys.argv[1]
youtubeURL = sys.argv[2]
finalConvertedDir = sys.argv[3]

# Import library files from remote Dir
sys.path.insert(1, libDir)
import youtube_dl


class MyLogger(object):
    def debug(self, msg):
        pass

    def warning(self, msg):
        pass

    def error(self, msg):
        print(msg)


def my_hook(d):
    if d['status'] == 'finished':
        print('Done downloading, now converting ...')

# Not much checks into inputs as it comes from a trusted script.

#video_name = raw_input('Enter youtube video name: ')
ydl_opts = {
    'format': 'bestaudio/best',
    'outtmpl': finalConvertedDir + '/%(title)s.%(ext)s',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '192',
    }],
    'logger': MyLogger(),
    'progress_hooks': [my_hook],
}
with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download([youtubeURL])

# Some cleanups to final Converted files to make it without space and unwanted characters
# TO DO
#pureTitle = re.sub("[\w+]+", " ", title);
