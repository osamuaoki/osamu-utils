HOMEALL	= $(wildcard home/*)
SKELALL = $(patsubst %, /etc/skel/%, .bash_logout .profile .bashrc)
BINALL =  $(wildcard bin/*)
PBUILDERALL =  $(wildcard pbuilder/*)
BUILDDIR = builddir
BINDIR = bin
PBUILDERDIR = /var/cache/pbuilder/hooks

include Makefile.conf
SEDXX	= sed	-e 's/@@@NAME@@@/$(NAME)/' \
		-e 's/@@@EMAIL@@@/$(EMAIL)/' \
		-e 's/@@@KEYID@@@/$(KEYID)/' \
		#

all: diff

$(BUILDDIR):
	@mkdir -p $(BUILDDIR)

$(HOME)/$(BINDIR):
	@mkdir -p $(HOME)/$(BINDIR)

$(PBUILDERDIR):
	@sudo mkdir -p $(PBUILDERDIR)

################################################################
build: build-skel build-home build-bin install-pbuilder

build-skel: $(patsubst %, build-skel-%, $(notdir $(SKELALL)))

build-skel-.profile: $(BUILDDIR)/.profile
build-skel-.bash_logout: $(BUILDDIR)/.bash_logout
build-skel-.bashrc: $(BUILDDIR)/.bashrc

$(BUILDDIR)/.profile: /etc/skel/.profile | $(BUILDDIR)
	@cp -f $< $@

$(BUILDDIR)/.bash_logout: /etc/skel/.bash_logout | $(BUILDDIR)
	@cp -f $< $@

$(BUILDDIR)/.bashrc: /etc/skel/.bashrc | $(BUILDDIR)
	@cp -f $< $@
	@echo "##########################################################" >>$@
	@echo '# Extra entries added' >>$@
	@echo 'if [ -f ~/.bashrc_local ]; then' >>$@
	@echo '    . ~/.bashrc_local' >>$@
	@echo 'fi' >>$@
	@echo "##########################################################" >>$@

build-home: $(patsubst _%, build-home-.%, $(notdir $(HOMEALL)))

build-home-.%: home/_% | $(BUILDDIR)
	@$(SEDXX) $< > $(BUILDDIR)/.$*

build-bin: $(patsubst %, build-bin-%, $(notdir $(BINALL)))

build-bin-%: bin/% | $(BUILDDIR)
	@cp -f $< $(BUILDDIR)/$*

build-pbuilder: $(patsubst %, build-pbuilder-%, $(notdir $(PBUILDERALL)))

build-pbuilder-%: pbuilder/% | $(BUILDDIR)
	@cp -f $< $(BUILDDIR)/$*

################################################################
install: install-skel install-home install-bin install-pbuilder

install-skel: $(patsubst %, install-skel-%, $(notdir $(SKELALL)))

install-skel-%: build-skel-%
	cp -f $(BUILDDIR)/$* $(HOME)/$*

install-home: $(patsubst _%, install-home-.%, $(notdir $(HOMEALL)))

install-home-%: build-home-%
	cp -f $(BUILDDIR)/$* $(HOME)/$*

install-bin: $(patsubst %, install-bin-%, $(notdir $(BINALL)))

install-bin-%: build-bin-% | $(HOME)/$(BINDIR)
	cp -f $(BUILDDIR)/$* $(HOME)/$(BINDIR)/$*

install-pbuilder: $(patsubst %, install-pbuilder-%, $(notdir $(PBUILDERALL)))

install-pbuilder-%: build-pbuilder-% | $(PBUILDERDIR)
	sudo cp -f $(BUILDDIR)/$* $(PBUILDERDIR)/$*
	sudo chown root:root $(PBUILDERDIR)/$*

################################################################
diff: diff-skel diff-home diff-bin diff-pbuilder

diff-skel: $(patsubst %, diff-skel-%, $(notdir $(SKELALL)))

diff-skel-%: build-skel-%
	@[ -e $(HOME)/$* ] && diff -u $(BUILDDIR)/$* $(HOME)/$* || true
	@[ -e $(HOME)/$* ] || echo "*** Missing $(HOME)/$* ***"

diff-home: $(patsubst _%, diff-home-.%, $(notdir $(HOMEALL)))

diff-home-%: build-home-%
	@[ -e $(HOME)/$* ] && diff -u $(BUILDDIR)/$* $(HOME)/$* || true
	@[ -e $(HOME)/$* ] || echo "*** Missing $(HOME)/$* ***"

diff-bin: $(patsubst %, diff-bin-%, $(notdir $(BINALL)))

diff-bin-%: build-bin-% | $(HOME)/$(BINDIR)
	@[ -e $(HOME)/$(BINDIR)/$* ] && diff -u $(BUILDDIR)/$* $(HOME)/$(BINDIR)/$* || true
	@[ -e $(HOME)/$(BINDIR)/$* ] || echo "*** Missing $(HOME)/$(BINDIR)/$* ***"

diff-pbuilder: $(patsubst %, diff-pbuilder-%, $(notdir $(PBUILDERALL)))

diff-pbuilder-%: build-pbuilder-% | $(PBUILDERDIR)
	@[ -e $(PBUILDERDIR)/$* ] && diff -u $(BUILDDIR)/$* $(PBUILDERDIR)/$* || true
	@[ -e $(PBUILDERDIR)/$* ] || echo "*** Missing $(PBUILDERDIR)/$* ***"

################################################################
clean:
	rm -rf $(BUILDDIR)
