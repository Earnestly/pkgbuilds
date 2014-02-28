CAMLOPT = ocamlopt

INCS = -I/usr/include -I/usr/include/freetype2 -include config/ftheader.h
LIBS = -L/usr/lib -lX11 -lpthread -lmupdf -lmupdf-js-none -ljbig2dec \
       -lz -lopenjp2 -ljpeg -lfreetype

CFLAGS = -O ${INCS}
LDFLAGS = ${LIBS}

OBJ = help.cmx utils.cmx wsi.cmx parser.cmx main.cmx
MOD = unix.cmxa str.cmxa lablgl.cmxa
LABLGL = -I +lablGL

all: llpp

llpp: ${OBJ} link.o
	${CAMLOPT} -o $@ ${MOD} ${LABLGL} link.o -cclib '${LDFLAGS}' ${OBJ}

main.cmx: help.cmx utils.cmx wsi.cmx parser.cmx

wsi.cmx: wsi.cmi

help.ml: mkhelp.sh keystoml.ml KEYS
	sh mkhelp.sh keystoml.ml KEYS > $@

.SUFFIXES: .ml .mli .cmo .cmi .cmx .mll .mly

.c.o:
	${CAMLOPT} -c -o $@ -ccopt '${CFLAGS}' $<

.ml.cmx:
	${CAMLOPT} -c -o $@ ${LABLGL} $<

.mli.cmi:
	${CAMLOPT} -c -o $@ $<

.PHONY: clean install

clean:
	${RM} llpp link.o help.ml ${OBJ} ${OBJ:.cmx=.cmi} ${OBJ:.cmx=.o}

install:
	install -Dm755 llpp ${DESTDIR}${PREFIX}/bin/llpp
