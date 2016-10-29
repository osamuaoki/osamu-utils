[//]: # ( vim:se tw=78 ai si sts=4 et: )
# osamu-utils

These are trivial scripts to make my life easy.

Customize to fit to you by modifying Makefile.conf

## Small utility scripts (bin)

*   git-vi      commit to git for every vi exits     (vim, git)
*   git-ime     split a commit into multiple commits (imediff2, git)
*   git-zap     safer "git clean -fdx"               (git)
*   dpkg-ver    compare version strings              (dpkg)

These are commands meant to be installed into the BIN directory listed in
$PATH.

## Configuration files (home)

*   home/.bashrc_alias
*   home/.bashrc_local
*   home/.devscripts
*   home/.gitconfig
*   home/.pbuilderrc
*   home/.quiltrc-dpkg
*   home/.vimrc

These are dot files meant to be installed into the HOME directory of the user. 

== Configuration files (pbuilder) ==

*   pbuilder/A10ccache
*   pbuilder/B90lintian
*   pbuilder/C10shell

These are pbuilder hook scripts installed into /var/cache/pbuilder/hooks..

Intstalation: make install
Diff:         make diff
clean:        make clean

