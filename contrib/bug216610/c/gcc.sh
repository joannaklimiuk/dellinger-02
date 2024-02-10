#!/bin/bash
#
# The Go linker does not seem to know what to do with relative
# addressing of rodata.* offset from %rip. GCC likes to use this
# addressing mode on this architecture, so we quickly run into
# mis-computation when the relative addressing used in a .syso file of
# symbol located data is resolved to completely the wrong place by the
# Go (internal) linker.
#
# As a workaround for this, we can modify the assembly source code
# generated by GCC to not point at problematic '.rodata.*' sections,
# and place this data in the good old '.text' section where Go's
# linker can make sense of it.
#
# This script exists to generate a '.syso' file from some '*.c' files.
# It works by recognizing the '*.c' command line arguments and
# converting them into fixed-up '*.s' files. It then performs the
# compilation for the collection of the '*.s' files. Upon success, it
# purges the intermediate '*.s' files.
#
# The fragile aspect of this present script is which compiler
# arguments should be used for the compilation from '.c' -> '.s'
# files. What we do is accumulate arguments until we encounter our
# first '*.c' file and use those to perform the '.c' -> '.s'
# compilation. We build up a complete command line for gcc
# substituting '.s' files for '.c' files in the original command
# line. Then with the new command line assembled we invoke gcc with
# those. If that works, we remove all of the intermediate '.s' files.

GCC="${GCC:=gcc}"
setup=0
args=()
final=()
ses=()

for arg in "$@"; do
    if [[ "${arg##*.}" = "c" ]]; then
	setup=1
	s="${arg%.*}.s"
	"${GCC}" "${args[@]}" -S -o "${s}" "${arg}"
	sed -i -e 's/.*\.rodata\..*/\t.text/' "${s}"
	final+=("${s}")
	ses+=("${s}")
    else
	if [[ $setup -eq 0 ]]; then
	    args+=("${arg}")
	fi
	final+=("${arg}")
    fi
done

#echo final: "${final[@]}"
#echo args: "${args[@]}"
#echo ses: "${ses[@]}"

"${GCC}" "${final[@]}"
if [[ $? -ne 0 ]]; then
    echo "failed to compile"
    exit 1
fi
rm -f "${ses[@]}"