# Data comes from three places:
#
# - overview.md: application ontology terms
# - new-terms.tsv: Google Spreadsheet with definitions for QHIO terms
# - example.md: instance data
# - prefixes.tsv: a table of prefixes and custom labels
#
# Required software:
#
# - pandoc
# - robot
# - rapper
# - James' tab-ld scripts

# Project URIs
GITHUB=https://github.com/ontodev/QHIO/raw/master/
QHIO=$(GITHUB)qhio-prototype.owl
EXAMPLE=$(GITHUB)example.ttl

# Download Google Spreadsheets in tab-sepatated format
GOOGLE = https://docs.google.com/spreadsheets/d
SHEETID = 1mzK0qvPvfVbFiTIKTrZoHH23h92V1gA265jwVDhGktg
DOWNLOAD = "$(GOOGLE)/$(SHEETID)/export?format=tsv"

new-terms.tsv:
	curl -L -o $@ "$(DOWNLOAD)&gid=1634024243"

# Get a list of names for all types used in example.md
types.txt: example.md
	< $^ \
	grep '      type:' \
	| sed 's/^[ ]*type:[ ]*//' \
	| sort -f \
	| uniq \
	> $@

# Build an ontology of imported OBO terms
imports/qhio-obo.owl: overview.md example.md
	cd imports && make

# Build an ontology of new QHIO terms
qhio-new.owl: new-terms.tsv imports/qhio-obo.owl
	robot template \
	--prefix 'qhio: $(QHIO)#' \
	--input imports/qhio-obo.owl \
	--template new-terms.tsv \
	--output $@

# Merge the imported and new ontologies
qhio-prototype.owl: qhio-new.owl imports/qhio-obo.owl
	robot merge \
	--input qhio-new.owl \
	--input imports/qhio-obo.owl \
	annotate \
	--ontology-iri "$(QHIO)" \
	--output $@

# Use tab-ld utilities
export PATH := /Users/james/Repositories/ontodev/tab-ld/src:$(PATH)

# Use qhio-prototype.owl to make a table that maps rdfs:labels to IRIs
labels.tsv: qhio-prototype.owl
	rapper -q -i rdfxml -o ntriples $^ \
	| grep 'rdf-schema#label>' \
	| ld-n3t \
	| awk 'BEGIN{FS=OFS="	"}{print $$3,$$1}' \
	| sort -f \
	| uniq \
	> $@

# Convert the context.tsv to a set of xmlns options for rapper to use
xmlns.txt: context.tsv
	< $^ \
	grep '<' \
	| awk 'BEGIN{FS="	"}{print "-f !xmlns:" $$1 "=\"" $$2 "\"!"}' \
	| tr '\n' ' ' \
	| tr '!' "'" \
	| tr -d '<>' \
	| sed 's/xmlns:=/xmlns=/' \
	> $@

# Convert the example.md file to Turtle format
# - unfold stanzas into a table of triples
# - add a 'label' triple for each 'type' triple
# - use context to convert values to links
# - convert triple table to NTriples
# - convert NTriples to Turtle
example.ttl: example.ld context.tsv labels.tsv xmlns.txt
	< $< \
	ld-unfold \
	| awk 'BEGIN{FS=OFS="	"} $$2=="type" {print $$1,"rdfs:label",$$1,"rdf:PlainLiteral"}{print $$0}' \
	| ld-link -c labels.tsv -c context.tsv \
	| ld-tn3 \
	| rapper -q -i ntriples -o turtle $(shell cat xmlns.txt) - $(EXAMPLE) \
	> $@

%.ld: %.md
	pandoc --filter pandoc-code --to plain $< > $@

%.dot: %.ld
	src/make-diagram.py < $< > $@

%.pdf: %.dot
	dot -Tpdf -o$@ $<

%.png: %.dot
	dot -Tpng -o$@ $<

