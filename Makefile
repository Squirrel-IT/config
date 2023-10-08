#-*- coding: utf-8; mode: makefile; -*-

# This is the debian version.
# It uses dnf to install packages.
# It also uses sudo instead of doas/opendoas - for now.

# GNU make uses $<, $^, $@, ...
# BSD make uses ${.IMPSRC}, ${.ALLSRC}, ${.TARGET}, ... (note, that both *SRC variables hold a list of source files)

# PACKAGES 
PACKAGES	:= vim libtemplate-perl emacs dunst rofi foot 
PACKAGES	+= moc cmus guile-3.0 g++ meson opendoas nala
PACKAGES	+= buku ncdu gnupg xpdf mg btop htop mpg123 fzf sway


# ENVIRONMENT 
# Check the environment to detect on which system we are running.

# get the following variables from env:
CHOST 		!= hostname -s
COS 		!= uname -s
CDATE		!= date
HBIN		:= ${HOME}/bin


# COMMANDS
DOAS		:= sudo


# preprocessor defines
# two possible preprocessors perl-template or gpp (sources included)
GPP		:= ./gpp -DHOST=${CHOST} -DOS=${COS}
TPAGE		:= tpage --define host=${CHOST} --define os=${COS} --define date="${CDATE}"


# install
SINST 		:= $(DOAS) install -bpm 644 
SINSTX 		:= $(DOAS) install -bpm 755 
SINSTA  	:= $(DOAS) install -bpm 600 
INST 		:= install -bpm 644
INSTX 		:= install -bpm 755 


.SUFFIXES: .out .in
.in.out:
	${TPAGE} $< > $@


.PHONY: all showconfig
all:	showconfig


showconfig:
	@echo os: ${COS}
	@echo gpp: ${GPP}
	@echo tpage: ${TPAGE}
	@echo host: ${CHOST}

	@echo targets: clean installpackages dirs atest bash sway foot emacs



# CLEAN ========================================================================
.PHONY: clean
clean:
	rm -f *.out *~ *.o gpp test *.old



# INSTALL PACKAGES ============================================================
installpackages:
	sudo apt install ${PACKAGES}



# DIRS ========================================================================
.PHONY: dirs
dirs:
	mkdir -p $(HOME)/bin
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/.local



# TEST ========================================================================
.PHONY: atest
ATEST := $(PWD)/test
atest: ${ATEST}
${ATEST}: __test.out
	${INST} $^ $@ 



# BASH ========================================================================
.PHONY: bash
BASHPROFILE 	:= $(HOME)/.bash_profile
BASHRC		:= $(HOME)/.bashrc
bash: $(BASHPROFILE) $(BASHRC)
$(BASHPROFILE): __bash_profile.out
	$(INST) $^ $@  
$(BASHRC):	__bashrc.out
	$(INST) $^ $@ 




# sway ============================================================================
.PHONY: sway
sway := $(HOME)/.config/sway/config
sway: $(sway)
$(sway): __sway_config.out
	mkdir -p $(HOME)/.config/sway
	$(INST) $^ $@


# foot ============================================================================
.PHONY: foot
foot := $(HOME)/.config/foot/foot.ini
foot: $(foot)
$(foot): __foot_ini.out
	mkdir -p $(HOME)/.config/foot
	$(INST) $^ $@



# # DOAS ========================================================================
# .PHONY: doas
# DOAS :=	/usr/local/etc/doas.conf # FreeBSD specific
# endif
# doas: $(DOAS)
# $(DOAS): doas.conf
# 	$(SINSTA)



# GPP PREPROCESSOR =============================================================
_gpp: ${HBIN}/gpp
${HBIN}/gpp: gpp
	${INSTX}



# EMACS ========================================================================
.PHONY: emacs
emacs: $(HOME)/.emacs.d/init.el
$(HOME)/.emacs.d/init.el: init.el
	mkdir -p $(HOME)/.emacs.d
	touch $(HOME)/.emacs.d/custom.el
	install -b $< $@


# # xdm ==========================================================================
# .PHONY: xdm
# XSETUP	:= /usr/local/etc/X11/xdm/Xsetup_0
# XDMRES	:= /usr/local/etc/X11/xdm/Xresources
# xdm: $(XSETUP) $(XDMRES)
# $(XSETUP): xdm_Xsetup_0
# 	$(SINST)
# $(XDMRES): xdm_Xresources
# 	$(SINST)


