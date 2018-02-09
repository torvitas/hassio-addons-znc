define RENDER_DOCKER_FILE
sed -e s~\#{BUILD_FROM}~$(BASE_IMAGE)~g \
 -e s~\#{CROSS_BUILD_START}~$(CROSS_BUILD_START)~g \
 -e s~\#{CROSS_BUILD_END}~$(CROSS_BUILD_END)~g Dockerfile.tpl > $(DOCKERFILE)
endef

BUILD=docker build --build-arg BUILD_FROM="$(BUILD_FROM)" -f $(DOCKERFILE) -t $(IMAGE) .

BUILD_FROM=
BASE_IMAGE=
IMAGE=local/hassio-znc
DOCKERFILE=Dockerfile
CROSS_BUILD_START=
CROSS_BUILD_END=

# ARMHF
armhf% : BUILD_FROM=resin/armhf-alpine:3.6
armhf% : IMAGE=torvitas/armhf-hassio-znc
armhf% : DOCKERFILE=Dockerfile.cross
armhf% : CROSS_BUILD_START="RUN [ \"cross-build-start\" ]"
armhf% : CROSS_BUILD_END="RUN [ \"cross-build-end\" ]"
armhf-build : Dockerfile.cross
	$(BUILD)
armhf-config : BASE_IMAGE=$(BUILD_FROM)
armhf-config : DOCKERFILE=Dockerfile.armhf
armhf-config : /proc/sys/fs/binfmt_misc /proc/sys/fs/binfmt_misc/register Dockerfile.armhf
clean-armhf :
	rm -f Dockerfile.armhf

# AARCH64
aarch64% : BUILD_FROM=resin/aarch64-alpine:3.6
aarch64% : IMAGE=torvitas/aarch64-hassio-znc
aarch64% : DOCKERFILE=Dockerfile.cross
aarch64% : CROSS_BUILD_START="RUN [ \"cross-build-start\" ]"
aarch64% : CROSS_BUILD_END="RUN [ \"cross-build-end\" ]"
aarch64-build : Dockerfile.cross
	$(BUILD)
aarch64-config : BASE_IMAGE=$(BUILD_FROM)
aarch64-config : DOCKERFILE=Dockerfile.aarch64
aarch64-config : Dockerfile.aarch64
clean-aarch64 :
	rm -f Dockerfile.aarch64

# AMD64
amd64% : BUILD_FROM=resin/amd64-alpine:3.6
amd64% : IMAGE=torvitas/amd64-hassio-znc
amd64-build : Dockerfile
	$(BUILD)
amd64-config : BASE_IMAGE=$(BUILD_FROM)
amd64-config : DOCKERFILE=Dockerfile.amd64
amd64-config : Dockerfile.amd64
clean-amd64 :
	rm -f Dockerfile.amd64

# I386
i386% : BUILD_FROM=resin/i386-alpine:3.6
i386% : IMAGE=torvitas/i386-hassio-znc
i386-build : Dockerfile
	$(BUILD)
i386-config : BASE_IMAGE=$(BUILD_FROM)
i386-config : DOCKERFILE=Dockerfile.i386
i386-config : Dockerfile.i386
clean-i386 :
	rm -f Dockerfile.i386

# LOCAL
default-config : Dockerfile
cross-config : DOCKERFILE=Dockerfile.cross
cross-config : CROSS_BUILD_START="RUN [ \"cross-build-start\" ]"
cross-config : CROSS_BUILD_END="RUN [ \"cross-build-end\" ]"
cross-config: Dockerfile.cross
clean-local :
	rm -f Dockerfile
	rm -f Dockerfile.cross
index-config :
	git add Dockerfile*

# PHONY
.PHONY : all config clean
all : armhf-build aarch64-build amd64-build i386-build
config : default-config cross-config armhf-config aarch64-config amd64-config i386-config index-config
clean : clean-local clean-armhf clean-aarch64 clean-amd64 clean-i386

# TARGETS
/proc/sys/fs/binfmt_misc :
	sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
/proc/sys/fs/binfmt_misc/register :
	sudo echo ' :arm :M : :\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00 :\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff :/usr/bin/qemu-arm-static :' > /proc/sys/fs/binfmt_misc/register
Dockerfile :
	$(RENDER_DOCKER_FILE)
Dockerfile.cross :
	$(RENDER_DOCKER_FILE)
Dockerfile.armhf :
	$(RENDER_DOCKER_FILE)
Dockerfile.aarch64 :
	$(RENDER_DOCKER_FILE)
Dockerfile.amd64 :
	$(RENDER_DOCKER_FILE)
Dockerfile.i386 :
	$(RENDER_DOCKER_FILE)
tmp.i386.Dockerfile: Dockerfile.i386
