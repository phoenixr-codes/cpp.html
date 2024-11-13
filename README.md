# cpp.html

This repository demonstrates how to use the C preprocessor (CPP) as a template engine to generate
HTML files. This technique is merely a proof of concept and meant as a joke and should not be used
seriously; template engines exist for a reason.

Just like most template engine, this mechanism is not limited to HTML and can be used for any kind
of file (I heard it's quite good for C and C++).


## Basic Usage

### Templates

The `templates` directory contains HTML templates. They typically have the following form:

```c
#include "base.html"
#define $foo($foo_arg) \
$base( \
  <p>$foo_arg</p> \
)
```


### Source

The `source` directory contains the source HTML files. They typically have the following form:

```c
#include "base.html"
$base( 
  <p>Hello World</p>
)
```


### Configuration

The `defs.ini` may contain global definitions.


### Building

```console
./build.sh
```


## Caveats

- The C preprocessor interprets tokens like `,` (macro argument separator) such that you have to
  think of a work around to include the comma in the build file.
- Templates have to use a lot of backslashes (`\`) for macros to continue on the next line.
- Templates do not look clean at all.

... and much more ...

