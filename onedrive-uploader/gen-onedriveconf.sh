#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

cat > "$PWD/uploader.json" <<EOF
{
  "RefreshToken": "$ODRS_REFRESH_TOKEN",
  "RefreshInterval": 1500,
  "ThreadNum": "10",
  "BlockSize": "10",
  "SigleFile": "100",
  "MainLand": false,
  "MSAccount": false
}
EOF

exit 0
