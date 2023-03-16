#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

LIST_FILE="uploaded-files/$UPLOADER_TYPE.sha256sum"
SOURCE_DIR="package-sources"

mkdir -p "uploaded-files"

if [ "$(ls -A "$SOURCE_DIR"/* | wc -l)" -gt "0" ]; then
	for i in "$SOURCE_DIR"/*; do
		FILE_HASH_RESULT="$(sha256sum "$i")"
		if [ -f "$LIST_FILE" ]; then
			sed -i "/${i//\//\\/}/d" "$LIST_FILE"
			echo -e "$FILE_HASH_RESULT" >> "$LIST_FILE"
		else
			echo -e "$FILE_HASH_RESULT" > "$LIST_FILE"
		fi
	done
else
	echo -e "No files found."
	exit 1
fi

rm -rf "$SOURCE_DIR"

exit 0
