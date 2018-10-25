SHELL := /bin/bash

all: clean build install

all-qemu: clean-qemu build-qemu install-qemu

all-vbox: clean-vbox build-vbox install-vbox

build: build-vbox build-qemu

build-qemu:
	cd ${CURDIR}; \
	packer build -on-error=abort -only=qemu-qcow2 -parallel=false vyos-1.1.8-amd64-qemu.json;

build-vbox:
	cd ${CURDIR}; \
	packer build -on-error=abort -only=virtualbox-iso -parallel=false vyos-1.1.8-amd64-vbox.json;

clean: clean-vbox clean-qemu

clean-qemu:
	cd ${CURDIR}; \
	rm -rf output-qemu-qcow2 output-vagrant-qemu;

clean-vbox:
	cd ${CURDIR}; \
	rm -rf output-virtualbox-iso output-vagrant-vbox;

install: install-vbox install-qemu

install-qemu:
	VAGRANT_QEMU_PATH="${CURDIR}/output-vagrant-qemu/libvirt-vyos-1.1.8-amd64.box"; \
	echo -e "Looking for boxes at\n\t- $${VAGRANT_QEMU_PATH}"; \
        if [ -f "$${VAGRANT_QEMU_PATH}" ]; then \
          virsh vol-delete --pool default libvirt-vyos-1.1.8-amd64_vagrant_box_image_0.img || true; \
          echo "Removing $${VAGRANT_QEMU_PATH} from vagrant if present..."; \
          vagrant box remove libvirt-vyos-1.1.8-amd64 --force || true; \
          echo "Adding $${VAGRANT_QEMU_PATH} to vagrant"; \
          vagrant box add file://$${VAGRANT_QEMU_PATH} --name libvirt-vyos-1.1.8-amd64; \
        fi;

install-vbox:
	VAGRANT_VBOX_PATH="${CURDIR}/output-vagrant-vbox/virtualbox-vyos-1.1.8-amd64.box"; \
	echo -e "Looking for boxes at\n\t- $${VAGRANT_VBOX_PATH}"; \
	if [ -f "$${VAGRANT_VBOX_PATH}" ]; then \
	  echo "Removing $${VAGRANT_VBOX_PATH} from vagrant if present..."; \
	  vagrant box remove virtualbox-vyos-1.1.8-amd64 --force || true; \
	  echo "Adding $${VAGRANT_VBOX_PATH} to vagrant"; \
	  vagrant box add file://$${VAGRANT_VBOX_PATH} --name virtualbox-vyos-1.1.8-amd64; \
	fi;
