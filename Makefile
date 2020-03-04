# Install and cleanup {{{1
# ===================
# `make install` copies various config files and hooks to the .git
# directory and sets up standard empty directories.
.PHONY : install clean makedirs submodule virtualenv build serve
install : makedirs submodule virtualenv
	# rm -rf .install
	# The .install folder is quite small and is thus not removed even
	# after a successful run of `make install`. This is useful should
	# you need to reinstall or if you want to reconfigure your
	# submodules (e.g. to checkout other citation styles). If that
	# bothers you, uncomment the line above.

makedirs :
	-mkdir _share
	-mkdir _book
	-mkdir fig

submodule :
	git submodule update --init
	rsync -aq .install/git/ .git/
	cd lib/styles && git config core.sparsecheckout true && \
		git read-tree -m -u HEAD

virtualenv :
	python3 -m virtualenv .venv && source .venv/bin/activate && \
		pip3 install -r .install/requirements.txt
	-rm -rf src

build  :
	bundle exec jekyll build

serve  :
	bundle exec jekyll serve

# `make clean` will clear out a few standard folders where only compiled
# files should be. Anything you might have placed manually in them will
# also be deleted!
clean :
	-rm -r _book/* _site/*

# vim: set foldmethod=marker :
