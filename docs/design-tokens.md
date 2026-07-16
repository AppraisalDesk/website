# Appraisal Desk Design Tokens

**What this is:** the visual system for appraisaldesk.com. Slim on purpose. Follow it exactly; where it's silent, choose the quieter option.

## The feel

The design should feel like the copy: honest, plain, confident, specific. This is a company whose whole pitch is "we publish the price and show the math," so the site should look like it has nothing to hide. Generous whitespace, disciplined type, no decoration doing double duty. If a visual element doesn't help the reader understand or decide, cut it.

## The signature element: the ledger

The one memorable thing on this site is the math, set in type like a receipt:

```
Typical AMC management fee        $150
Appraisal Desk, flat               $55
Yours, every order                 $95
```

All money and stats sitewide are set in **Geist Mono**. Headlines and body stay in Geist Sans. The mono numbers are the visual identity: they say "receipts" without saying it. The ledger treatment appears on the homepage math section, the pricing page, and inside the ROI calculator. Spend the boldness here and keep everything else quiet.

## Color

| Token | Hex | Usage |
|---|---|---|
| Forest green | #2D4A3E | Primary buttons, emphasis, footer background, the "kept" number in ledgers |
| Warm taupe | #BFB59D | Accents, borders (usually at 20% opacity), eyebrow labels, logo mark background. **Never body text: it fails contrast on white.** |
| White | #FFFFFF | Primary background |
| Off-white | #FAFAFA | Alternating section backgrounds |
| Premium text | #2F3435 | Headlines |
| Primary text | #3A4142 | Subheads, navigation |
| Body text | #333333 | Body copy |
| Secondary text | #666666 | Captions, footnotes, honesty disclosures |

No gradients. No additional colors. Dark sections (footer, optionally one homepage band) use forest green with white and taupe text.

## Typography

- **Family:** Geist Sans for everything except numbers and data, which use Geist Mono. Fallback stack: `system-ui, sans-serif` (and `ui-monospace, monospace` for mono). Self-host or load from a CDN with `font-display: swap`.
- **Hero headlines:** clamp(3rem, 6vw, 5.5rem), weight 700, tight line-height (1.05).
- **Section headlines:** clamp(1.75rem, 3vw, 2.75rem), weight 700.
- **Card and subsection titles:** 1.25 to 1.5rem, weight 600.
- **Body:** 1.125rem (18px), weight 400, line-height 1.6, max-width around 65ch.
- **Footnotes and honesty disclosures:** 0.875rem, secondary text color.
- **Eyebrow labels:** 0.8125rem, weight 600, letter-spacing 0.08em, uppercase, taupe or secondary text.
- Sentence case everywhere except eyebrows. No italics for emphasis; rewrite the sentence instead.

## Layout and spacing

- Container: max-width 1200px, centered. Copy-heavy sections narrower (max-width 760px).
- Section padding: 5rem vertical desktop, 2.5rem mobile.
- Grid: two-column for altitude splits and receipts, three-column max for differentiator cards. Stack on mobile.
- Radius: 8px buttons, 16px cards. Shadows: subtle only (`0 4px 12px rgba(0,0,0,0.08)`), no glows.

## Components

- **Primary button:** forest green background, white text, 8px radius, 16px 32px padding, weight 600. Hover: slight lift and shadow, no color change.
- **Secondary button:** transparent, 2px border in primary text color. Hover: fills.
- **Cards:** white, 1px taupe border at 20% opacity, 16px radius, 32px padding.
- **The clarifier bar:** full-width strip, off-white or a whisper of taupe, one sentence centered, nothing else in it.
- **Ledger block:** mono face, right-aligned figures, hairline rule above the result line, result in forest green at a heavier weight.

## Imagery and iconography

- No stock photos. No houses, handshakes, or laptops-with-coffee. No fabricated dashboard mockups.
- Icons: simple SVG line icons, 2px stroke, 20 to 24px, used sparingly (differentiator cards and receipts list only).
- Real product screenshots only when provided by Dal, never invented.
- The logo mark (the two-letter square on taupe) is fine as a mark. The wordmark next to it always reads "Appraisal Desk," Geist Sans weight 600.

## Motion

Minimal. Allowed: one gentle fade-up on section entry and the calculator's live number updates. Nothing else moves. Respect `prefers-reduced-motion` by disabling all of it.

## Accessibility floor

WCAG AA contrast everywhere (taupe is decorative only), visible keyboard focus states, 44px minimum tap targets, meaningful alt text, semantic landmarks on every page.
