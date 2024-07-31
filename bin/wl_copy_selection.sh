#!/bin/bash
# Use this as keyboard shortcut Alt+C on ubuntu to simluate macOS copy
echo -n "$(wl-paste --primary)"  | wl-copy
