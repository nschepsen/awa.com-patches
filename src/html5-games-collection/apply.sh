#!/usr/bin/env bash
set -euo pipefail

# This script applies the patches to the original source code.

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" && pwd)"

usage() {
    printf 'Usage: %s <game-id>\n\n' "$0"
    printf '  Available GAMES:\n\n'
    find "$ROOT" -mindepth 1 -maxdepth 1 -type d ! -name build -printf '  » %f\n'
    printf '\nPatches are published for educational purposes only!\n'
    exit 1
}

if (( $# != 1 )); then
    usage
fi

GAME="$1"

if [[ ! -d "$ROOT/$GAME" ]]; then
    usage
fi

BUILD_DIR="$ROOT/build"

rm -rf -- "$BUILD_DIR" # Cleanup
mkdir -p -- "$BUILD_DIR"

MANIFEST="$ROOT/$GAME/manifest.tsv"

if [[ ! -f "$MANIFEST" ]]; then
    printf 'Missing manifest: %s\n' "$MANIFEST" >&2
    exit 1
fi

printf "Applying patches to '%s'\n" "$GAME"

while IFS=$'\t' read -r REL_PATH URL EXPECTED_HASH PATCH_NAME || [[ -n "${REL_PATH:-}${URL:-}${EXPECTED_HASH:-}${PATCH_NAME:-}" ]]; do
    REL_PATH="${REL_PATH%$'\r'}"
    URL="${URL%$'\r'}"
    EXPECTED_HASH="${EXPECTED_HASH%$'\r'}"
    PATCH_NAME="${PATCH_NAME%$'\r'}"

    [[ -z "${REL_PATH:-}" ]] && continue
    [[ "${REL_PATH}" == \#* ]] && continue
    [[ "${REL_PATH}" =~ ^[[:space:]]*# ]] && continue

    if [[ -z "${URL:-}" || -z "${EXPECTED_HASH:-}" || -z "${PATCH_NAME:-}" ]]; then
        printf 'Malformed manifest: %s\n' "$REL_PATH" >&2
        exit 1
    fi

    TARGET_PATH="$BUILD_DIR/$REL_PATH"
    PATCH_FILE="$ROOT/$GAME/$PATCH_NAME"

    if [[ ! -f "$PATCH_FILE" ]]; then
        printf 'Missing patch file: %s\n' "$PATCH_NAME" >&2
        exit 1
    fi

    mkdir -p -- "$(dirname -- "$TARGET_PATH")"
    printf ' » Downloading %s\n' "$URL"
    curl --fail --location --silent --show-error --compressed --output "$TARGET_PATH" -- "$URL"
    printf ' » Verifying HASH...\n'
    HASH="$(sha256sum -- "$TARGET_PATH" | cut -d' ' -f1)"
    if [[ "$HASH" != "$EXPECTED_HASH" ]]; then
        printf 'Hash mismatch for %s\n' "$TARGET_PATH" >&2
        exit 1
    fi

    printf ' » Applying %s to %s\n' "${PATCH_FILE##*/}" "${TARGET_PATH##*/}"

    git -C "${TARGET_PATH%/*}" apply --whitespace=nowarn --check -- "$PATCH_FILE"
    git -C "${TARGET_PATH%/*}" apply --whitespace=nowarn -- "$PATCH_FILE" # really apply the patch
    
    printf ' » Done\n\n'
done < "$MANIFEST"