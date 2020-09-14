dvb-vidtv-tuner-objs := vidtv_tuner.o
dvb-vidtv-demod-objs := vidtv_demod.o
dvb-vidtv-bridge-objs := vidtv_bridge.o vidtv_common.o vidtv_ts.o vidtv_psi.o \
			 vidtv_pes.o vidtv_s302m.o vidtv_channel.o vidtv_mux.o

obj-m += dvb-vidtv-tuner.o dvb-vidtv-demod.o dvb-vidtv-bridge.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

EXTRA_CFLAGS	:= -DDEBUG=0

all:
	$(MAKE) -C $(KERNELDIR) M=$(PWD)

modules_install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install

install: modules_install

clean:
	-rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions built-in.a *.mod Module.symvers modules.order

distclean: clean
	-rm *.c *.h

links:
	@if [ "$(DIR)" == "" ]; then echo "Usage: DIR=<kernel dir> make links"; echo; exit 1; fi
	-rm *.c *.h
	ln -sf $(DIR)/drivers/media/test-drivers/vidtv/*.[ch] .
