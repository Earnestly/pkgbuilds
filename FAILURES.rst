LTO FAILURES
------------
ncurses-git: Results in configure errors when testing dl*() functions.
pony-git: Causes undefined references when linking test files. `<https://github.com/CausalityLtd/ponyc/issues/288>_`
pulseaudio-git: lto1: internal compiler error: in lto_output_varpool_node, at lto-cgraph.c:623
glibc-git: configure: error: Need linker with .init_array/.fini_array support. `<https://gcc.gnu.org/ml/gcc-help/2013-03/msg00357.html>_`

PIE FAILURES
------------
pulseaudio-git: (.text+0xe): undefined reference to \`__init_array_start'
