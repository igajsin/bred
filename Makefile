SRC	  = src
OCB_FLAGS = -use-ocamlfind -I $(SRC)
OCB       = ocamlbuild $(OCB_FLAGS)
ODOC      = ocamldoc -I $(SRC)

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

doc:
			$(ODOC) -html -d doc

#test: 		native
#			./bred.native "OCaml" "OCamlBuild" "users"


.PHONY: 	all clean byte native profile debug doc #test

