#!/bin/bash
# Usage: ./gen_random.sh <length>
LEN=${1:-8}
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$LEN" | head -n 1
