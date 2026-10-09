#!/usr/bin/env bash
set -euo pipefail

app_name="Thunderbird"
icon="${1:-?}"
tb_base="${HOME}/snap/thunderbird/common/.thunderbird"
profiles_ini="${tb_base}/profiles.ini"

print_template() {
    printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$icon" "$1" "$2"
}

resolve_profile_dir() {
    local path=""
    local is_relative="1"

    [[ -f "${profiles_ini}" ]] || return 1

    while IFS='=' read -r key value; do
        case "$key" in
            IsRelative) is_relative="$value" ;;
            Path)       path="$value" ;;
        esac
    done <<EOF
    $(grep -E '^(IsRelative|Path|Default)=' "${profiles_ini}" | tr -d '\r')
EOF
    [[ -n "$path" ]] || return 1

    if [[ "$is_relative" == "1" ]]; then
        printf "%s\n" "${tb_base}/${path}"
    else
        printf "%s\n" "${path}"
    fi
}

count_unread_inbox_messages() {
    local profile_dir="$1"
    local db_path="${profile_dir}/global-messages-db.sqlite"
    local db_uri
    local unread

    [[ -f "${db_path}" ]] || return 1
    db_uri="file:${db_path}?mode=ro&immutable=1"

    unread="$(
        sqlite3 "${db_uri}" "
            SELECT COUNT(*)
            FROM messages m
            WHERE m.deleted = 0
              AND m.folderID IN (
                  SELECT id
                  FROM folderLocations
                  WHERE lower(folderURI) LIKE '%/inbox'
              )
              AND COALESCE(json_extract(m.jsonAttributes, '$.\"59\"'), 0) = 0;
        " 2>/dev/null || true
    )"

    [[ "${unread}" =~ ^[0-9]+$ ]] || return 1
    printf "%s\n" "${unread}"
}

# Closed state if Thunderbird process is not running.
if ! pgrep -f "thunderbird" >/dev/null 2>&1; then
    print_template "closed" "${app_name} is closed"
    exit 0
fi

profile_dir="$(resolve_profile_dir || true)"
if [[ -z "${profile_dir}" || ! -d "${profile_dir}" ]]; then
    print_template "open" "${app_name} is open"
    exit 0
fi

unread="$(count_unread_inbox_messages "${profile_dir}" || true)"
if [[ -z "${unread}" || ! "${unread}" =~ ^[0-9]+$ ]]; then
    print_template "open" "${app_name} is open"
    exit 0
fi

if (( unread > 0 )); then
    print_template "urgent" "${app_name} has ${unread} unread inbox messages"
else
    print_template "open" "${app_name} is open"
fi
