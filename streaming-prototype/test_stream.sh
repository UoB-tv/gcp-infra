#!/bin/bash

#start a test stream and write segment and playlist to current directory.
sudo gst-launch-1.0 videotestsrc is-live=true ! x264enc ! mpegtsmux ! hlssink max-files=30 target-duration=2 playlist-length=15

sudo gst-launch-1.0 -v rtmpsrc location=rtmp://10.154.0.4/live/stream/aaa ! x264enc ! mpegtsmux ! hlssink max-files=30 target-duration=2 playlist-length=15

#video works but no sound.
sudo gst-launch-1.0 -v rtmpsrc location=rtmp://10.154.0.4/live/stream/aaa ! decodebin name=decoder decoder. ! voaacenc ! aacparse ! mpegtsmux ! hlssink max-files=30 target-duration=2 playlist-length=15

# ffmpeg seem to work well

sudo ffmpeg -hide_banner -y -i rtmp://10.154.0.4/live/stream/aaa \
    -b:a:2 48k  -b:v:2 2500 \
    -c:a aac -ar 48000  -map 0:v -map 0:a:0 \
    -hls_time 2 \
    -f hls \
    -var_stream_map "v:0,a:0" \
    -master_pl_name manifest.m3u8 \
    output%v.ts


ffmpeg -nostdin -nostats -rtsp_transport tcp -thread_queue_size 512 -i rtsp://x.x.x.x:554 -i /root/streams/vp.feszek/watermark_HD.png -filter_complex "[0]fps=25[fpsok];[fpsok][1] overlay=0:0,drawtext=fontfile=/root/fonts/courbd.ttf:textfile=/root/streams/meteo/vmeteo/TEMP:fontsize=26:fontcolor=white:x=690:y=18:reload=1,drawtext=fontfile=/root/fonts/courbd.ttf:textfile=/root/streams/meteo/vmeteo/HUM:fontsize=26:fontcolor=white:x=930-tw:y=18:reload=1,drawtext=fontfile=/root/fonts/courbd.ttf:text='%{localtime\:%Y.%m.%d. %T}':fontsize=30:fontcolor=white:x=w-390:y=h-100:shadowcolor=black:shadowx=1:shadowy=1,split=5 [720p] [l1] [l2] [l3] [c];[c] fps=fps=1 [cur];[l1]scale=848:480 [480p];[l2]scale=640:360 [360p];[l3]scale=424:240 [240p]" -map:v [720p] -an -c:v h264_nvenc -b:v 2200k -r 25 -g 100 -bf 2 -refs 4 -no-scenecut 1 -strict_gop 1 -profile:v high -pixel_format yuv420p -preset default -metadata title="InfoCAM.hu Madarles1 720p" -f tee "[f=hls:hls_time=4:hls_list_size=5400:hls_flags=+delete_segments+append_list+omit_endlist]/var/www/html/nv/madarles/hls/madarles_720p.m3u8|[f=hls:hls_playlist_type=2]/var/www/html/storage/nv/madarles/archivum/$datum/720p/playlist.m3u8" -map:v [480p] -an -c:v h264_nvenc -b:v 1500k -r 25 -g 100 -bf 2 -refs 4 -no-scenecut 1 -strict_gop 1 -profile:v main -pixel_format yuv420p -preset default -metadata title="InfoCAM.hu Madarles1 480p" -f tee "[f=hls:hls_time=4:hls_list_size=5400:hls_flags=+delete_segments+append_list+omit_endlist]/var/www/html/nv/madarles/hls/madarles_480p.m3u8|[f=hls:hls_playlist_type=2]/var/www/html/storage/nv/madarles/archivum/$datum/480p/playlist.m3u8" -map:v [360p] -an -c:v h264_nvenc -b:v 750k -r 25 -g 100 -bf 2 -refs 4 -no-scenecut 1 -strict_gop 1 -profile:v main -pixel_format yuv420p -preset default -metadata title="InfoCAM.hu Madarles1 360p" -f tee "[f=hls:hls_time=4:hls_list_size=5400:hls_flags=+delete_segments+append_list+omit_endlist]/var/www/html/nv/madarles/hls/madarles_360p.m3u8|[f=hls:hls_playlist_type=2]/var/www/html/storage/nv/madarles/archivum/$datum/360p/playlist.m3u8" -map:v [240p] -an -c:v h264_nvenc -b:v 500k -r 25 -g 100 -bf 2 -refs 4 -no-scenecut 1 -strict_gop 1 -profile:v main -pixel_format yuv420p -preset default -metadata title="InfoCAM.hu Madarles1 240p" -f tee "[f=hls:hls_time=4:hls_list_size=5400:hls_flags=+delete_segments+append_list+omit_endlist]/var/www/html/nv/madarles/hls/madarles_240p.m3u8|[f=hls:hls_playlist_type=2]/var/www/html/storage/nv/madarles/archivum/$datum/240p/playlist.m3u8" -map [cur] -f image2 -y -update 1 -r 1 -qscale:v 3 /var/www/html/nv/madarles/current.jpg

# transcode to 720p
ffmpeg -i rtmp://35.242.149.3/live/stream/aaa \
    -c:v libx264 -x264opts keyint=60:no-scenecut -s 1280x720 -r 30 -b:v 25000 -profile:v main -preset veryfast -c:a libfdk_aac -sws_flags bilinear -hls_list_size 20 720p.m3u8

# transmux to highest settings.
ffmpeg -i rtmp://35.242.149.3/live/stream/aaa \
-c:v copy -c:a copy -hls_list_size 20 manifest.m3u8