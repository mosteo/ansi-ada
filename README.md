# ANSI-Ada

[![Alire indexed](https://img.shields.io/badge/alire-0.1.0-blue.svg)](https://alire.ada.dev)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

ANSI control sequences for the Ada language.

This library consists of a single pure package for the generation of escape
sequences that allow to control, in ANSI-enabled TTYs:

* Text color and styles
* Cursor position
* Clearing of parts of the terminal

In order to keep the library as simple as possible there is no TTY capability
detection, so you must either assume ANSI is recognized or use other means of
detection (e.g., `Interfaces.C_Streams.isatty` as a bare minimum to detect
redirections).

The library comes with a demo program that can serve to test the appearance and
capabilities of your terminal. 
