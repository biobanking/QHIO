imports/qhio-obo.owl:
	cd imports && make

%.ld: %.md
	pandoc --filter pandoc-code --to plain $< > $@

%.dot: %.ld
	src/make-diagram.py < $< > $@

%.pdf: %.dot
	dot -Tpdf -o$@ $<

%.png: %.dot
	dot -Tpng -o$@ $<
