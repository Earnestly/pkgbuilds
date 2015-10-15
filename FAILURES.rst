LTO FAILURES
------------
* ncurses-git: Results in configure errors when testing dl*() functions.
* pulseaudio-git: ``lto1: internal compiler error: in lto_output_varpool_node, at lto-cgraph.c:623``
* glibc-git: ``configure: error: Need linker with .init_array/.fini_array support.`` `<https://gcc.gnu.org/ml/gcc-help/2013-03/msg00357.html>_`

OTHER FAILURES
--------------
* pulseaudio-git:
  Cannot use C/CXXFLAGS -flto, -fPIC and -pie.  Cannot use LDFLAGS relro and
  now. ::

    /usr/lib/libc_nonshared.a(elf-init.oS): In function `__libc_csu_init':
    (.text+0x23): undefined reference to `__init_array_start'

    /usr/bin/ld: /usr/lib/libc_nonshared.a(elf-init.oS): relocation R_X86_64_PC32 
    against undefined hidden symbol `__init_array_start' can not be used when 
    making a shared object

    /usr/bin/ld: final link failed: Bad value
