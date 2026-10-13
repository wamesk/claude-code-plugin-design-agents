# UX review — heuristics, severity, report

## Contents
- Inputs and scope
- First impression (5 seconds)
- Nielsen's 10 heuristics, as questions
- Task walk-through
- Severity
- Report template

## Inputs and scope

A review needs: what the screen is for (who / task / done), the stage (wireframe, mock-up,
built), and the evidence (PNG, Figma link, URL, diff). If the task is unknown, infer it from
the code and data and state the assumption at the top of the report — do not invent one silently.

Match the stage: on a wireframe judge flow, hierarchy, content and states, not colour; on a
built screen judge everything including accessibility and the AI look.

## First impression (5 seconds)

- What does the eye hit first? Is it the thing the task needs?
- Can you tell what the screen is for and what the primary action is?
- Squint: do the primary action and the key content still stand out?

## Nielsen's 10 heuristics, as questions

1. **Visibility of system status** — does every action give feedback in time (saving, saved,
   failed, n results)? Is progress visible for long work?
2. **Match with the real world** — the user's words, not the database's (`premise_type_id`
   vs "Type of space"); units, formats and order the domain uses.
3. **User control and freedom** — can the user cancel, go back, undo? Are exits obvious?
4. **Consistency and standards** — same names, positions and behaviours as the rest of the
   app and the platform (Nova, Filament, iOS/Android conventions).
5. **Error prevention** — sensible defaults, constraints, confirmation only for the
   irreversible, disabled states that say why.
6. **Recognition rather than recall** — options visible, previous choices remembered, no
   codes to memorise between screens.
7. **Flexibility and efficiency** — shortcuts for daily users (bulk actions, saved filters,
   keyboard), without burdening rare users.
8. **Aesthetic and minimalist design** — nothing that competes with the task; every element
   earns its place. Generic AI-look patterns count here (see `ai-design-tells.md`).
9. **Help users recognise, diagnose and recover from errors** — plain message, at the cause,
   with the fix.
10. **Help and documentation** — help text where a decision is made, not a manual somewhere else.

## Task walk-through

Do the main task step by step as the target user, with realistic data, and note every
hesitation: unclear label, missing information, an extra click, a dead end, a state with no
design (empty, error, no permission, 10 000 rows, a 60-character name).

## Severity

| Severity | Meaning |
|---|---|
| Critical | Blocks the task or loses data; accessibility blocker |
| Major | Task succeeds with real difficulty or frequent errors |
| Minor | Friction, inconsistency, polish |

Report at most 15 findings by default, highest severity first; merge duplicates. Every finding
names a place and a concrete fix — "improve the hierarchy" is not a finding.

## Report template

```markdown
## UX review — <screen / flow>

Context: <who>, <task>, <stage>. Evidence: <files / URL>. Assumptions: <if any>.

| # | Severity | Category | Where | Problem | Fix |
|---|---|---|---|---|---|
| 1 | Major | H1 Visibility of status | Import button | No feedback for 8 s after click | Show progress with the row count; disable the button while running |
| 2 | Minor | Generic / AI look | Dashboard header | Four KPI tiles with green arrows; none needs action | Replace with the list of overdue items |
| 3 | Critical | WCAG 2.1.1 Keyboard | Map | Markers reachable only by mouse | Add the list view with the same items |

Categories: H1–H10 (Nielsen), WCAG <SC>, Generic / AI look, Content.

### Works well
- …

### Fix first
1. …
2. …
3. …
```
