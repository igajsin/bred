SRC	  = src
OCB_FLAGS = -use-ocamlfind -tag bin_annot -I $(SRC)
OCB       = ocamlbuild $(OCB_FLAGS)
PDFLATEX  = pdflatex

all: 		native byte # profile debug

clean:
	$(OCB) -clean

native:
	$(OCB) bred.native

byte:
	$(OCB) bred.byte

profile:
	$(OCB) -tag profile bred.native

debug:
	$(OCB) -tag debug bred.byte

doc_html:
	$(OCB) doc/bred.docdir/index.html
	mkdir -p doc/html
	cp bred.docdir/*html doc/html
	cp bred.docdir/*css doc/html

doc_tex:
	$(OCB) doc/bred.docdir/bred.tex
doc_pdf: doc_tex
	(cd _build/doc/bred.docdir/ && $(PDFLATEX) -output-directory ../../../doc/pdf bred.tex)

#test: 		native
#			./bred.native "OCaml" "OCamlBuild" "users"


.PHONY: 	all clean byte native profile debug doc #test

