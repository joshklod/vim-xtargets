# vim-xtargets
Easy switching between GCC cross-compilation targets

## Introduction

xtargets provides a convenient command to set compiler-related options for
multiple cross-compilation targets.  The plugin is designed for GCC, though it
is likely useful for other compilers with some modification.

Currently, xtargets can set the following options:
  - `:compiler`
  - `'makeprg'`
  - `'path'`

## Usage

To use the plugin, all you need to do is run the `:Target` command.  For
example:

    :Target arm-none-eabi

By default, this will set `:compiler`, `'makeprg'`, and `'path'` to
appropriate values for the specified target.  For details on how this is done,
see `:h xtargets-features`.  To customize which options are affected by the
`:Target` command, see `:h xtargets-configuration`.

For full documentation, see the Vim on-line documentation (`:help xtargets`).

## About

vim-xtargets v0.5

Copyright (c) 2017 Josh Klodnicki  
MIT License  
See `doc/xtargets-license.txt` for full license.

Get the latest version, report bugs, or contribute at
<http://github.com/joshklod/vim-xtargets>.
