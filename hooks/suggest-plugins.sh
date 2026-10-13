#!/usr/bin/env bash
# SessionStart hook — shows the user at most one short tip per week per topic as a
# systemMessage (shown to the user, never added to the model context):
#   design   — Anthropic's design plugin (design-critique, accessibility-review, …) is missing;
#   platform — the project uses Laravel Nova, Filament or Ionic and the matching wame plugin
#              with the platform UI skill is missing.
# Set DESIGN_AGENTS_TIPS=0 (e.g. in settings.json "env") to silence it.
# Pure bash, no network, no jq, always exits 0.

cat >/dev/null 2>&1 || true

[ "${DESIGN_AGENTS_TIPS:-1}" = "0" ] && exit 0

CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
PLUGINS_DIR="$CONFIG_DIR/plugins"
INSTALLED="$PLUGINS_DIR/installed_plugins.json"
DATA_DIR="${CLAUDE_PLUGIN_DATA:-$PLUGINS_DIR/data/design-agents}"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
WEEK=604800
NOW=$(date +%s)

# Installed from a marketplace (installed_plugins.json key "name@marketplace")
# or synced from claude.ai (plugins/synced/<id>/<name> or <name>~<suffix>).
has_plugin() {
  grep -q "\"$1@" "$INSTALLED" 2>/dev/null && return 0
  local dir
  for dir in "$PLUGINS_DIR"/synced/*/"$1" "$PLUGINS_DIR"/synced/*/"$1"~*; do
    [ -d "$dir" ] && return 0
  done
  return 1
}

# A topic is due when its stamp file is missing or older than a week.
is_due() {
  local last
  last=$(cat "$DATA_DIR/tip-$1" 2>/dev/null)
  case "$last" in ''|*[!0-9]*) return 0 ;; esac
  [ $((NOW - last)) -ge $WEEK ]
}

mark_shown() {
  mkdir -p "$DATA_DIR" 2>/dev/null && echo "$NOW" > "$DATA_DIR/tip-$1" 2>/dev/null
}

TIPS=""
add_tip() {
  TIPS="${TIPS:+$TIPS }$1"
}

if ! has_plugin design && is_due design; then
  add_tip "Anthropic's design plugin adds design-critique, accessibility-review, ux-copy and design-handoff as a second opinion — run /plugin marketplace add anthropics/knowledge-work-plugins, then /plugin install design@knowledge-work-plugins."
  mark_shown design
fi

PLATFORM="" PLATFORM_PLUGIN=""
if grep -Eq '"name": ?"laravel/nova"' "$PROJECT_DIR/composer.lock" 2>/dev/null; then
  PLATFORM="Laravel Nova" PLATFORM_PLUGIN="laravel-nova-agents"
elif grep -Eq '"name": ?"filament/filament"' "$PROJECT_DIR/composer.lock" 2>/dev/null; then
  PLATFORM="Laravel Filament" PLATFORM_PLUGIN="laravel-filament-agents"
elif grep -Eq '"@ionic/(vue|react|angular|core)"' "$PROJECT_DIR/package.json" 2>/dev/null; then
  PLATFORM="Ionic" PLATFORM_PLUGIN="ionic-agents"
fi

if [ -n "$PLATFORM_PLUGIN" ] && ! has_plugin "$PLATFORM_PLUGIN" && is_due "$PLATFORM_PLUGIN"; then
  add_tip "This project uses $PLATFORM — /plugin install $PLATFORM_PLUGIN@wame adds its UI rules to the design agents."
  mark_shown "$PLATFORM_PLUGIN"
fi

[ -n "$TIPS" ] && printf '{"systemMessage":"design-agents tip: %s"}\n' "$TIPS"
exit 0
