#!/usr/local/bin/python

from moviepy.editor import *

H = 1080 # vertical resolution of final movie
W = 16*H/9
dur = .3 # duration per image
end_dur = 2.5 # duration of the final image
imgnum = 25 # total number of images to process

imagefiles = ["images/tetramer_%02i.png" % (i+1) for i in range(imgnum)]

clips = [ImageClip(f).set_duration(dur) for f in imagefiles]
clips[-1] = clips[-1].set_duration(end_dur)

HA = concatenate_videoclips(clips, bg_color=(255, 255, 255))
HA = HA.fx(vfx.resize, width=int(0.5*W)).set_pos(("center", "center"))

labels = ["Apr 2009", "May 2009", "Jun 2009", "Jul 2009", "Aug 2009", "Sep 2009", "Oct 2009", "Nov 2009", "Dec 2009", "Jan 2010", "Feb 2010", "Mar 2010", "Apr 2010", "May 2010", "Jun 2010", "Jul 2010", "Aug 2010", "Sep 2010", "Oct 2010", "Nov 2010", "Dec 2010", "Jan 2011", "Feb 2011", "Mar 2011", "Apr 2011"]

label_clips = [TextClip(l, font="Courier-Bold", fontsize=.08*H)\
            .set_duration(dur) for l in labels[0:imgnum]]
label_clips[-1] = label_clips[-1].set_duration(end_dur)
            
text = concatenate_videoclips(label_clips).set_pos((0.73*W, 0.1*H))

video = CompositeVideoClip([HA, text], size=(W, H), bg_color=(255, 255, 255))

video.write_videofile('pH1N1_na.mp4', fps=24, codec='mpeg4', bitrate="5000k")
