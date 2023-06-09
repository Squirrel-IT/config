#-*- coding: utf-8; mode: makefile; -*-

# ENVIRONMENT 
# Check the environment to detect on which system we are running.
# Current targets: debian, openbsd

# get the following variables from env:
CHOST 	= $(shell hostname -s)
COS 	= $(shell uname -s)
CDATE 	= $(shell date)


# preprocessor defines:
GPP		= ./gpp -DHOST=$(CHOST) -DOS=$(COS)
TPAGE	= tpage --define host=$(CHOST) --define os=$(COS) --define date="$(CDATE)"


# install
INST 	= doas install -b $< $@ 


.SUFFIXES: .out .in
.out.in:
	$(TPAGE) $< > $@
	

.PHONY: all showconfig
all:	showconfig


showconfig:
	@echo os: $(COS)
	@echo gpp: $(GPP)
	@echo tpage: $(TPAGE)
	@echo host: $(CHOST)

	@echo targets: clean installpackages dirs vimrc emacs xsession
ifeq ($(COS), OpenBSD)
	@echo targets: fstab sysctl loginc insturl rcconf printcp 
endif



# CLEAN ========================================================================
.PHONY: clean
clean:
	rm -f *.out *~ *.o gpp



installpackages:
ifeq ($(COS), Linux)
	doas apt install doas dbus-x11 vim i3 rofi dunst picom nitrogen make fonts-inconsolata libtemplate-perl
endif



# DIRS ========================================================================
.PHONY: dirs
dirs:
	mkdir -p $(HOME)/bin
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/.local


# TEST ========================================================================
.PHONY: atest
ATEST	:= $(PWD)/test
atest: $(ATEST)
$(ATEST): __test.out
	$(INST)	








# DOAS ========================================================================
.PHONY: doas
DOAS :=	/etc/doas.conf
doas: $(DOAS)
$(DOAS): doas.conf
	doas install -b $< $@ # this is a nice chicken and egg problem...



# GPP PREPROCESSOR =============================================================
gpp: gpp.c
	$(CC) -o gpp $< 



# FSTAB =======================================================================
fstab: /etc/fstab
ifeq ($(CHOST), cortes)
/etc/fstab: fstab.cortes
	doas mkdir -p /net/homes
	doas mkdir -p /net/share
	doas mkdir -p /net/music
	doas mkdir -p /net/video
	doas install -b $< $@ 
endif



# SYSCTL ======================================================================
.PHONY:	sysctl
sysctl: /etc/sysctl.conf
/etc/sysctl.conf: sysctl.conf
	doas install -b $< $@



# LOGINC ======================================================================
loginc: /etc/login.conf
/etc/login.conf: login.conf
	doas install -b $< $@
.PHONY: loginc



# INSTURL =====================================================================
insturl: /etc/installurl
/etc/installurl: installurl
	doas install -b $< $@
.PHONY: insturl



# RCCONF ======================================================================
rcconf: /etc/rc.conf.local
ifeq ($(CHOST), cortes)
/etc/rc.conf.local: rc.conf.local.cortes
endif
	doas install -b $< $@
.PHONY: rcconf



# PRINTCP ====================================================================
printcp: /etc/printcap
/etc/printcap: printcap
	doas install -b $< $@
.PHONY: printcp




# XSESSION =====================================================================
.PHONY: xsession
XSESSION := $(HOME)/.xsession
xsession: $(XSESSION) xres
__xsession.out: __xsession.in
	$(TPAGE) __xsession.in > $@
$(XSESSION): __xsession.out
	install -b __xsession.out $(XSESSION)
	chmod +x $(HOME)/.xsession




# vim ==========================================================================
.PHONY: vimrc
VIMRC := $(HOME)/.vimrc
vimrc: $(VIMRC)
$(VIMRC): _vimrc
	install -b $< $@
	mkdir -p $(HOME)/.vim/pack/yoko



# EMACS ========================================================================
emacs: $(HOME)/.emacs.d/init.el
$(HOME)/.emacs.d/init.el: init.el
	mkdir -p $(HOME)/.emacs.d
	touch $(HOME)/.emacs.d/custom.el
	install -b $< $@
.PHONY: emacs



# SESSION ======================================================================
session: /usr/local/share/xsessions/squirrel.desktop
/usr/local/share/xsessions/squirrel.desktop: squirrel.desktop
	doas install -b $< $@




# Xresources ===================================================================
.PHONY: xres
XRES := $(HOME)/.Xresources
xres: $(XRES)
__Xresources.out: __Xresources.in
	$(TPAGE) __Xresources.in > $@	
$(XRES): __Xresources.out
	install -b $< $@
	xrdb $@



# i3 ============================================================================
.PHONY: i3
I3 := $(HOME)/.config/i3/config
i3: $(I3)
$(I3): __i3_config.out
	mkdir -p $(HOME)/.config/i3
	install -b __i3_config.out $(I3)
__i3_config.out: __i3_config.in 
	$(TPAGE) __i3_config.in > $@



# i3status =====================================================================
i3status: $(HOME)/.i3status.conf
$(HOME)/.i3status.conf: _i3status.conf.out
	install -b _i3status.conf.out $(HOME)/.i3status.conf
_i3status.conf.out: _i3status.conf.in gpp
	$(GPP) _i3status.conf.in -o _i3status.conf.out
.PHONY: i3status



# KSHRC =======================================================================
kshrc: $(HOME)/.kshrc
_kshrc.out: _kshrc.in gpp
	$(GPP) $< -o $@
$(HOME)/.kshrc: _kshrc.out
	install -b $< $@
.PHONY: kshrc


# PROFILE =======================================================================
profile: $(HOME)/.profile
_profile.out: _profile.in gpp
	$(GPP) $< -o $@
$(HOME)/.profile: _profile.out
	install -b $< $@
.PHONY: profile



# MPV ==============================================================================
mpv: $(HOME)/.mpv/config
$(HOME)/.mpv/config: _mpv_config
	mkdir -p $(HOME)/.mpv
	install -b $< $@
.PHONY: mpv



# XDM ==========================================================================
#xdm: /etc/X11/xdm/Xsetup /etc/X11/xdm/Xresources /etc/X11/xdm/logo.xpm
#/etc/X11/xdm/Xsetup: Xsetup.xdm
#	sudo install -b $< $@
#	sudo chmod +x $@
#/etc/X11/xdm/Xresources: Xresources.xdm
#	sudo install -b $< $@
#/etc/X11/xdm/logo.xpm: logo.xpm.xdm
#	sudo install -b $< $@
#.PHONY: xdm


# userdirs =====================================================================
userdirs: $(HOME)/.config/user-dirs.dirs
$(HOME)/.config/user-dirs.dirs: user-dirs.dirs
	install -b $< $@
.PHONY: userdirs



# gtkrc ========================================================================
gtkrc: $(HOME)/.gtkrc-2.0
$(HOME)/.gtkrc-2.0: _gtkrc-2.0
	install -b $< $@
.PHONY: gtkrc



# guile ========================================================================
guile: $(HOME)/.guile
$(HOME)/.guile: _guile
	install -b $< $@
.PHONY: guile



scripts: $(HOME)/bin/browser
$(HOME)/bin/browser: browser.sh
	mkdir -p $(HOME)/bin
	install -b $< $@
	chmod +x $@
.PHONY: scripts

