#!/usr/bin/env bash
set -euo pipefail

clone=false
with_pgo=false

while [ $# -gt 0 ]; do
    case "$1" in
        -c) clone=true; shift;;
        --pgo) with_pgo=true; shift;;
    esac
done

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/shared.sh"

setup_environment

# clean out/ directory before build
rm -rf "${_src_dir}/out" || true

fetch_sources "$clone" "$with_pgo"
apply_patches
apply_domsub
titanium_substitution
titanium_apply_translations
titanium_version
titanium_resources
write_gn_args
gn_gen
build
