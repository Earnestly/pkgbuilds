VERSION = 20

CAMLOPT = ocamlopt
BO = le
VPATH := ${BO}

INCS = -I/usr/include -I/usr/include/freetype2 -include ft2build.h
LIBS = -L/usr/lib -lX11 -lpthread -lmupdf -lmujs -ljbig2dec -lcrypto \
       -lz -lopenjp2 -ljpeg -lfreetype -lEGL

ifdef fontconfig
CPPFLAGS += -DUSE_FONTCONFIG
LIBS += -lfontconfig
endif

CPPFLAGS += -DUSE_EGL
CFLAGS += ${INCS} ${CPPFLAGS}
LDFLAGS += ${LIBS}

SRC = utils.ml wsi.ml parser.ml config.ml main.ml
OBJ = bo.cmx help.cmx ${SRC:.ml=.cmx}
MOD = unix.cmxa str.cmxa lablgl.cmxa
LABLGL = -I +lablGL

DISTFILES := Makefile ${SRC} ${BO}/bo.ml link.c glfont.c keysym2ucs.c wsi.mli pp.sed
DISTFILES += mkhelp.sh keystoml.ml KEYS

all: llpp

llpp: ${OBJ} link.o
	${CAMLOPT} -o $@ ${LABLGL} link.o -cclib '${LDFLAGS}' ${MOD} ${OBJ}

main.cmx: main.ml utils.cmx config.cmx
	${CAMLOPT} -c -o $@ ${LABLGL} -w A-4 -pp "sed -f pp.sed" -thread $^

wsi.cmx: wsi.cmi utils.cmx

help.ml: mkhelp.sh keystoml.ml KEYS
	sh mkhelp.sh keystoml.ml KEYS > $@

config.cmx: parser.cmx utils.cmx help.cmx

link.o: glfont.c keysym2ucs.c

.SUFFIXES: .ml .mli .cmo .cmi .cmx .mll .mly

.c.o:
	${CAMLOPT} -c -o $@ -ccopt '${CFLAGS}' $<

.ml.cmx:
	${CAMLOPT} -c -o $@ ${LABLGL} $<

.mli.cmi:
	${CAMLOPT} -c -o $@ $<

.PHONY: all clean install

clean:
	${RM} llpp link.o help.ml ${OBJ} ${OBJ:.cmx=.cmi} ${OBJ:.cmx=.o}

dist: clean
	mkdir llpp-${VERSION}
	cp ${DISTFILES} llpp-${VERSION}
	tar czf llpp-${VERSION}.tar.gz llpp-${VERSION}
	rm -rf llpp-${VERSION}

install:
	install -Dm755 llpp ${DESTDIR}${PREFIX}/bin/llpp
	install -Dm755 misc/llppac ${DESTDIR}${PREFIX}/bin/llppac
