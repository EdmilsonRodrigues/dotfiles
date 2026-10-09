#!/usr/bin/env bash
set -euo pipefail

app_name="Slack"
icon="${1:-?}"

JQ_UNREADS_INFO='.webapp.teams[].unreads'
SLACK_UNREADS='unreads'
SLACK_IMPORTANTS='unreadHighlights'
SLACK_INFO="${HOME}/.var/app/com.slack.Slack/config/Slack/storage/root-state.json"

print_template() {
    printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "${icon}" "${1}" "${2}"
}

# 1. Check if Slack process is running
if ! pgrep -i -x "slack" >/dev/null 2>&1; then
    print_template "closed" "${app_name} is closed"
    exit 0
fi

# 2. Check if the JSON storage file exists
if [[ ! -f "${SLACK_INFO}" ]]; then
    print_template "open" "${app_name} is open"
    exit 0
fi

# 3. Sum up total unreads across all teams
unreads=$(jq -r "[${JQ_UNREADS_INFO}.${SLACK_UNREADS}] | add // 0" "${SLACK_INFO}" 2>/dev/null || echo 0)

if (( unreads == 0 )); then
    print_template "open" "${app_name} is open"
    exit 0
fi

# 4. Sum up urgent/highlight unreads across all teams
importants=$(jq -r "[${JQ_UNREADS_INFO}.${SLACK_IMPORTANTS}] | add // 0" "${SLACK_INFO}" 2>/dev/null || echo 0)

if (( importants > 0 )); then
    print_template "urgent" "${app_name} has urgent message"
else
    print_template "unread" "${app_name} has unread message"
fi

exit 0
