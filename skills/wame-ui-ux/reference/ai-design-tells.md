# AI design tells — what makes a screen look generated

## Contents
- Why this list exists
- Colour
- Type and copy
- Layout
- Details and motion
- Dashboards and admin panels
- Mobile
- Content
- The directions step
- The audit

## Why this list exists

A model left to its defaults converges on the same few looks. Users now recognise them, and a
screen that looks generated reads as unconsidered. Every item below is a default, not a
mistake — it is allowed only when the brief, the brand or the data asks for it, and then the
reason is stated. "It looks modern" is not a reason.

## Colour

- Purple-to-blue or violet-to-pink gradients; gradient text in headlines.
- Glowing blobs, blurred orbs or mesh gradients behind content.
- Glassmorphism on everything (frosted cards, frosted nav, frosted modals).
- Cream or off-white background with a terracotta / burnt-orange accent and a serif display
  face — the house look of Claude-made pages.
- Near-black background with one acid accent (lime, neon green, electric cyan), often with
  monospace labels — the "terminal" look.
- Untouched framework palettes: Tailwind `indigo-600` / `violet-500` / `slate`, shadcn zinc
  with default radius, Ionic `#3880ff`, Bootstrap blue.
- Accent colour sprayed everywhere instead of reserved for the primary action and key state.

Instead: take colour from the brand and the domain; define roles (surface, text, muted,
primary, danger, success, warning, focus) and use the accent sparingly so it means something.

## Type and copy

- An eyebrow label above every heading: tiny ALL CAPS, wide tracking, often monospace
  ("FEATURES", "— 01 —", "HOW IT WORKS").
- One word of a headline in a different colour, italic serif or gradient.
- Joins with ` · `, arrows `→` after every link, em-dash-heavy marketing lines.
- Emoji as icons or bullets (✨ 🚀 ⚡ ✅).
- Words: seamless, effortless, unlock, elevate, supercharge, empower, revolutionise,
  "all-in-one", "at your fingertips", "built for the modern …".
- Title Case On Every Heading And Button.
- A single type family with no scale (everything 14–16 px, weight doing all the work), or two
  display faces fighting.

Instead: sentence case; the same name for an action through the whole flow; labels that say
what happens ("Approve 14 readings", not "Submit"); a deliberate scale (section in
`visual-system.md`).

## Layout

- Hero with a giant number plus a small label ("10× faster", "99.9 % uptime"), or a hero with
  a centred headline, sub-line and two buttons (filled + ghost) by reflex.
- Three or four identical cards in a row, each an icon in a rounded square, a bold title and
  two lines of grey text.
- Bento grids where the content is not of different sizes.
- Everything centred; every section the same width, padding and rhythm.
- Every section wrapped in a card; cards inside cards.
- Callouts as cards with a thick coloured left border (`border-l-4`).
- Alternating zig-zag image/text rows as the whole page structure.

Instead: let the content and the task shape the layout — a table where data is tabular, a
form where the job is input, asymmetric weight where one thing matters more.

## Details and motion

- `rounded-2xl` + `shadow-lg` + 1 px border on every element; `hover:scale-105` on cards.
- Pill badges everywhere; "New", "Beta", "Pro", "AI" tags with no product reason.
- A check-mark icon in front of every bullet.
- Fade-in-up on scroll for every section; shimmer or pulse on static content; parallax.
- Icons from one set placed next to every field, label and menu item "for balance".
- Decorative gradient borders and glow on focus.

Instead: one radius scale, elevation only where something floats (menus, dialogs), motion
that explains a change of state, icons only where they speed up recognition.

## Dashboards and admin panels

- The reflex dashboard: four KPI tiles with trend arrows and green/red percentages, then a
  line chart, then a "recent activity" table — whatever the user actually needs to do.
- KPIs with no comparison period, no unit, or a delta without meaning ("+12 %" of what?).
- Charts where a number or a sorted list answers the question better.
- Restyling a Nova or Filament panel (custom gradients, custom fonts, hero banners) so custom
  screens no longer match the rest of the admin.
- Tooltips on every field instead of a clear label and help text.

Instead: start from the decisions the user makes on the screen; show what needs action first
(what expired, what is missing, what is waiting, who owes money); keep the panel's own look.

## Mobile

- Floating, blurred, pill-shaped tab bar with a giant central FAB.
- Gradient app headers; full-bleed gradient splash with a centred logo and tagline.
- Default Ionic look untouched (blue primary, default `md` or `ios` styling, default fonts).
- Cards everywhere instead of lists; huge rounded corners on everything.
- Onboarding carousel of three illustrated slides before the user can do anything.

Instead: platform-correct navigation, lists for lists, one brand colour used with intent,
native-feeling motion and haptics, content first.

## Content

- "John Doe", "Acme Inc.", "Lorem ipsum", "Jane Smith, CEO" testimonials.
- Invented metrics, logos of famous customers, fake star ratings.
- Perfectly even data (every name 8 characters, every number round).

Instead: the project's real data shapes — the longest name, the empty field, the zero, the
negative balance, the 10 000-row list.

## The directions step

Before visual work, sketch 2–3 directions that differ in more than colour:

| Field | Example |
|---|---|
| Name | "Ledger" |
| Colours (4–6 hex) with roles | `#1F2A30` text, `#F4F2EE` surface, `#2F6F62` primary, … |
| Type pairing and scale | IBM Plex Sans 14/16/20/28, tabular numerals |
| Layout idea | dense two-pane list + detail, no cards |
| Signature element | month strip that shows missing readings as gaps |

Check each against this file. Pick one; say why in one sentence that refers to the user,
the task or the brand — not to taste.

## The audit

Run it on a screenshot before calling the work done (on a wireframe only the Layout,
Dashboards and Content sections apply):

1. Go through every section above; list each tell you see with its location.
2. For each hit: remove it, or write the reason from the brief/brand/data that justifies it.
3. Squint test: blur the screenshot — the primary action and the most important content must
   still stand out; nothing decorative should.
4. Swap test: if the logo were replaced by a competitor's, would the screen still fit them
   equally well? Then nothing in it comes from this product — revisit the signature element.

A reviewer reports unjustified hits under the category **Generic / AI look**.
