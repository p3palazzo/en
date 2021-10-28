# Global variables and setup {{{1
# ================
VPATH = _lib
vpath %.yaml .:_spec
vpath default.% .:_lib
vpath reference.% .:_lib

DEFAULTS := defaults.yaml _bibliography/references.bib
JEKYLL-VERSION := 4.2.0
PANDOC-VERSION := 2.14.1
JEKYLL/PANDOC := docker run --rm -v "`pwd`:/srv/jekyll" \
	-h "0.0.0.0:127.0.0.1" -p "4000:4000" \
	palazzo/jekyll-tufte:$(JEKYLL-VERSION)-$(PANDOC-VERSION)
PANDOC/CROSSREF := docker run --rm -v "`pwd`:/data" \
	-u "`id -u`:`id -g`" pandoc/crossref:$(PANDOC-VERSION)

# Targets and recipes {{{1
# ===================
.PHONY : _site
_site : 
	@$(JEKYLL/PANDOC) /bin/bash -c \
	"chmod 777 /srv/jekyll && jekyll build"

.PHONY : serve
serve : 
	@$(JEKYLL/PANDOC) jekyll serve --future

# vim: set foldmethod=marker shiftwidth=2 tabstop=2 :
