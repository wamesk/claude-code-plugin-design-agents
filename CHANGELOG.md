# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-10-13

First release. Design work had no home of its own: `frontend-design` covers the look of web
pages, the `design` plugin reviews finished designs, and neither knows admin panels, mobile
apps or the patterns that make a screen look generated.

### Added

- **`wireframer` agent.** Brief to flow, screen list and every state; annotated grayscale HTML
  wireframes exported to PNG; never edits application code.
- **`ui-designer` agent** (`effort: high`). Derives the look from the brand and the data,
  sketches two or three directions, picks one with a reason, builds it and audits it for
  generic AI patterns, accessibility and states.
- **`ux-reviewer` agent.** Read-only review against Nielsen's heuristics, WCAG 2.2 AA, the
  platform's conventions and the AI-look list, as a findings table with concrete fixes.
- **`wame-ui-ux` skill.** The shared method with six references: heuristics and review,
  WCAG 2.2 AA, forms / tables / states, visual system, wireframing, and AI design tells.
  Includes a grayscale wireframe CSS kit and a headless-Chrome PNG export script.
- **Platform skills from sibling plugins.** The agents load `wame-nova-ui`
  (laravel-nova-agents), `wame-filament-ui` (laravel-filament-agents) and `wame-ionic-ui`
  (ionic-agents) when installed, and name the missing plugin when not.
- **Dependencies.** Installing the plugin also installs `frontend-design` and
  `chrome-devtools-mcp` from `claude-plugins-official`.
- **Tips at session start.** At most once a week per topic, shown only to the user (never added
  to the model context): Anthropic's `design` plugin is missing, or the project uses Nova,
  Filament or Ionic without the matching platform plugin. `DESIGN_AGENTS_TIPS=0` turns them off.
- **Work mode.** All three agents follow the `work-mode` plugin: fast mode defers the checks and
  records them; live visual work stays in the main conversation.
