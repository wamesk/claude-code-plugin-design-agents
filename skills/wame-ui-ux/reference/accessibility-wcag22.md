# Accessibility — WCAG 2.2 level AA

## Contents
- Criteria that decide most designs
- Full A + AA list by principle
- Test order
- Live page with chrome-devtools
- Report template

WCAG 2.2 (W3C Recommendation, October 2023) removed 4.1.1 Parsing and added 2.4.11, 2.5.7,
2.5.8, 3.2.6, 3.3.7 and 3.3.8 at A/AA. Level AA means every A and AA criterion.
Do not mix levels: 2.5.5 Target Size (Enhanced, 44×44) is **AAA**; the AA rule is 2.5.8.

## Criteria that decide most designs

| SC | Level | Rule of thumb |
|---|---|---|
| 1.4.3 Contrast (Minimum) | AA | Text 4.5:1; large text (≥ 24 px, or ≥ 18.66 px bold) 3:1 |
| 1.4.11 Non-text Contrast | AA | Input borders, icons that carry meaning, focus indicators, chart lines 3:1 against neighbours |
| 1.4.1 Use of Color | A | Status, errors, links in text: colour plus text, icon or underline |
| 1.3.1 Info and Relationships | A | Real headings, lists, tables with headers, labels tied to inputs, grouped radios |
| 2.1.1 Keyboard / 2.1.2 No Keyboard Trap | A | Everything works by keyboard; 2.1.2 fails only when focus cannot leave a component. Keeping focus inside an open dialog and closing it with Esc is ARIA APG practice, not 2.1.2 |
| 2.4.3 Focus Order / 2.4.7 Focus Visible | A / AA | Order follows the visual order; focus is always visible |
| 2.4.11 Focus Not Obscured (Minimum) | AA | Sticky headers, footers, toasts and cookie bars never fully cover the focused element |
| 2.5.7 Dragging Movements | AA | Every drag (sort, slider, map pan, kanban) has a single-pointer alternative |
| 2.5.8 Target Size (Minimum) | AA | Targets ≥ 24×24 CSS px, or spaced so a 24 px circle around each does not overlap another; inline links and native controls are exempt |
| 3.3.1 / 3.3.3 Error Identification / Suggestion | A / AA | Error in text, next to the field, with how to fix it |
| 3.3.7 Redundant Entry | A | Do not ask again for data given earlier in the same process; prefill or offer to select it |
| 3.3.8 Accessible Authentication (Minimum) | AA | No cognitive function test (remembering, transcribing, solving) without an alternative; allow paste and password managers. Recognising objects or own content is allowed at AA (forbidden only at 3.3.9, AAA) |
| 4.1.2 Name, Role, Value | A | Custom controls expose name, role and state (`aria-expanded`, `aria-pressed`, …) |
| 4.1.3 Status Messages | AA | Toasts, "saved", result counts announced without moving focus (`role="status"` / live region) |

Platform touch targets are bigger than 2.5.8: 44×44 pt (Apple HIG), 48×48 dp (Material).
Use those on mobile. `chrome-devtools-mcp:a11y-debugging` checks 48×48 (web.dev) — that is a
best practice: report a target under 24 px as a 2.5.8 failure, 24–47 px only as Minor.

## Full A + AA list by principle

**Perceivable** — 1.1.1 Non-text Content (A); 1.2.1–1.2.5 media alternatives, captions,
audio description (A/AA); 1.3.1 Info and Relationships (A); 1.3.2 Meaningful Sequence (A) ·
1.3.3 Sensory Characteristics (A); 1.3.4 Orientation (AA); 1.3.5 Identify Input Purpose (AA,
`autocomplete`); 1.4.1 Use of Color (A); 1.4.2 Audio Control (A); 1.4.3 Contrast (AA) ·
1.4.4 Resize Text 200 % (AA); 1.4.5 Images of Text (AA); 1.4.10 Reflow at 320 CSS px (AA) ·
1.4.11 Non-text Contrast (AA); 1.4.12 Text Spacing (AA); 1.4.13 Content on Hover or Focus (AA).

