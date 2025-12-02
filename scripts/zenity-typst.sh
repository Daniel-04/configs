#!/usr/bin/env sh

equation=$(zenity --entry --text="Enter a Typst equation:" --title="Typst equation")

if [ -z "$equation" ]; then
    exit 1
fi

tmp_typst="/tmp/equation.typst"

cat >"$tmp_typst" <<EOF
#set page(width: auto, height: auto, margin: 10pt)
$ $equation $
EOF

error=$(typst compile "$tmp_typst" --format svg --open 2>&1 >/dev/null)

if [ $? -ne 0 ]; then
    zenity --error --text="$error" --no-markup
fi
