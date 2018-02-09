define RENDER_DOCKER_FILE
sed -e s~\#{BUILD_FROM}~$(BASE_IMAGE)~g \
 -e s~\#{CROSS_BUILD_START}~$(CROSS_BUILD_START)~g \
 -e s~\#{CROSS_BUILD_END}~$(CROSS_BUILD_END)~g Dockerfile.tpl > $(DOCKERFILE)
endef

BUILD=docker build --build-arg BUILD_FROM="$(BUILD_FROM)" -f $(DOCKERFILE) -t $(IMAGE) .

BASE_IMAGE=
BUILD_FROM=$(BASE_IMAGE)
IMAGE=local/hassio-znc
DOCKERFILE=Dockerfile
CROSS_BUILD_START=
CROSS_BUILD_END=

.PHONY: all config clean hooks
amd64: BUILD_FROM=resin/amd64-alpine:3.6
amd64: Dockerfile
	$(BUILD)

armhf: BUILD_FROM=resin/raspberry-pi-alpine:3.6
armhf: Dockerfile
	$(BUILD)

clean-local:
	rm -f Dockerfile

all: amd64 armhf

config-amd64: BASE_IMAGE=resin/amd64-alpine:3.6
config-amd64: IMAGE=torvitas/amd64-hassio-znc
config-amd64: DOCKERFILE=Dockerfile.amd64
config-amd64: Dockerfile.amd64
clean-amd64:
	rm -f Dockerfile.amd64


config-armhf: BASE_IMAGE = resin/raspberry-pi-alpine:3.6
config-armhf: IMAGE = torvitas/armhf-hassio-znc
config-armhf: DOCKERFILE=Dockerfile.armhf
config-armhf: CROSS_BUILD_START="RUN [ \"cross-build-start\" ]"
config-armhf: CROSS_BUILD_END="RUN [ \"cross-build-end\" ]"
config-armhf: /proc/sys/fs/binfmt_misc /proc/sys/fs/binfmt_misc/register Dockerfile.armhf
clean-armhf:
	rm -f Dockerfile.armhf

config: hooks config-amd64 config-armhf
clean: clean-local clean-amd64 clean-armhf

hooks: ../.git/hooks/pre-commit
../.git/hooks/pre-commit:
	ln -s ../../znc/.hooks/pre-commit.sh ../.git/hooks/pre-commit

/proc/sys/fs/binfmt_misc:
	sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
/proc/sys/fs/binfmt_misc/register:
	sudo echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register
Dockerfile:
	$(RENDER_DOCKER_FILE)
Dockerfile.armhf:
	$(RENDER_DOCKER_FILE)
Dockerfile.amd64:
	$(RENDER_DOCKER_FILE)
