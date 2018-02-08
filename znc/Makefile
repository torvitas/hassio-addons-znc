build:
	mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
	echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register
	docker build --build-arg BUILD_FROM="homeassistant/armhf-base:3.7-p3" -t torivtas/amd64-hassio-znc .
