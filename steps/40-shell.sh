#!/bin/bash -eu

mkdir -p ~/.bashrc.d

if ! grep --quiet bashrc.d ~/.bashrc; then
    >>~/.bashrc cat <<EOF

for file in ~/.bashrc.d/*; do
    source "\$file"
done
EOF
fi