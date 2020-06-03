#!/usr/bin/env bash

# check for chicken
type csc &> /dev/null || {
    echo 'error : install chicken first' >&2
    exit 1
}

declare -A array

# build list of files to compile
for src in src/*.scm; {
    bin=${src##*/}
    bin=bin/${bin/%.scm}

    [[ -e $bin ]] && {
        {
            read -r a
            read -r b
        } < \
            <(stat -c '%Y' -- "$src" "$bin")

        ((a > b)) || continue
    }

    array[$src]=$bin
}

mkdir -p bin

for src in "${!array[@]}"; {
    set -x
    csc -O5 "$src" -o "${array[$src]}"
    set +x
} |&
    while IFS= read -r line; do
        [[ $line =~ ^\++\ ([^'set'].*) ]] &&
            printf '%s\n' "${BASH_REMATCH[1]}"
    done
