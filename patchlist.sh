#!/bin/sh --

list_patches_PATCHES () {
	cat -
}

list_patches_mq () {
	hg qapplied | sed -e 's/^/mq-/'
}

list_patches () {
	if [ -f .hg/patches/series ]; then
		list_patches_mq
	else
		list_patches_PATCHES
	fi
}

cat <<EOF
/* this is an autogenerated file.  edit patchlist.sh instead. */
#include "config.h"

#include <stdio.h>
#include <stdlib.h>

#include "mutt.h"

void mutt_print_patchlist (void)
{
EOF

list_patches | while read patch ; do
	echo "  puts (\"${patch}\");"
done

echo "}"
