# Wireframing

`SKILL_DIR` below is the skill directory whose resolved path SKILL.md section 6 shows.

## Contents
- What a wireframe is for
- Output folder and files
- Page skeleton
- Kit classes
- Annotations
- Export to PNG
- AI-look check on wireframes
- Checklist

## What a wireframe is for

It decides structure, content, flow and states before anyone argues about colour. Grayscale,
the kit's system font, no brand colours, no icons beyond simple glyphs. Real labels and real
data shapes — a wireframe with lorem ipsum hides every hard decision.

Draw at the fidelity the question needs: a flow question needs boxes and arrows; a layout
question needs the real fields, columns and actions. Default: mid-fidelity screens (real
content, kit components, no styling).

## Output folder and files

Use the project's existing wireframe folder if there is one (search for `*wireframe*` folders
and `*.html` mock-ups first); otherwise always `docs/wireframes/<feature>/`, never the
repository root.

```
docs/wireframes/<feature>/
  wireframe-kit.css          copied once from SKILL_DIR/assets/ with cp — never read it
  README.md                  who / task / done, flow, screen list, open questions
  01-<screen>.html           one file per screen; its states side by side as frames
  01-<screen>.png            exported by the script
```

`SKILL_DIR/assets/wireframe-template.html` is a complete example (desktop list +
mobile empty state + notes). Copy it as a starting point only when its layout fits; otherwise
write the screen from the skeleton below.

## Page skeleton

```html
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="wf-size" content="1820x1180">  <!-- canvas W x H for the PNG export -->
<title>Screen — state (wireframe)</title>
<link rel="stylesheet" href="wireframe-kit.css">
</head>
<body>
<div class="wf-frames">
  <div class="wf-frame">
    <div class="wf-state">Desktop — default</div>
    <div class="wf-page"> … </div>
  </div>
  <div class="wf-frame">
    <div class="wf-state">Desktop — empty</div>
    <div class="wf-page"> … </div>
  </div>
</div>
<section class="wf-notes"><h2>Notes</h2><ol><li>…</li></ol></section>
</body>
</html>
```

Size: a desktop frame is 1280×800 and a phone frame 390×844, with 32 px gaps and 32 px body
padding. Two desktop frames side by side need about `2660x1100`; one desktop + one phone
about `1820x1180`. Put several states under each other by using one `.wf-frames` per row.

## Kit classes

| Group | Classes |
|---|---|
| Frames | `wf-frames`, `wf-frame`, `wf-state` (frame caption), `wf-page` (1280×800 desktop), `wf-phone` (390×844) |
| Admin layout | `wf-shell` (sidebar + main grid), `wf-sidebar`, `wf-nav-group`, `wf-nav-item`, `wf-nav-item--active`, `wf-main`, `wf-topbar` |
| Layout helpers | `wf-row`, `wf-col`, `wf-between`, `wf-grow`, `wf-grid-2`, `wf-grid-3` |
| Text | `wf-h1`, `wf-h2`, `wf-text`, `wf-muted`, `wf-label`, `wf-help`, `wf-error`, `wf-num` (tabular, right-aligned), `wf-line` / `wf-line--short` / `wf-line--mid` (text placeholder bars — only where the text truly does not matter) |
| Controls | `wf-btn`, `wf-btn--primary`, `wf-btn--danger`, `wf-btn--ghost`, `wf-btn--icon`, `wf-field` (label + control + help), `wf-input`, `wf-input--error`, `wf-textarea` (add to `wf-input`), `wf-select`, `wf-check`, `wf-chip` (removable filter), `wf-badge`, `wf-badge--strong` |
| Messages and links | `wf-alert` (banner with a `strong` title), `wf-alert--error`, `wf-alert--success`, `wf-link` (underlined text link) |
| Containers | `wf-card`, `wf-tabs`, `wf-tab`, `wf-tab--active`, `wf-table` (plain `th`/`td`), `wf-empty`, `wf-img` (crossed placeholder), `wf-chart` |
| Overlays | `wf-backdrop` (inside a frame), `wf-modal`, `wf-toast`, `wf-sheet` (mobile bottom sheet) |
| Mobile | `wf-statusbar`, `wf-navbar` (large title + search), `wf-content`, `wf-list`, `wf-list-item`, `wf-tabbar` with `span` items and `wf-tab--active` |
| Notes | `wf-note` with `data-n="1"` (numbered marker), `wf-note--pin` (absolutely positioned marker; set `left`/`top`), `wf-notes` (numbered list under the frames) |

Never read or edit `wireframe-kit.css`, the template or the export script — the class list
above is all you need. A component the kit lacks goes into a short `<style>` block in the
screen's own HTML, with an `x-` class prefix.

Primary vs secondary vs destructive is shown by `wf-btn--primary` (filled), `wf-btn` (outlined)
and `wf-btn--danger` (thick outline). Status is a text badge, never colour.

## Annotations

- Number every decision a developer or the client could get wrong; explain it in `wf-notes`
  in one sentence each: behaviour, rule, source of the data, reachability.
- Always note: how the screen is reached (menu entry, parent tab, link), what each state
  shows, what happens on the primary action, validation rules, permissions.
- Open questions go into `README.md`, not into the picture.

## Export to PNG

```bash
SKILL_DIR/scripts/wireframe-png.sh docs/wireframes/<feature>/01-<screen>.html
```

The script prints the PNG path. It uses headless Chrome with a throw-away profile, so it never
touches the user's browser. Exit 2 (no Chrome) or 3 (Chrome wrote nothing): open
`file://<abs path>` with the chrome-devtools MCP — `new_page` with `background: true`, then
`take_screenshot` with `fullPage: true` and `filePath` set to the PNG path, then `close_page`.
Look at every PNG before handing it over — clipped frames or notes mean the `wf-size` is too
small; raise it and export again.

## AI-look check on wireframes

Wireframes have no colour or type yet, and the kit itself is grayscale by design. Check only
the Layout, Dashboards and Content sections of `ai-design-tells.md` — for example a reflex
KPI-tile row, three identical cards, or invented data.

## Checklist

- [ ] README with who / task / done, flow, screen list, open questions.
- [ ] Every screen shows the states listed in SKILL.md section 1, or marks them n/a with a reason.
- [ ] Real labels and data shapes, including the longest value and an empty value.
- [ ] Reachability annotated for every new screen.
- [ ] PNG exported and checked; nothing clipped.
