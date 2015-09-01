Most of these PKGBUILDs were created because the ones found in the AUR were horribly written.  
Some of the packages contain personal changes and tweaks, they will be noted below along with ambigious packages.


`DMENU-PANGO-IMLIB`_
--------------------
Pango and imlib patches from [Cloudef](https://github.com/Cloudef) applied to dmenu allowing for proper unicode fallback and image generation.

.. _DMENU-PANGO-IMLIB: https://github.com/Cloudef/dmenu-pango-imlib


GVIM
----
There were no sane vim/gvim PKGBUILDs available.  This build uses Python 3 instead of Python 2, it disabled netbeans and gpm support.  This also includes a small personal patch which removes the unconfigurable delay when editting readonly files.

*Note: This doesn't include downstream configs and changes unlike `Arch's official`_ package so make sure stuff like `nocompat` is set in your vimrc or otherwise.*

.. _Arch's official: https://projects.archlinux.org/svntogit/packages.git/tree/trunk/archlinux.vim?h=packages/vim


`HHPC`_
-------
Hides the mouse after a specified time, a maintained clone of `unclutter`_

.. _HHPC: https://github.com/aktau/hhpc
.. _unclutter: http://unclutter.sourceforge.net/


SYSTEM-CONFIGS 
--------------
Just a small collection of personal configurations.


`TERMITE`_
----------
Includes a small patch to reverse URL matching as most of the relevant output in terminals is at the bottom.

.. _TERMITE: https://github.com/thestinger/termite


WEECHAT
-------
Built against ncurses 6.0 which enables support for italics and configured to use ``XDG_CONFIG_HOME/weechat``.
