---
name: wame-ui-ux
description: "UI/UX method for designing, wireframing and reviewing screens that are usable, accessible (WCAG 2.2 AA) and do not look AI-generated. Use for 'design this screen', 'wireframe', 'mockup', 'UX review', 'a11y audit', 'make it not look like AI', 'navrhni obrazovku', 'sprav wireframe', 'vylepši UI', 'skontroluj UX', 'je to prístupné'. For full deliverables delegate to the wireframer, ui-designer or ux-reviewer agents of design-agents."
allowed-tools:
  - Bash(${CLAUDE_SKILL_DIR}/scripts/wireframe-png.sh *)
  - Bash(cp ${CLAUDE_SKILL_DIR}/assets/wireframe-kit.css *)
  - Bash(mkdir -p *)
---

# WAME UI/UX method

The method every design agent follows. Platform rules (Nova, Filament, Ionic) live in their
own skills and win over this file where they disagree. Read a reference file only when the
step needs it.

## 1. Frame the job before drawing

Answer in three lines, from the brief, the code and the data — ask only what none of them answer:

1. **Who** uses the screen and how often (daily operator, monthly manager, first-time visitor).
2. **Task** — the one job the screen exists for, as a verb ("approve this month's readings").
3. **Done** — what the user sees when the job is finished.

Then list the screens of the flow and, for each, the states it needs from this list — the one
list every other file refers to:

**States:** default, empty (first use), empty (filtered), loading, partial, error, success,
no permission, offline (mobile). Mark a state "n/a" with a reason instead of
skipping it silently.

Use the real data shape from the project (models, migrations, API resources, seeds): real field
names, realistic lengths, the longest name, the empty value, the 10 000-row list. Never design
with "John Doe" or invented metrics.

## 2. Detect the platform

Decide by **where the screen lives**, not by what the repository contains — a Laravel Nova
project can also hold an Inertia or Blade page, a PWA or an Ionic app in a subfolder.

| The screen is | Platform | Load |
|---|---|---|
| A Nova resource, lens, dashboard, tool, card or field | Nova admin | `laravel-nova-agents:wame-nova-ui` |
| A Filament resource, page, widget or panel | Filament admin | `laravel-filament-agents:wame-filament-ui` |
| Inside an app root with `@ionic/*`, `ionic.config.json` or `capacitor.config.*` | Ionic mobile | `ionic-agents:wame-ionic-ui` |
| Anything else (Blade, Inertia, Vue, React, a PWA) | web | this skill and `frontend-design:frontend-design` |

Only when the location is unknown, fall back to `composer.lock` (`laravel/nova`,
`filament/filament`) and `package.json` (`@ionic/*`). A missing platform skill is not a
blocker: continue with this skill and name the plugin to install in one line at the end.

Admin panels keep their design system: be distinctive only inside its tokens, never by
restyling the panel. Mobile and web get a full visual direction (section 5).

## 3. Design rules

1. One primary action per screen; secondary actions look secondary; destructive actions are
   separated and never primary.
2. Content before chrome. The data the task needs is visible without scrolling or clicking.
3. Order follows the user's mental model, not the database column order.
4. Progressive disclosure: rare options behind "More", advanced filters collapsed.
5. Same thing, same name, same place — across the flow and the whole app.
6. Every state from section 1 designed; an empty state says why it is empty and offers the next step.
7. Errors say what happened and how to fix it, next to the field that caused them.
8. Reversible actions get undo, not a confirm dialog; only the irreversible is confirmed, with
   its consequence ("Delete 12 readings for May — this cannot be undone").
9. Feedback: under 0.1 s feels instant; up to 1 s needs no indicator; up to 10 s needs a
   spinner or progress; longer needs progress and a way to leave.
10. Never hard-code UI text: every label, help text and message goes through the project's
    translation layer.

Patterns for forms, tables, filters, states and notifications:
`reference/patterns-forms-tables-states.md`.

