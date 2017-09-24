# This rot13/ directory holds my home directory configuration files.
# In order to save me from SPAM, the files are rot13 encrypted.
# Yes, this doesn't have password !
# This is just obscuring my email addresses
#
# Install bsdgames and moreutils packages
#
# just do make in this directory.
#
# Osamu

FILELIST := $(filter-out Makefile, $(wildcard * .[^.]*))

all:
	for f in $(FILELIST) ; do \
	rot13 <$$f | sponge $$f ; \
	done

list:
	echo $(FILELIST)
