
ROOT=$(PWD)
DEBS=$(ROOT)/deb

all: build $(DEBS)/Packages.gz

$(DEBS):
	mkdir -p $(DEBS)

build: $(DEBS)
	cd $(DEBS) && for f in $(ROOT)/*/ns-control; do equivs-build $$f; done;

$(DEBS)/Packages.gz: $(DEBS) $(wildcard $(DEBS)/*.deb)
	dpkg-scanpackages $(DEBS) /dev/null | gzip -9c > $(DEBS)/Packages.gz

