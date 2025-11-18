Create scripts/buzzflow_morning.sh and paste:

#!/usr/bin/env bash
#
# BuzzFlow Morning – ONE-SHOT E2E LOCKED IN — BuzzFlow Certified™
# Simple Bash script to print the configured BuzzFlow Morning routine.
#

CONFIG_FILE="config/routine.yml"

divider() {
  printf '%*s\n' "${COLUMNS:-60}" '' | tr ' ' '-'
}

header() {
  divider
  echo "🌅 BuzzFlow Morning – FDF Certified™"
  divider
  echo
}

check_config() {
  if [ ! -f "$CONFIG_FILE" ]; then
    echo "⚠️  Config file not found at $CONFIG_FILE"
    echo "    Create it from config/routine.yml.example or pull latest from GitHub."
    exit 1
  fi
}

print_affirmations() {
  echo "✨ Affirmations"
  divider
  # lightweight parse: just grep lines that start with a dash under affirmations
  awk '
    $1 == "affirmations:" {in_affirm=1; next}
    in_affirm && $1 ~ /^-/ {sub(/^- */, "", $0); print "• " $0}
    in_affirm && NF == 0 {in_affirm=0}
  ' "$CONFIG_FILE"
  echo
}

print_blocks() {
  echo "🧩 Today'\''s Blocks"
  divider
  awk '
    $1 == "-" && /id:/ {block_id=$2; next}
    /label:/ {sub(/label:[ ]*/, ""); label=$0}
    /action:/ {
      sub(/action:[ ]*/, ""); action=$0
      printf "▪ %s\n   → %s\n\n", label, action
    }
  ' "$CONFIG_FILE"
}

footer() {
  divider
  echo "✅ BuzzFlow Morning loaded. Breathe in, lock in, and move with intention."
  echo
}

main() {
  header
  check_config
  print_affirmations
  print_blocks
  footer
}

main "$@"

> After saving:
chmod +x scripts/buzzflow_morning.sh




---
