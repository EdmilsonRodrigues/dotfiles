#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_js="${repo_root}/firefox/user.js"
marker="dotfiles firefox/meet-screencast"

if [[ ! -f "${source_js}" ]]; then
  echo "Missing ${source_js}" >&2
  exit 1
fi

install_for_base() {
  local base="$1"
  local profiles_ini="${base}/profiles.ini"

  [[ -f "${profiles_ini}" ]] || return 0

  local profile_path=""
  local section=""
  local path=""
  local is_default=0
  local fallback_path=""

  while IFS= read -r line || [[ -n "${line}" ]]; do
    if [[ "${line}" == \[*] ]]; then
      if [[ "${section}" =~ ^Profile[0-9]+$ ]] && [[ -n "${path}" ]]; then
        [[ -z "${fallback_path}" ]] && fallback_path="${path}"
        if [[ "${is_default}" -eq 1 ]]; then
          profile_path="${path}"
        fi
      fi
      section="${line#[}"
      section="${section%]}"
      path=""
      is_default=0
      continue
    fi
    case "${line}" in
      Path=*) path="${line#Path=}" ;;
      Default=1*) is_default=1 ;;
    esac
  done < "${profiles_ini}"

  if [[ -z "${profile_path}" ]]; then
    profile_path="${fallback_path}"
  fi
  [[ -n "${profile_path}" ]] || return 0

  local dest="${base}/${profile_path}/user.js"
  mkdir -p "$(dirname "${dest}")"

  if [[ -f "${dest}" ]] && grep -q "${marker}" "${dest}"; then
    local tmp
    tmp="$(mktemp)"
    awk -v marker="${marker}" '
      BEGIN { skip = 0 }
      $0 ~ marker { skip = 1; next }
      skip && /^user_pref\(/ { next }
      skip && /^$/ { skip = 0; next }
      { print }
    ' "${dest}" > "${tmp}"
    mv "${tmp}" "${dest}"
  fi

  {
    echo "// ${marker}"
    cat "${source_js}" | grep -v '^// dotfiles firefox/meet-screencast'
  } >> "${dest}"

  echo "Updated ${dest}"
}

install_for_base "${HOME}/snap/firefox/common/.mozilla/firefox"
install_for_base "${HOME}/.mozilla/firefox"
