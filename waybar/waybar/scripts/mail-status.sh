#!/usr/bin/env bash
set -euo pipefail

app_name="Mail"
icon="${1:-?}"
mu_cmd="${MU:-$(command -v mu 2>/dev/null || true)}"
maildir="${MAILDIR:-${HOME}/Mail}"

print_template() {
    printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "${icon}" "$1" "$2"
}

count_unread_with_mu() {
    local output
    output="$("${mu_cmd}" find flag:unread -o plain 2>&1 || true)"
    if [[ -z "${output}" || "${output}" == *"no matches for search expression"* ]]; then
        printf "0\n"
        return 0
    fi
    printf "%s\n" "${output}" | wc -l | tr -d ' '
}

count_unread_in_maildir() {
    local new_count=0
    local cur_count=0

    new_count="$(find "${maildir}" -path '*/new/*' -type f 2>/dev/null | wc -l | tr -d ' ')"
    cur_count="$(
        find "${maildir}" -path '*/cur/*' -type f 2>/dev/null \
            | awk -F':2,' 'NF == 2 && $2 !~ /S/ { c++ } END { print c + 0 }'
    )"
    printf "%s\n" "$(( new_count + cur_count ))"
}

unread=0
if [[ -n "${mu_cmd}" && -d "${HOME}/.cache/mu" ]]; then
    unread="$(count_unread_with_mu)"
else
    unread="$(count_unread_in_maildir)"
fi

if (( unread > 0 )); then
    print_template "urgent" "${app_name}: ${unread} unread"
else
    print_template "open" "${app_name}: no unread mail"
fi
