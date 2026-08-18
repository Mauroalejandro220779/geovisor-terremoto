#!/bin/sh
# PostToolUse hook (Edit|Write): warns if index.html content changed
# without SITE_LAST_UPDATED being bumped in the same diff.

payload=$(cat)

file_path=$(printf '%s' "$payload" \
  | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' \
  | head -1 \
  | sed -E 's/.*"file_path"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/')

case "$file_path" in
  *index.html) ;;
  *) exit 0 ;;
esac

repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$repo_root" || exit 0

diff=$(git diff -- index.html 2>/dev/null)
[ -z "$diff" ] && exit 0

changed=$(printf '%s\n' "$diff" | grep -E '^[+-][^+-]')
[ -z "$changed" ] && exit 0

touched=$(printf '%s\n' "$changed" | grep -c 'SITE_LAST_UPDATED')
other=$(printf '%s\n' "$changed" | grep -v 'SITE_LAST_UPDATED' | grep -c '.')

if [ "$other" -gt 0 ] && [ "$touched" -eq 0 ]; then
  printf '{"decision":"block","reason":"index.html content changed but SITE_LAST_UPDATED was not bumped. Update the SITE_LAST_UPDATED constant near the data array before finishing (project rule: content changes must bump the timestamp; pure infra changes do not count)."}\n'
fi

exit 0
