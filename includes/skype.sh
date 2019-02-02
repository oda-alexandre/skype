#!/bin/bash

set -e

exec /usr/share/skypeforlinux/skypeforlinux --executed-from="$PWD" --pid="$$" "$@"
