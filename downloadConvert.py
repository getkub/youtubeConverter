from __future__ import unicode_literals
import sys
import re

# Python Wrapper to Call Various conversion settings and to ensure URL is passed with error checks
# DO NOT CALL THIS manually, but only via the wrapper shell script
#   call is made like=>      python ./<scriptname> $libDir $mediaURL $finalFormat $finalConvertedDir

libDir = sys.argv[1]
mediaURL = sys.argv[2]
finalFormat = sys.argv[3]
finalConvertedDir = sys.argv[4]

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
        print('INFO: Done downloading ...')
    # if d['status'] == 'downloading':
    #     print(d['filename'], d['_percent_str'], d['_eta_str'])

# Not much checks into inputs as it comes from a trusted script.

#video_name = raw_input('Enter youtube video name: ')

if finalFormat in ['m4a']:
    formatString='bestaudio[ext=m4a]'
if finalFormat in ['mp4']:
    formatString='bestvideo[ext=mp4]+bestaudio[ext=m4a]'

if finalFormat in ['mp3']:
    formatString='bestaudio/best'
## Put Options String here somehow

ydl_opts = {
    'format': formatString,
    'outtmpl': finalConvertedDir + '/%(title)s.%(ext)s',
    'logger': MyLogger(),
    'progress_hooks': [my_hook],
}
with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download([mediaURL])

# Some cleanups to final Converted files to make it without space and unwanted characters
# TO DO
#pureTitle = re.sub("[\w+]+", " ", title);
