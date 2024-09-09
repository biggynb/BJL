#!/bin/bash
bail() { echo "FATAL: $1"; exit 1; }
bash ./check.sh    || bail "Host Machine Has Unmet Dependencies.."
sh part.sh
