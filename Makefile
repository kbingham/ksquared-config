
ROOT=$(PWD)
DEBS=$(ROOT)/deb

# The relevance of .nsc : equivs-build references ns-control files

all: build $(DEBS)/Packages.gz

%.nsc: %.nsc.dependancies %.nsc.template
	@echo "Generating $@ from $^"
	@sed -e 's/#DEPENDANCIES/$(shell paste -d, -s $@.dependancies)/g' $@.template > $@
	@sed -e 's/^Version:.*/Version: $(shell date +%F)/g' -i $@

$(DEBS):
	mkdir -p $(DEBS)

build: $(DEBS)
	cd $(DEBS) && for f in $(ROOT)/*/*.nsc; do echo "Building $$f"; equivs-build $$f; done;

$(DEBS)/Packages.gz: $(DEBS) $(wildcard $(DEBS)/*.deb)
	dpkg-scanpackages $(DEBS) /dev/null | gzip -9c > $(DEBS)/Packages.gz

