OCB_FLAGS = -use-ocamlfind -I src
OCB = 		ocamlbuild $(OCB_FLAGS)

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

#test: 		native
#			./bred.native "OCaml" "OCamlBuild" "users"


.PHONY: 	all clean byte native profile debug #test

