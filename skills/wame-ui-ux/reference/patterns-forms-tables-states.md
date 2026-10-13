# Patterns — forms, tables, filters, states, feedback

## Contents
- Forms
- Validation and errors
- Tables and lists
- Filters and search
- States
- Feedback and notifications
- Destructive and bulk actions
- Navigation and reachability

## Forms

- One column. Two columns only for short, tightly related pairs (from / to, first / last name).
- Group related fields under a short heading; order groups by the user's mental model, not the
  table schema. Put the decision-making fields first.
- Label above the field, always visible; placeholder is an example, never the label.
- Help text under the field when the user must decide something ("Used on the invoice header").
- Mark the minority: if most fields are required, mark the optional ones, and the other way round.
- Defaults that are right for most users; prefill what the system already knows (3.3.7).
- Input type matches the data: date picker for dates, select for 2–7 fixed options, radios
  when all options should be visible, autocomplete for long lists, `autocomplete` attributes.
- Units and formats inside or next to the field (`€`, `m²`, `kWh`), with the locale's decimal
  separator.
- Long forms: sections with a summary, or a wizard only when later steps depend on earlier ones.
- The primary button says what happens ("Create contract"); place it where the eye ends.

## Validation and errors

- Validate on blur or submit, not on every keystroke; re-validate on input once a field has an error.
- Message next to the field, in text, saying how to fix it ("Enter a date after 1 May 2026").
- On submit with errors: summary at the top with links to each field, focus moved to it.
- Never clear what the user typed because of an error.
- Server errors in plain language with a next step; keep a reference id for support.

## Tables and lists

- Identifying column first (name, number), then what the user scans for, then the rest.
  About 7 columns on a laptop; move the rest to detail or optional columns.
- Numbers right-aligned with tabular figures and the same decimals; text left-aligned;
  dates in one format.
- Status as a short label with colour, not colour alone.
- Sort by what users need first (most recent, most urgent), and show the sort.
- Row actions: the common one visible, the rest in a menu; bulk actions appear on selection.
- Long text truncates with the full value on hover or in detail — never wraps a row to five lines.
- Pagination or virtual scrolling for large sets; show the total.
- On narrow screens: a list of cards with the 2–3 key fields, or horizontal scroll inside the table.

## Filters and search

- Search the fields users actually type (name, number, address), accent-insensitive.
- 3–5 visible filters for the common cases; the rest under "More filters".
- Active filters visible as removable chips, with "Clear all"; result count updates.
- Remember filters per user where the list is used daily.
- An empty result says which filters caused it and offers to clear them.

## States

| State | Design it as |
|---|---|
| Empty (first use) | Why it is empty + the first action ("Add the first meter") |
| Empty (filtered) | What filtered it out + "Clear filters" |
| Loading | Skeleton of the real layout for > 1 s; keep the old data while refreshing |
| Partial | What is missing and why; do not show zero for unknown — "no reading" is not `0` |
| Error | What failed, what still works, retry; never a blank screen |
| Success | Confirm in place or with a toast; show the result |
| No permission | Hide what the user can never do; explain what they cannot do right now |
| Offline (mobile) | What works offline, what will sync, last sync time |

## Feedback and notifications

- Inline feedback for the thing just changed; toast for background results; banner for a
  state that persists (read-only mode, expired licence).
- Toasts disappear only if they contain no action and no error; errors stay until dismissed.
- Announce status messages to assistive tech without moving focus (4.1.3).
- Notifications are for events the user must act on; everything else is a log.

## Destructive and bulk actions

- Prefer undo (soft delete + "Undo" in the toast) for reversible actions.
- Confirm the irreversible: name the object and count, state the consequence, and use a
  button labelled with the verb ("Delete 12 readings"), not "OK".
- Bulk actions show how many items they affect before running and a result summary after.

## Navigation and reachability

- Every new screen is reachable by clicking: a menu entry or a link from its parent object,
  plus links from related objects. A screen that only exists as a URL does not exist.
- Breadcrumbs or a clear back path for anything deeper than two levels.
- The current location is always visible (active menu item, page title).
