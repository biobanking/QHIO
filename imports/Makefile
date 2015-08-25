LIB = ../lib
ontologies = obi fma go cl doid ero obib
imports = $(foreach o,$(ontologies),qhio-$(o).owl)
inputs = $(foreach i,$(imports),--input $(i))

qhio-obo.owl: $(imports) overrides.ttl
	robot merge $(inputs) \
	--input overrides.ttl \
	--output qhio-obo.owl
	sed -i '' '/owl#Thing/d' $@

obo-terms.txt: ../overview.md ../example.md
	@cd .. \
	&& pandoc overview.md example.md --filter=src/extract-terms.py \
	> /dev/null

qhio-obi.owl: obo-terms.txt $(LIB)/obi.owl
	robot extract --input $(LIB)/obi.owl \
	--lower-terms obo-terms.txt \
	--lower-term "BFO:0000016" \
	--output qhio-obi.owl

qhio-fma.owl: obo-terms.txt $(LIB)/fma.owl
	robot extract --input $(LIB)/fma.owl \
	--lower-terms obo-terms.txt \
	--output qhio-fma.owl

qhio-go.owl: obo-terms.txt $(LIB)/go.owl
	robot extract --input $(LIB)/go.owl \
	--lower-terms obo-terms.txt \
	--output qhio-go.owl

qhio-cl.owl: $(LIB)/cl.owl
	robot extract --input $(LIB)/cl.owl \
	--upper-term "CL:0000255" \
	--upper-term "CL:0000003" \
	--lower-term "CL:0002617" \
	--output qhio-cl.owl

qhio-doid.owl: obo-terms.txt $(LIB)/doid.owl
	robot extract --input $(LIB)/doid.owl \
	--lower-terms obo-terms.txt \
	--output qhio-doid.owl

#qhio-chebi.owl: obo-terms.txt $(LIB)/chebi.owl
#	robot extract --input $(LIB)/chebi.owl \
#	--lower-terms obo-terms.txt \
#	--output qhio-chebi.owl

qhio-ero.owl: $(LIB)/ero.owl
	robot extract --input $(LIB)/ero.owl \
	--upper-term "OBI:0000070" \
	--lower-term "ERO:0001605" \
	--output qhio-ero.owl

qhio-obib.owl: $(LIB)/obib.owl
	robot extract --input $(LIB)/obib.owl \
	--upper-term "OBI:0000070" \
	--lower-term "OMIABIS:0001041" \
	--output qhio-obib.owl
