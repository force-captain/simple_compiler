# compilers
OCAML=ocamlc 
OCAMLOPT=ocamlopt
LEX=ocamllex
YACC=ocamlyacc

# src
MLL_SRC=$(wildcard *.mll)
MLY_SRC=$(wildcard *.mly)

# gen
GEN_ML=$(MLL_SRC:.mll=.ml) $(MLY_SRC:.mly=.ml)
GEN_MLI=$(MLY_SRC:.mly=.mli)

ML_SRC=$(filter-out $(GEN_ML), $(wildcard *.ml))
MLI_SRC=$(filter-out $(GEN_MLI), $(wildcard *.mli))

ALL_ML=$(ML_SRC) $(GEN_ML)
ALL_MLI=$(MLI_SRC) $(GEN_MLI)

OBJ=$(ALL_ML:.ml=.cmo)

# target
TARGET=main

OBJ_ORDERED := $(shell ocamldep -sort $(ALL_ML) $(ALL_MLI) | sed 's/\.mli$$/.cmo/; s/\.ml$$/.cmo/')

# rules
all: $(TARGET)

$(TARGET): $(OBJ_ORDERED)
	$(OCAML) -o $@ $(OBJ_ORDERED)

%.cmo: %.ml
	$(OCAML) -c $<

%.cmi: %.mli
	$(OCAML) -c $<

%.ml: %.mll
	$(LEX) $<

%.ml %.mli: %.mly
	$(YACC) --infer $<

depend: .depend

.depend: $(ALL_ML) $(ALL_MLI)
	ocamldep $(ALL_ML) $(ALL_MLI) > $@

include .depend

clean:
	rm -f *.cmo *.cmi *.o $(GEN_ML) $(GEN_MLI) $(TARGET) .depend

.PHONY: all clean depend
