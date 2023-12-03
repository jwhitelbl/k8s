FROM debian:bookworm
RUN apt-get -y update
RUN apt-get -y install vlc vlc-plugin-video-output ffmpeg telnet wget

USER daemon
ENTRYPOINT cvlc --aout=dummy /playlist/${PLAYLIST} -Z \
	--http-port 8081 -I http --http-password ${PASSWORD} \
	 --sub-language=English --no-auto-preparse --sout-mux-caching=10000 \
	 --audio-track=0 --no-sout-all \
	 --sout '#transcode{vcodec=h264,vb=15000,width=1080,acodec=aac,ab=192k,samplerate=44100,ac=1,soverlay}:std{access=rtmp,mux=ffmpeg{mux=flv},dst=rtmp://nginx-rtmp/live/stream'
