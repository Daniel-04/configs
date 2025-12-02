#!/usr/bin/env sh

set -euo pipefail

: "${PYTHON:=python3}"
: "${VENV_PREFIX:=$(realpath env)}"

ACTIVATE_SCRIPT="$VENV_PREFIX/bin/activate"

if grep -q "### SCRIPT MODIFIED WITH VENV ACTIVATOR ###" "$ACTIVATE_SCRIPT" 2>/dev/null; then
    echo "Activation script already modified: $ACTIVATE_SCRIPT"
    exit 1
fi

a_input=""
if [ -n "${1-}" ]; then
    echo "Injecting activation."
    a_input="$(cat "$1")"
else
    echo "Usage:"
    printf "\t%s activation_script\n" "$0"
    printf "\t%s actication_script deactivation_script\n" "$0"
    exit 1
fi

d_input=""
if [ -n "${2-}" ]; then
    echo "Injecting deactivation."
    d_input="$(cat "$2")"
fi

$PYTHON -m venv "$VENV_PREFIX"

{
    echo ""
    echo "### SCRIPT MODIFIED WITH VENV ACTIVATOR ###"
    echo "# Begin injected activation hook"
    echo "$a_input"
    echo "# End injected activation hook"
} >>"$ACTIVATE_SCRIPT"

if [ -n "$d_input" ]; then
    tmpfile="$(mktemp)"
    sed "/^deactivate () {/a\\
    # Begin injected deactivation hook\\
    if [ -n \"\${VIRTUAL_ENV-}\" ]; then\\
    $(echo "$d_input" | sed "s/^/        /")\\
    fi\\
    # End injected deactivation hook
" "$ACTIVATE_SCRIPT" >"$tmpfile"
    mv "$tmpfile" "$ACTIVATE_SCRIPT"
fi

echo "$ACTIVATE_SCRIPT modified to:"
cat "$ACTIVATE_SCRIPT"
