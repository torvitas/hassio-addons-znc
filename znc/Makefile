BASE_IMAGE=resin/amd64-alpine:3.6
IMAGE=torvitas/amd64-hassio-znc
build-armhf : BASE_IMAGE=resin/raspberry-pi-alpine:3.6
build-armhf : IMAGE=torvitas/armhf-hassio-znc
/proc/sys/fs/binfmt_misc:
	sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
/proc/sys/fs/binfmt_misc/register:
	sudo echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register
build:
	docker build --build-arg BUILD_FROM="$(BASE_IMAGE)" -t $(IMAGE) .
build-armhf: /proc/sys/fs/binfmt_misc /proc/sys/fs/binfmt_misc/register build
