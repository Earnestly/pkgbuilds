VERSION = 21

# Paths
PREFIX ?= /usr/local

# Includes and libs
INCS = -I/usr/include -I/usr/include/freetype2 -include ft2build.h
LIBS = -L/usr/lib -lX11 -lpthread -lmupdf -lmujs -ljbig2dec -lcrypto \
       -lz -lopenjp2 -ljpeg -lfreetype

CPPFLAGS += -D_GNU_SOURCE -DOBSCURED_OPT -DFFP
CFLAGS += -g -std=c99 -pedantic -Wall ${INCS} ${CPPFLAGS}
LDFLAGS += -g ${LIBS}

# Ocaml
CAMLOPT = ocamlopt
CAMLFLAGS = -g -w +a-4 -I +lablGL

BO = le
VPATH := ${BO}

SRC = utils.ml wsi.ml parser.ml config.ml main.ml
OBJ = help.cmx ${SRC:.ml=.cmx}
MOD = unix.cmxa str.cmxa lablgl.cmxa

DISTFILES := Makefile ${SRC} link.c glfont.c keysym2ucs.c wsi.mli pp.sed
DISTFILES += mkhelp.sh keystoml.ml KEYS be/ le/ misc/

all: llpp

llpp: ${OBJ} link.o
	${CAMLOPT} -o $@ ${CAMLFLAGS} link.o -cclib '${LDFLAGS}' ${MOD} ${OBJ}

main.cmx: main.ml utils.cmx config.cmx
	${CAMLOPT} -c -o $@ ${CAMLFLAGS} -pp "sed -f pp.sed" -thread $^

wsi.cmx: wsi.cmi utils.cmx

wsi.cmi: utils.cmx

help.ml: mkhelp.sh KEYS
	sh mkhelp.sh KEYS > $@

config.cmx: parser.cmx utils.cmx help.cmx wsi.cmi

link.o: glfont.c keysym2ucs.c

.SUFFIXES: .ml .mli .cmo .cmi .cmx .mll .mly

.c.o:
	${CAMLOPT} -c -o $@ ${CAMLFLAGS} -cc ${CC} -ccopt '${CFLAGS}' $<

.ml.cmx:
	${CAMLOPT} -c -o $@ ${CAMLFLAGS} $<

.mli.cmi:
	${CAMLOPT} -c -o $@ ${CAMLFLAGS} $<

.PHONY: all clean install

clean:
	${RM} llpp link.o help.ml ${OBJ} ${OBJ:.cmx=.cmi} ${OBJ:.cmx=.o}

dist: clean
	mkdir llpp-${VERSION}
	cp -r ${DISTFILES} llpp-${VERSION}
	tar czf llpp-${VERSION}.tar.gz llpp-${VERSION}
	rm -rf llpp-${VERSION}

install:
	install -Dm755 llpp ${DESTDIR}${PREFIX}/bin/llpp
	install -Dm755 misc/llppac ${DESTDIR}${PREFIX}/bin/llppac
	install -Dm644 misc/llpp.desktop ${DESTDIR}${PREFIX}/share/applications/llpp.desktop