**Operable** — 2.1.1 Keyboard (A); 2.1.2 No Keyboard Trap (A); 2.1.4 Character Key
Shortcuts (A); 2.2.1 Timing Adjustable (A); 2.2.2 Pause, Stop, Hide (A); 2.3.1 Three
Flashes (A); 2.4.1 Bypass Blocks (A); 2.4.2 Page Titled (A); 2.4.3 Focus Order (A) ·
2.4.4 Link Purpose (A); 2.4.5 Multiple Ways (AA); 2.4.6 Headings and Labels (AA); 2.4.7
Focus Visible (AA); 2.4.11 Focus Not Obscured (AA); 2.5.1 Pointer Gestures (A); 2.5.2
Pointer Cancellation (A); 2.5.3 Label in Name (A); 2.5.4 Motion Actuation (A); 2.5.7
Dragging Movements (AA); 2.5.8 Target Size (Minimum) (AA).

**Understandable** — 3.1.1 Language of Page (A); 3.1.2 Language of Parts (AA); 3.2.1 On
Focus (A); 3.2.2 On Input (A); 3.2.3 Consistent Navigation (AA); 3.2.4 Consistent
Identification (AA); 3.2.6 Consistent Help (A); 3.3.1 Error Identification (A); 3.3.2
Labels or Instructions (A); 3.3.3 Error Suggestion (AA); 3.3.4 Error Prevention for legal,
financial and data changes (AA); 3.3.7 Redundant Entry (A); 3.3.8 Accessible
Authentication (AA).

**Robust** — 4.1.2 Name, Role, Value (A); 4.1.3 Status Messages (AA).

Good practice beyond AA that this method still expects: honour `prefers-reduced-motion`
(2.3.3 is AAA), visible labels rather than placeholders, one `h1` per page.

## Test order

1. **Automated scan** — Lighthouse or axe. It finds roughly a third of the problems; a clean
   scan proves little.
2. **Keyboard only** — Tab / Shift+Tab through the whole task; Enter, Space, Esc, arrow keys
   in menus, tabs and dialogs. Watch focus order, visibility, traps, and sticky bars covering focus.
3. **Screen reader** — VoiceOver (macOS/iOS), NVDA (Windows), TalkBack (Android): headings
   list, form labels, error announcements, status messages, dialog titles.
4. **Zoom and reflow** — 200 % zoom; 320 CSS px width without horizontal scrolling (data
   tables may scroll inside their own container).
5. **Contrast** — text, placeholder-free labels, borders, focus ring, disabled vs enabled,
   both light and dark mode.
6. **Motion and timing** — reduced-motion setting, auto-dismissing toasts, session timeouts.

## Live page with chrome-devtools

Load `chrome-devtools-mcp:a11y-debugging` and follow it, with the WCAG levels of this file.
Open the page with `new_page` and `background: true`, use only that `pageId`, and `close_page`
at the end — the MCP can be attached to the user's own Chrome. Then:

- `lighthouse_audit` for the scan; read only the failing audits.
- `list_console_messages` with issue types for Chrome's own findings (labels, ARIA, contrast).
- `take_snapshot` for the accessibility tree — the source of truth for names and roles.
- `press_key` Tab and a snapshot after each step to follow focus.
- `resize_page` to 320 px wide for reflow.
- `take_screenshot` for evidence in the report.

## Report template

```markdown
## Accessibility review — <screen> (WCAG 2.2 AA)

Scope: <URL / screenshot / files>, <light/dark>, <viewport>.
Result: <n> critical, <n> major, <n> minor.

| # | Severity | SC | Where | Problem | Fix |
|---|---|---|---|---|---|
| 1 | Critical | 2.1.1 Keyboard | Filter panel | Date picker opens only on click | Make the trigger a button; open on Enter/Space |

### Works well
- …

### Fix first
1. …
```

Severity (same scale as `heuristics-and-review.md`): **Critical** — a user cannot finish the
task (keyboard trap, unlabeled required field, contrast under 3:1 on body text). **Major** —
finishes with real difficulty. **Minor** — friction or a best-practice gap.
