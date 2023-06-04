#!/bin/bash -e

if [ -f "$MANUAL" ]; then
  xed "$MANUAL" 2>&1 >/dev/null &
fi