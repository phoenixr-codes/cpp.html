#!/usr/bin/env bash

set -e

DEFINITIONS_FILE=${DEFINITIONS_FILE:-defs.ini}
TEMPLATE_DIR=${TEMPLATE_DIR:-templates}
SOURCE_DIR=${SOURCE_DIR:-source}
BUILD_DIR=${BUILD_DIR:-build}

dbg() {
  printf "\033[32m>\033[0m %s\n" "$*"
  "$@"
}

main() {
  dbg mkdir -p "$BUILD_DIR"

  definitions=()
  while IFS= read -r line; do
    [ -z "$line" ] || [[ "$line" == ";"* ]] || [[ "$line" == "#"* ]] && continue
    definitions+=("-D $line")
  done < "$DEFINITIONS_FILE"

  find "$SOURCE_DIR" -type f | while IFS= read -r infile; do
    outfile="$BUILD_DIR/${infile#*/}"
    dbg cpp \
      -P \
      -undef \
      "${definitions[@]}" \
      -fextended-identifiers \
      -fdollars-in-identifiers \
      -I "$TEMPLATE_DIR" \
      "$infile" \
      -o "$outfile"
  done
}

main

