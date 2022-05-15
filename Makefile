# Global variables and setup {{{1
# ================
VPATH = _lib
vpath %.yaml .:_spec:_data
vpath default.% .:_lib
vpath reference.% .:_lib

DEFAULTS := defaults.yaml _bibliography/references.bib
JEKYLL-VERSION := 4.2.0
PANDOC-VERSION := 2.18
JEKYLL/PANDOC := docker run --rm -v "`pwd`:/srv/jekyll" \
	-h "0.0.0.0:127.0.0.1" -p "4000:4000" \
	palazzo/jekyll-tufte:$(JEKYLL-VERSION)-$(PANDOC-VERSION)
JEKYLL/JEKYLL := docker run --rm -v "`pwd`:/srv/jekyll" \
	-h "0.0.0.0:127.0.0.1" -p "4000:4000" \
	jekyll/jekyll:3.8.5
PANDOC/CROSSREF := docker run --rm -v "`pwd`:/data" \
	-u "`id -u`:`id -g`" pandoc/crossref:$(PANDOC-VERSION)

# Targets and recipes {{{1
# ===================
.PHONY : _site
_site : 
	@$(JEKYLL/JEKYLL) /bin/bash -c \
	"chmod 777 /srv/jekyll && jekyll build"

.PHONY : serve
serve : 
	@$(JEKYLL/JEKYLL) jekyll serve --future

# vim: set foldmethod=marker shiftwidth=2 tabstop=2 :
