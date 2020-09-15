#!/bin/bash
set -e

if [ "$(lsmod|grep vidtv)" != "" ]; then
	echo "Removing vidtv driver"
	sudo rmmod dvb_vidtv_bridge dvb_vidtv_demod dvb_vidtv_tuner
fi

echo "Building and installing the driver"
make
sudo make install

echo "Loading vidtv driver"

sudo modprobe dvb_core
sudo modprobe vidtv

# sudo cp drivers/media/test-drivers/vidtv/*.ko /lib/modules/$(uname -r)/kernel/drivers/media/test-drivers/vidtv/ && sudo modprobe dvb-vidtv-bridge

sleep 1
echo "Testing..."
dvbv5-zap -c dvb_channel.conf "S302m: Sine Wave PCM Audio" -P -v -t 2 -o pcm_audio.ts

#sudo rmmod dvb_vidtv_bridge dvb_vidtv_demod dvb_vidtv_tuner; git remote update coco && git reset --hard coco/devel/atomisp_v7 && make drivers/media/test-drivers/ && sudo cp drivers/media/test-drivers/vidtv/*.ko /lib/modules/5.9.0-rc1+/kernel/drivers/media/test-drivers/vidtv/ && sudo modprobe dvb-vidtv-bridge