## 4. Accessibility floor (WCAG 2.2 AA)

Non-negotiable while designing, not only in review:

- Text contrast 4.5:1 (large text 3:1); UI components and focus indicators 3:1.
- Every control has a visible label and an accessible name; icon-only buttons get `aria-label`.
- Full keyboard path in visual order; visible focus that sticky bars never hide entirely
  (2.4.11 — fully visible is 2.4.12, AAA).
- Pointer targets at least 24×24 CSS px or spaced apart (2.5.8); mobile follows the platform
  (44 pt iOS, 48 dp Android) — that is a platform rule, not a WCAG AA failure.
- Colour is never the only signal (status = colour + text or icon).
- Dragging always has a single-pointer alternative (2.5.7); no re-typing data already given (3.3.7).
- Respect reduced motion; nothing flashes more than three times a second.

Full checklist, test order and report template: `reference/accessibility-wcag22.md`.

## 5. Visual direction without the AI look

Generic AI design is the default failure. Before any visual work:

1. Take colour, type and shape from what exists: logo, brand guide, the project's CSS tokens,
   the panel theme. Defaults are not a decision. If there is no brand, derive it from the
   domain and say so.
2. Sketch 2–3 distinct directions (template in `reference/ai-design-tells.md`).
3. Check each against `reference/ai-design-tells.md`; pick one and give the reason in one sentence.
4. Spend boldness in one place; keep everything else quiet.
5. Before finishing, run the AI-look audit on a screenshot and remove or justify every hit.

Grid, type scale, colour roles, dark mode and motion: `reference/visual-system.md`.

## 6. Wireframes

Low fidelity, grayscale, real content, annotated. Skill directory: `${CLAUDE_SKILL_DIR}`.
Copy the CSS kit with `cp`, write each screen as HTML with the kit's classes, and export with
the script. Never read or edit the kit, the template or the script:

```bash
mkdir -p docs/wireframes/<feature>
cp ${CLAUDE_SKILL_DIR}/assets/wireframe-kit.css docs/wireframes/<feature>/
${CLAUDE_SKILL_DIR}/scripts/wireframe-png.sh docs/wireframes/<feature>/01-<screen>.html
```

Use the project's own wireframe folder instead when one exists. Classes, annotations, sizes
and the export fallback: `reference/wireframing.md`.

## 7. Review and the browser

Heuristics, severity scale and the report template: `reference/heuristics-and-review.md`.
For a live page use `chrome-devtools-mcp:a11y-debugging`. Browser rule for every agent: open
your own tab with `new_page` and `background: true`, work only in that tab (`pageId`), and
`close_page` when done — the MCP can be attached to the user's own Chrome, so never select or
drive a tab you did not open. Never install browser tooling for a single run. If
`design:design-critique` or `design:accessibility-review` is installed, use it as a second opinion.

## Pre-finish checklist

- [ ] Who / task / done written down; flow and screen list exist.
- [ ] Every screen covers the states from section 1 (or marks them n/a with a reason).
- [ ] Real data shapes; longest value and empty value checked.
- [ ] One primary action per screen; irreversible actions confirmed with their consequence,
      reversible ones undoable.
- [ ] Accessibility floor met (section 4).
- [ ] Platform skill applied, or the missing plugin named.
- [ ] Visual work: 2–3 directions considered, choice explained, AI-look audit clean.
- [ ] No hard-coded UI text.

## Reference map

| File | Read when |
|---|---|
| `reference/patterns-forms-tables-states.md` | designing forms, lists, tables, filters, states, notifications |
| `reference/visual-system.md` | choosing spacing, type, colour, dark mode, motion |
| `reference/ai-design-tells.md` | before and after any visual work; every review |
| `reference/accessibility-wcag22.md` | accessibility audit or a doubt about a criterion |
| `reference/heuristics-and-review.md` | any UX review or critique |
| `reference/wireframing.md` | producing wireframes |
