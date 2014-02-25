## Personal PKGBUILDs
Most of these PKGBUILDs were created because the ones found in the AUR were horribly written.  
Some of the packages contain person changes and tweaks, they will be noted below along with ambigious packages.

### [dmenu-pango-imlib](https://github.com/Cloudef/dmenu-pango-imlib)
Pango and imlib patches from Cloudef applied to dmenu allowing for proper unicode fallback and image generation.

### gvim
There were no sane vim/gvim PKGBUILDs available.  This build uses Python 3 instead of Python 2, it disabled netbeans and gpm support.

### [hhpc](https://github.com/aktau/hhpc)
Hides the mouse after a specified time, a maintained clone of [unclutter](http://unclutter.sourceforge.net/).

### llpp
OpenGL accelerated mupdf based PDF reader.

### [mosml](https://github.com/kfl/mosml)
Moscow ML, a lightweight implementation of Standard ML.

### [retroarch](https://github.com/libretro/retroarch)
Modular multi-system emulator frontend to libretro.

### [sxiv](https://github.com/Cloudef/sxiv/tree/manga-personal)
A simple image viewer with patches for faster image loading, image dimentions in the statusbar and better support for manga reading from Cloudef
This package enables looping gif animations and a new keyboard binding `C-x` for removing the current image.

### system-configs 
Just a small collection of personal configurations.

### [termite](https://github.com/thestinger/termite)
Includes a small patch for reverse URL matching as most relevant output in terminals is at the bottom.

### vte3-select-text
vte3 from 0.36 branch including 24bit colour support patched with block selection support needed for [termite](https://github.com/thestinger/termite)

### weechat
Built against ncurses from git which enables support for italics and configured to use `XDG_CONFIG_HOME/weechat`.

