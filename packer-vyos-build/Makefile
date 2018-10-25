SHELL := /bin/bash

build:
	cd ${CURDIR}; \
        packer build -on-error=abort -only=qemu -parallel=false vyos-1.1.8-amd64.json;
