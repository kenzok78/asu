#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

DL_PATH="immortalwrt/dl"
LIST_FILE="uploaded-files/$UPLOADER_TYPE.sha256sum"
SOURCE_DIR="package-sources"

rm -rf "$SOURCE_DIR"
mkdir "$SOURCE_DIR"

mkdir -p "uploaded-files"

if [ "$(ls -A "$DL_PATH"/* | wc -l)" -gt "0" ]; then
	for i in "$DL_PATH"/*; do
		FILE_HASH="$(sha256sum "$i" | awk -F ' ' '{print $1}')"
		if [ -f "$LIST_FILE" ]; then
			FILE_CACHED_HASH="$(grep "$i" "$LIST_FILE" | awk -F ' ' '{print $1}')"
			if [ "$FILE_CACHED_HASH" != "$FILE_HASH" ]; then
				cp -fp "$i" "$SOURCE_DIR"/
				echo -e "Cached hash: $FILE_CACHED_HASH, now hash: $FILE_HASH"
				echo -e "Refresh uploaded file: ${i##*/}"
			# else
			# 	echo -e "Skipped uploaded file: ${i##*/}"
			fi
		else
			cp -fp "$i" "$SOURCE_DIR"/
		fi
	done
else
	echo -e "No files found."
	exit 1
fi
