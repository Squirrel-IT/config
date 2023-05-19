#-*- coding: utf-8; mode: makefile; -*-

# ENVIRONMENT 
# get the following variables from env:
CHOST = $(shell hostname -s)
COS = $(shell uname -s)


# preprocessor defines:
GPP	= ./gpp -DHOST=$(CHOST) -DOS=$(COS)



all:	showconfig



showconfig:
	@echo os: $(COS)
	@echo gpp: $(GPP)
	@echo host: $(CHOST)
ifeq ($(CHOST), cortes)
	@echo targets: clean doas gpp fstab sysctl loginc insturl rcconf printcp 
else
	@echo targets: clean vimrc emacs
endif



# CLEAN ========================================================================
clean:
	rm -f *.out *~ *.o gpp
.PHONY: clean



# DOAS ========================================================================
doas: /etc/doas.conf
/etc/doas.conf: doas.conf
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
sysctl: /etc/sysctl.conf
/etc/sysctl.conf: sysctl.conf
	doas install -b $< $@
.PHONY: sysctl



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
xsession: $(HOME)/.xsession gpp xres
_xsession.out: _xsession.in
	$(GPP) _xsession.in -o $@
$(HOME)/.xsession: _xsession.out
	install -b _xsession.out $(HOME)/.xsession
	chmod +x $(HOME)/.xsession
.PHONY: xsession













# vim ==========================================================================
vimrc: $(HOME)/.vimrc
$(HOME)/.vimrc: _vimrc
	install -b $< $@
	mkdir -p $(HOME)/.vim/pack/yoko
.PHONY: vimrc



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
xres: $(HOME)/.Xresources
$(HOME)/.Xresources: _Xresources
	install -b $< $@
	xrdb $@
.PHONY: xres



# i3 ============================================================================
i3: $(HOME)/.config/i3/config
$(HOME)/.config/i3/config: _i3_config.out
	mkdir -p $(HOME)/.config/i3
	install -b _i3_config.out $(HOME)/.config/i3/config
_i3_config.out: _i3_config.in gpp
	$(GPP) _i3_config.in -o _i3_config.out
.PHONY: i3



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

