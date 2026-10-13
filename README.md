# design-agents

Wireframes, UI design and UX/accessibility review that do not look AI-generated — for Claude
Code, by [WAME](https://wame.sk). Part of the `wame` marketplace.

## Installation

```
/plugin marketplace add wamesk/claude-code
/plugin install design-agents@wame
```

## Installed automatically

Installing `design-agents` also installs these plugins (declared as `dependencies`). Both come
from `claude-plugins-official`, the marketplace Claude Code adds by default.

| Plugin | What it adds |
|---|---|
| `frontend-design` | The `frontend-design` skill: aesthetic direction, typography and avoiding templated looks for web UI. `ui-designer` uses it for web and Ionic screens. |
| `chrome-devtools-mcp` | The Chrome DevTools MCP server and the `a11y-debugging` skill (Lighthouse, accessibility tree, keyboard and contrast checks on a live page). `ux-reviewer` uses it for live URLs; the agents use it for screenshots. |

## Platform skills

The agents decide the platform by where the screen lives (a Nova project can also hold an
Inertia page or an Ionic app in a subfolder) and load its UI skill when the plugin is
installed. Without it they still work with the general method and name the plugin to install.

| The screen is | Plugin | Skill |
|---|---|---|
| A Nova resource, lens, dashboard, tool, card or field | `laravel-nova-agents` | `wame-nova-ui` |
| A Filament resource, page, widget or panel | `laravel-filament-agents` | `wame-filament-ui` |
| Inside an Ionic / Capacitor app | `ionic-agents` | `wame-ionic-ui` |

```
/plugin install laravel-nova-agents@wame
/plugin install laravel-filament-agents@wame
/plugin install ionic-agents@wame
```

## Recommended plugins

Anthropic's **`design`** plugin is a good second opinion. It is not a dependency: it lives in
another marketplace (`anthropics/knowledge-work-plugins`), and a dependency whose marketplace
is missing stops this plugin from loading at all. It also brings seven MCP connectors (Slack,
Figma, Linear, Asana, Atlassian, Notion, Intercom). When it is installed, the agents use it.

```
/plugin marketplace add anthropics/knowledge-work-plugins
/plugin install design@knowledge-work-plugins
```

| Skill in `design` | What it adds |
|---|---|
| `design-critique` | Structured feedback on usability, hierarchy and consistency from a screenshot or Figma link. |
| `accessibility-review` | A WCAG 2.1 AA audit template (contrast, keyboard, touch targets, screen reader). Our `wame-ui-ux` covers WCAG 2.2 AA. |
| `ux-copy` | Microcopy: buttons, error messages, empty states, confirmations. |
| `design-handoff` | Developer handoff specs: tokens, states, breakpoints, edge cases. |
| `design-system` | Auditing and extending a design system. |
| `user-research`, `research-synthesis` | Planning research and turning interviews or tickets into insights. |

Also useful: **`figma`** (draw in and read from Figma) and **`playground`** (interactive
single-file HTML explorers), both from `claude-plugins-official`.

## Agents

| Agent | Use it to |
|---|---|
| `wireframer` | Turn a brief into a flow, a screen list and annotated grayscale wireframes (HTML + PNG) with every state. Never edits application code. |
| `ui-designer` | Design and build real UI: two or three directions, one chosen with a reason, built in the project's own components, audited for generic AI patterns, accessibility and states. |
| `ux-reviewer` | Review a wireframe, screenshot, diff or live URL — heuristics, WCAG 2.2 AA, platform conventions, AI look — as a prioritised findings table. Does not edit files. |

## Skill

| Skill | What it holds |
|---|---|
| `wame-ui-ux` | The shared method: frame the job, detect the platform, design rules, accessibility floor, visual direction without the AI look, wireframing, review. References: heuristics and review, WCAG 2.2 AA, forms / tables / states, visual system, wireframing, AI design tells. Assets: a wireframe CSS kit and an example wireframe. Script: headless-Chrome PNG export. |

## Not AI-looking

`reference/ai-design-tells.md` lists the defaults that make a screen look generated — purple
gradients, cream and terracotta, eyebrow labels, three identical icon cards, KPI tile rows,
glass tab bars, emoji icons, invented metrics — and the process that replaces them: take the
look from the brand and the data, sketch two or three directions, pick one with a reason, and
audit the screenshots before calling the work done. `ux-reviewer` reports what it finds under
the category **Generic / AI look**.

## Tips at session start

A `SessionStart` hook shows at most one tip per week per topic: the `design` plugin is missing,
or the project uses Nova, Filament or Ionic without the matching platform plugin. Tips are a
`systemMessage` — shown to you, never added to the model's context. Turn them off with
`DESIGN_AGENTS_TIPS=0` in the `env` block of your settings.

## Browser

Agents open their own tab with `new_page` and `background: true`, work only in that tab and
close it when done — the Chrome DevTools MCP can be attached to your own browser, so they never
drive a tab they did not open. They never install browser tooling for a single run.

## Work mode

The agents follow the [`work-mode`](https://github.com/wamesk/claude-code-plugin-work-mode)
plugin. In fast mode they skip the checks (wireframe self-review, screenshots, AI-look audit,
UX review) and end with a `Deferred checks:` line; `/work-mode full` runs them later. Live,
approve-as-you-go visual work stays in the main conversation.

## Token budget

- One skill, so one description in the always-loaded skill list.
- Agents hold no code; they load `wame-ui-ux` and one platform skill only when they need them.
- References are read one at a time; the wireframe CSS kit is copied with `cp`, never read.

## License

MIT
