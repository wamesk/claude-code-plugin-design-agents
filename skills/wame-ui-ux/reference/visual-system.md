# Visual system — spacing, type, colour, dark mode, motion

## Contents
- Start from what exists
- Spacing and grid
- Type
- Colour roles and contrast
- Dark mode
- Shape and elevation
- Icons and imagery
- Motion
- Responsive

## Start from what exists

Read the project's tokens before inventing any: Tailwind config or `@theme`, CSS custom
properties, the Nova / Filament / Ionic theme, the logo and brand guide. Extend that system;
a second, parallel system is the most common way custom screens end up looking foreign.

## Spacing and grid

- One spacing scale on a 4 px base: 4, 8, 12, 16, 24, 32, 48, 64. Mobile layouts on 8 pt.
- Space shows grouping: less space inside a group than between groups. If you need a border
  to show a group, the spacing is probably wrong.
- Align to a few strong edges; mixed left edges look accidental.
- Data-dense admin screens: compact rows (32–40 px) with generous section gaps. Marketing and
  mobile: more air, larger targets.

## Type

- One family is usually enough for product UI; two only when display and text roles really differ.
- A deliberate, limited scale, e.g. 12 / 14 / 16 / 20 / 24 / 32 — no sizes outside it. Product UI body
  14–16 px; never below 12 px for anything users must read.
- Line length 45–80 characters for prose; line height 1.4–1.6 for text, tighter for headings.
- Tabular (monospaced) figures for numbers in tables, money and readings.
- Weight and size make hierarchy; colour is the last resort. Sentence case everywhere.

## Colour roles and contrast

Define roles, not just colours:

| Role | Use |
|---|---|
| Surface / surface-raised | backgrounds, cards, dialogs |
| Text / text-muted | body and secondary text (muted still ≥ 4.5:1) |
| Border | dividers, inputs (≥ 3:1 where it identifies a control) |
| Primary | the primary action, current selection, focus — nothing decorative |
| Success / warning / danger / info | states only, always with text or icon |
| Focus ring | ≥ 3:1 against both the control and the background |

- Neutrals carry 80–90 % of the screen; the primary colour is rare, so it means something.
- Tint neutrals slightly toward the brand hue instead of pure grey.
- Check every text/background pair in both themes; check disabled vs enabled is still distinguishable.

## Dark mode

- Not an inversion: raise surfaces with lighter greys, not shadows; avoid pure black
  (`#000`) and pure white text on it — use about `#121212`–`#1E1E1E` and off-white text.
- Desaturate and lighten brand colours so they do not vibrate; re-check contrast.
- Images and charts need their own dark variants or neutral backgrounds.
- Follow the system setting by default; offer a manual switch only where the platform does.

## Shape and elevation

- One radius scale (for example 4 / 8 / 12) used by component size, not "as round as possible".
- Elevation only for things that float above the page: menus, popovers, dialogs, sticky bars.
  Static cards need a border or a background step, not a shadow.

## Icons and imagery

- One icon set, one stroke weight, one size per context.
- Icons accompany labels; icon-only only for universal actions (close, search, more) and
  always with an accessible name.
- Images show the product's real world (the building, the meter, the document), not stock
  abstractions.

## Motion

- Motion explains a change: where something came from, where it went, what changed.
  150–250 ms for UI transitions, ease-out on enter, ease-in on exit.
- No motion on page load for its own sake; no scroll-triggered fade-ins on every section.
- Honour `prefers-reduced-motion`: replace movement with a fade or nothing.

## Responsive

- Design the smallest and the largest real viewport first (375 px phone, 1280–1440 px laptop),
  then the breakpoints between.
- Reflow at 320 CSS px without horizontal page scrolling (1.4.10); tables may scroll inside
  their container.
- Touch: targets at least 44 pt / 48 dp, primary actions within thumb reach on phones.
