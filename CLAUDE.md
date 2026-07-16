# CLAUDE.md: Appraisal Desk Website

This repo is the marketing site for appraisaldesk.com. It is a total rewrite. Do not reuse any copy from old site files anywhere in this repo; they are structure reference only.

## Read these before writing anything

1. `docs/appraisal-desk-locked-messaging.md` (the messaging doc). This is the source of truth for every headline, claim, number, and sentence. If copy you're about to write isn't backed by this doc, don't write it: flag it as an open question instead.
2. `docs/website-brief.md`. Defines the sitemap, every page's purpose, sections, CTAs, and SEO. Follow it.
3. `docs/design-tokens.md`. Defines the visual system. Follow it.
4. `docs/homebase-alignment.md`. Reference only: how our anchor customer's site refers to us, so the two sites stay consistent.

## Stack and conventions

- Plain HTML + CSS + minimal vanilla JS (nav toggle, ROI calculator). No frameworks, no build step.
- One shared `styles.css`. Page-specific JS lives in `js/`.
- Semantic HTML, mobile-first responsive, WCAG AA contrast, visible keyboard focus, `prefers-reduced-motion` respected.
- Every page gets: unique title and meta description (from the brief), canonical URL, Open Graph tags, favicon.
- Build page by page in the order the brief lists. Finish and QA one page before starting the next.

## Copy rules (non-negotiable)

- **No em dashes. Anywhere.** Not in copy, headings, meta tags, alt text, code comments, or commit messages. Use periods, commas, colons, or parentheses.
- The company name is always **Appraisal Desk**. Two words. Never one word, never abbreviated to two letters.
- **Locked key lines** (messaging doc Section 11) are used verbatim. Do not paraphrase them.
- **Stats and numbers** come only from messaging doc Section 14. Do not invent, round differently, or extrapolate.
- **AI claims:** only the four in messaging doc Section 9, each tied to its specific problem. Never a generic "AI-powered" label.
- On credit union pages: **members, not borrowers**. Member experience, not customer experience.
- Never bad-mouth AMCs or anyone. Describe old ways plainly (email billing, spreadsheets, manual panels) without attacking anyone. Highlight what the customer gains.
- No competitor names anywhere in public copy.
- No testimonials. None exist yet. Do not fabricate quotes, reviews, logos, or star ratings. Proof comes from the anchor customer stats.
- Never imply the desk runs itself for free, never promise instant appraiser payment, never claim "24/7 support," never state uptime numbers.
- Voice: plain, casual, confident, specific. If jargon is necessary, explain it in the same sentence. Would Dal say it in a first conversation with a prospect? If not, rewrite it.

## Banned words and phrases

streamline, optimize, seamless, leverage, cutting-edge, enterprise-grade, operational efficiency, tech-forward, AI-powered (as a generic label), best-in-class, solutions, revolutionize, "the only platform"

## QA checklist: run before considering any page done

Run these from the repo root and fix every hit before moving on:

```bash
# Em dashes (must return nothing)
grep -rn "—" --include="*.html" --include="*.css" --include="*.js" .

# One-word product name (must return nothing)
grep -rni "appraisaldesk" --include="*.html" . | grep -v "appraisaldesk.com"

# Banned vocabulary (must return nothing)
grep -rniE "streamlin|optimiz|seamless|leverag|cutting-edge|enterprise-grade|operational efficiency|AI-powered|best-in-class|revolutioniz|only platform|24/7" --include="*.html" .

# Borrower language on credit union pages (must return nothing)
grep -ni "borrower" for-credit-unions.html

# Fabricated proof (must return nothing)
grep -rniE "testimonial|★|5 stars" --include="*.html" .
```

Then verify by hand:
- Every number on the page matches Section 14 of the messaging doc ($55 flat, $95 kept, $150 typical AMC fee, $247,000 a year at 50 orders a week, $390,000 gross at that volume, 20,000 appraisals a year, 400+ orders a week, 15 years, thousands of appraisers, November 2026).
- The not-an-AMC clarifier appears where the brief requires it (high on the homepage and on every audience page).
- Locked lines match the messaging doc word for word.
- The page reads out loud like a person talking, not a brochure.

## When something is missing

If a page needs a fact, feature detail, integration name, screenshot, or decision that isn't in the docs, do not invent it. Add it to `docs/open-questions.md` with the page and section it blocks, put a clearly marked placeholder in the HTML comment (never in visible copy), and keep building.
