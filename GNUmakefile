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

SINST 	= doas install -bpm 644 --  $< $@ 
SINSTX 	= doas install -bpm 755 --  $< $@ 
SINSTA  = doas install -bpm 600 --  $< $@ 
INST 	= install -bpm 644 --  $< $@ 
INSTX 	= install -bpm 755 --  $< $@ 



.SUFFIXES: .out .in
%.out: %.in
	$(TPAGE) $< > $@


.PHONY: all showconfig
all:	showconfig


showconfig:
	@echo os: $(COS)
	@echo gpp: $(GPP)
	@echo tpage: $(TPAGE)
	@echo host: $(CHOST)

	@echo targets: clean installpackages dirs test bash xres xsession doas gpp
ifeq ($(COS), OpenBSD)
	@echo targets: fstab sysctl loginc insturl rcconf printcp 
endif



# CLEAN ========================================================================
.PHONY: clean
clean:
	rm -f *.out *~ *.o gpp test *.old


# INSTALL PACKAGES ============================================================
installpackages:
ifeq ($(COS), Linux)
	doas apt install doas dbus-x11 vim i3 i3status rofi dunst picom nitrogen make fonts-inconsolata libtemplate-perl emacs rxvt-unicode
endif
ifeq ($(COS),OpenBSD)
	doas pkg_add vim i3 rofi dunst picom nitrogen gmake git i3status inconsolata-font p5-Template p5-Text-Template colorls emacs rxvt-unicode bash
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



# BASH ========================================================================
.PHONY: bash
BASHPROFILE 	:= $(HOME)/.bash_profile
BASHRC			:= $(HOME)/.bashrc
bash: $(BASHPROFILE) $(BASHRC)
$(BASHPROFILE): __bash_profile.out
	$(INST)
$(BASHRC):	__bashrc.out
	$(INST)



# Xresources ===================================================================
.PHONY: xres
XRES := $(HOME)/.Xresources
xres: $(XRES)
$(XRES): __Xresources.out
	$(INST)	
	xrdb $@




# XSESSION =====================================================================
.PHONY: xsession
XSESSION := $(HOME)/.xsession
xsession: $(XSESSION) xres
$(XSESSION): __xsession.out
	$(INSTX)	



# i3 ============================================================================
.PHONY: i3
I3 := $(HOME)/.config/i3/config
i3: $(I3)
$(I3): __i3_config.out
	mkdir -p $(HOME)/.config/i3
	$(INST)



# DOAS ========================================================================
.PHONY: doas
DOAS :=	/etc/doas.conf
doas: $(DOAS)
$(DOAS): doas.conf
	$(SINSTA)



# GPP PREPROCESSOR =============================================================
gpp: gpp.c
	$(CC) -o gpp $< 




# SYSCTL ======================================================================
.PHONY:	sysctl
sysctl: /etc/sysctl.conf
/etc/sysctl.conf: sysctl.conf
	$(SINST)


















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

