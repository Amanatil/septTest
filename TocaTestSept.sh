#!/bin/sh
printf '\033c\033]0;%s\a' TocaTest
base_path="$(dirname "$(realpath "$0")")"
"$base_path/TocaTestSept.x86_64" "$@"