# # FSTAB =======================================================================
# fstab: /etc/fstab
# ifeq ($(CHOST), pitfall)
# /etc/fstab: fstab.pitfall
# 	doas mkdir -p /net/homes
# 	doas mkdir -p /net/share
# 	doas mkdir -p /net/music
# 	doas mkdir -p /net/video
# 	doas mkdir -p /net/archive
# 	$(SINST)
# endif




# # SYSCTL ======================================================================
# .PHONY:	sysctl
# sysctl: /etc/sysctl.conf
# /etc/sysctl.conf: sysctl.conf
# 	$(SINST)



# # LOGINC ======================================================================
# loginc: /etc/login.conf
# /etc/login.conf: login.conf
# 	doas install -b $< $@
# .PHONY: loginc



# # INSTURL =====================================================================
# insturl: /etc/installurl
# /etc/installurl: installurl
# 	doas install -b $< $@
# .PHONY: insturl



# # RCCONF ======================================================================
# rcconf: /etc/rc.conf.local
# ifeq ($(CHOST), cortes)
# /etc/rc.conf.local: rc.conf.local.cortes
# endif
# 	doas install -b $< $@
# .PHONY: rcconf



# # PRINTCP ====================================================================
# printcp: /etc/printcap
# /etc/printcap: printcap
# 	doas install -b $< $@
# .PHONY: printcp






# # vim ==========================================================================
# .PHONY: vimrc
# VIMRC := $(HOME)/.vimrc
# vimrc: $(VIMRC)
# $(VIMRC): _vimrc
# 	install -b $< $@
# 	mkdir -p $(HOME)/.vim/pack/yoko







# # SESSION ======================================================================
# session: /usr/local/share/xsessions/squirrel.desktop
# /usr/local/share/xsessions/squirrel.desktop: squirrel.desktop
# 	doas install -b $< $@








# # KSHRC =======================================================================
# kshrc: $(HOME)/.kshrc
# _kshrc.out: _kshrc.in gpp
# 	$(GPP) $< -o $@
# $(HOME)/.kshrc: _kshrc.out
# 	install -b $< $@
# .PHONY: kshrc


# # PROFILE =======================================================================
# profile: $(HOME)/.profile
# _profile.out: _profile.in gpp
# 	$(GPP) $< -o $@
# $(HOME)/.profile: _profile.out
# 	install -b $< $@
# .PHONY: profile



# # MPV ==============================================================================
# mpv: $(HOME)/.mpv/config
# $(HOME)/.mpv/config: _mpv_config
# 	mkdir -p $(HOME)/.mpv
# 	install -b $< $@
# .PHONY: mpv



# # userdirs =====================================================================
# userdirs: $(HOME)/.config/user-dirs.dirs
# $(HOME)/.config/user-dirs.dirs: user-dirs.dirs
# 	install -b $< $@
# .PHONY: userdirs



# # gtkrc ========================================================================
# gtkrc: $(HOME)/.gtkrc-2.0
# $(HOME)/.gtkrc-2.0: _gtkrc-2.0
# 	install -b $< $@
# .PHONY: gtkrc



# # guile ========================================================================
# guile: $(HOME)/.guile
# $(HOME)/.guile: _guile
# 	install -b $< $@
# .PHONY: guile



# scripts: $(HOME)/bin/browser
# $(HOME)/bin/browser: browser.sh
# 	mkdir -p $(HOME)/bin
# 	install -b $< $@
# 	chmod +x $@
# .PHONY: scripts


# # Xresources ===================================================================
# .PHONY: xres
# XRES := $(HOME)/.Xresources
# xres: $(XRES)
# $(XRES): __Xresources.out
# 	$(INST)	
# 	xrdb ${.TARGET}



# # XSESSION =====================================================================
# .PHONY: xsession
# XSESSION := $(HOME)/.xsession
# xsession: $(XSESSION) xres
# $(XSESSION): __xsession.out
# 	$(INSTX)	


# # i3 ============================================================================
# .PHONY: i3
# I3 := $(HOME)/.config/i3/config
# i3: $(I3)
# $(I3): __i3_config.out
# 	mkdir -p $(HOME)/.config/i3
# 	$(INST)



# # i3status =====================================================================
# i3status: $(HOME)/.i3status.conf
# $(HOME)/.i3status.conf: _i3status.conf.out
# 	install -b _i3status.conf.out $(HOME)/.i3status.conf
# _i3status.conf.out: _i3status.conf.in gpp
# 	$(GPP) _i3status.conf.in -o _i3status.conf.out
# .PHONY: i3status
