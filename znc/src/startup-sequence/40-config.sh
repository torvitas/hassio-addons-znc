mkdir -p /data/configs
if [ ! -f /data/configs/znc.conf ]
then
    cp /znc.conf /data/configs/znc.conf
fi
