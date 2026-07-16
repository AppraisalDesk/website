# Appraisal Desk Website Brief

**What this is:** the structural spec for the full rebuild of appraisaldesk.com. The messaging doc (`docs/appraisal-desk-locked-messaging.md`) supplies the words. This brief supplies the structure: pages, sections, CTAs, the calculator, and SEO. Where this brief references a locked line or a section, pull it verbatim from the messaging doc.

**The job of this site:** get a credit union decision maker to book a demo. Everything else (calculator engagement, UAD 3.6 content subscriptions, appraiser signups) is secondary.

**Audience priority:** credit unions first, lenders and AMCs second, appraisers third. The homepage leans credit union without excluding anyone.

---

## Global Elements

**Navigation (left to right):** Logo (links home), For Credit Unions, For Lenders, For Appraisers, Pricing, UAD 3.6, About. Right side: Login (links to the app), and a primary button: Book a Demo (links to /contact).

**Footer:** dark forest green background. Contains: the general frame-setter line ("We're not an AMC. We're the software that runs one. You keep the relationships, the revenue, and the control."), nav links, contact email, and copyright. No newsletter signup in v1 (the UAD 3.6 page handles content subscription).

**Primary CTA everywhere:** "Book a demo." Secondary CTA varies by page (usually "See the math" linking to /pricing or the calculator).

**Every page:** the not-an-AMC clarifier appears above the fold or immediately below the hero on the homepage and every audience page. Use the credit union version on credit union pages, the general version elsewhere.

---

## Page 1: Homepage (`index.html`)

**Purpose:** set the frame in five seconds: what we are, what it saves, why it works. Route each visitor to their page.
**Reader:** cold visitor, most likely a credit union or lender exec or desk manager who heard about us or Googled us.

**Sections, in order:**

1. **Hero.** Headline: the primary savings line ("Stop losing $95 an order. Start earning it back."). Subhead: the one-sentence company description. Buttons: Book a Demo (primary), See the Math (secondary, anchors to the math section). Under the buttons, one quiet stat line: 20,000 appraisals a year, 15 years in production, $55 flat per order.
2. **The clarifier bar.** The credit union frame-setter, one sentence, visually distinct strip. Nothing else in it.
3. **The math.** The supporting savings line as intro, then the signature ledger treatment (see design tokens): $150 typical AMC fee, minus $55 flat, equals $95 kept, every order. Below it: "$247,000 a year at 50 orders a week." One honesty footnote in small text: appraiser fees are separate and unchanged; this is the management fee. CTA: See Pricing.
4. **The core promise.** Headline: the efficiency line ("Do more without adding people..."). Then the six receipts from messaging doc Section 4 as a two-column list (status calls, deadlines, PDFs, payments, panel, QC checks). Close with the nothing-slips locked line.
5. **Two altitudes.** Side-by-side: "If you run the desk" (operator translation) and "If you run the numbers" (executive translation), content from Section 5. Each links to the relevant audience page.
6. **Differentiators.** The seven from Section 8, as compact cards: one plain-language sentence each, no feature lists. Order as ranked in the doc.
7. **UAD 3.6 banner.** The UAD locked line, "Mandate: November 2026," button to /uad-3-6.
8. **Proof.** The heritage line, plus the stat row (20,000 a year, 400+ a week, 15 years). HTML comment placeholder for a future link to the anchor customer's site (do not link until their alignment updates ship; see open questions).
9. **Final CTA.** The wedge line as headline, Book a Demo button.

**SEO title:** Appraisal Desk: Run Your Own Appraisal Desk, Keep $95 an Order
**Meta description:** Appraisal Desk is the software that runs an appraisal desk end to end. $55 flat per order, no setup fee, no minimum. Do more without adding people.

---

## Page 2: For Credit Unions (`for-credit-unions.html`)

**Purpose:** the flagship page. The complete business case for bringing the appraisal desk in-house. A VP of Lending should be able to forward this one URL to their CFO.
**Reader:** COO, CEO, CFO, VP of Lending at a credit union with real mortgage volume. Remember: members, not borrowers, everywhere on this page.

**Sections, in order:**

1. **Hero.** Headline: the member framing line ("Every order you run in-house keeps $95 in the credit union, working for your members."). Subhead: the wedge line. CTA: Book a Demo / Run Your Numbers (anchors to calculator).
2. **The clarifier.** Credit union frame-setter.
3. **The business case.** The full math from Section 3, ledger treatment, closing on the member tie: kept dollars become better rates, more lending capacity, more service.
4. **The ROI calculator.** Spec below. This is the page's centerpiece.
5. **Which one are you?** Three paths from Section 6, each a short block with its own pitch:
   - "Everything goes to an AMC today" (fully outsourced): the case from scratch, honest note that the desk needs a person or two and the savings funds them many times over.
   - "You have a desk, and you still route through an AMC" (the sweet spot): the team already exists, the only change is the software and who keeps the margin.
   - "You run a desk on other software" (the switcher): more volume without headcount, everything you rely on today lives here too, and UAD 3.6 means you were switching something anyway. Move once.
6. **The panel comes with it.** The panel locked line, plus two sentences on automated rotation by grade and geography.
7. **Quality without an AMC in the middle.** The quality locked line, plus the automated checks and grading mechanics from Section 8.5.
8. **Something to show your examiner.** The compliance locked line, plus SOC 2 (SSAE 18), PCI, appraiser independence enforced in the workflow, full automatic audit trail.
9. **The move is the easy part.** Low-risk, operator-led migration: people who have run this exact switch move you over without an IT project. UAD 3.6 move-once close.
10. **FAQ.** Answer the four standard objections plainly (compliance cost: built in; no IT budget: no IT lift; a third party feels safer: independent software keeps you compliant and in control; who runs the desk: your team, and the savings funds it).
11. **Final CTA.** Book a Demo.

**ROI calculator spec (`js/calculator.js`):**
- Input: orders per week (number input plus slider, default 50, range 5 to 500). Optional "advanced" toggle: current AMC management fee per order (default $150, range $75 to $300).
- Outputs, computed live and shown as a transparent ledger, never a black box: orders per year (weekly x 52), current annual AMC management spend, annual Appraisal Desk cost at $55 flat, and the big number: what you keep per year. Also show per-order kept.
- Copy rules inside the calculator: label it a management fee comparison. One footnote: appraiser fees are separate and unchanged either way, and your team runs the desk (the pitch is scale without adding headcount, not zero cost).
- All numbers in the mono face per design tokens. CTA directly under the result: Book a Demo.
- No email capture in v1. The math is free.

**SEO title:** Appraisal Desk for Credit Unions: Keep $95 an Order In-House
**Meta description:** Credit unions run their whole appraisal desk in Appraisal Desk. Keep the $95 per order an AMC would charge, working for your members. $55 flat, no minimums.

---

## Page 3: Pricing (`pricing.html`)

**Purpose:** radical clarity. The price is the trust signal, so give it its own page and zero asterisks.
**Reader:** anyone doing diligence, especially a CFO.

**Sections, in order:**

1. **Hero.** "$55 per order. Flat." Subhead: no setup fee, no monthly minimum, no contracts gymnastics, nothing else. (Confirm contract terms language; see open questions.)
2. **What's included.** Everything, listed plainly from the capability set: ordering, automated assignment and rotation, status updates, document handling, quality checks, the full financial back office (payments, holds, payouts, refunds, card fees, 1099s, reporting), compliance trail, UAD 3.6 workflow. One list, no tiers, no "contact us for enterprise."
3. **The math, again.** Ledger treatment: $150 vs $55 vs $95, annualized at a few volumes (10, 50, 200 orders a week). Honesty footnote as on other pages.
4. **Pricing FAQ.** What counts as an order, when we bill, what appraiser fees are (pass-through, unchanged), whether there's a volume discount (answer honestly per Dal; placeholder flagged in open questions).
5. **CTA.** Book a Demo.

**SEO title:** Appraisal Desk Pricing: $55 Per Order, Flat
**Meta description:** One price: $55 per order. No setup fees, no monthly minimums, everything included. See exactly what you keep by running your appraisal desk in-house.

---

## Page 4: UAD 3.6 Hub (`uad-3-6.html`)

**Purpose:** the plain-English authority page on UAD 3.6 for credit unions and lenders, the home of the content series, and the free conversion offer.
**Reader:** the person responsible for being ready by November 2026. This person often signs the contract.
**Technical source material:** `docs/` copies of the UAD 3.6 reference and the product scope doc. Keep the page plain-English; link depth lives in the article series.

**Sections, in order:**

1. **Hero.** "UAD 3.6 lands November 2026. Here's what it means, in plain English." Eyebrow: Mandate: November 2026.
2. **What's actually changing.** Forms become fields: instead of picking a form (1004, 1073), you answer questions about the property and the valuation, and the right product is generated. More structured data, more photos, machine-readable output. Explain every term used.
3. **Timeline.** Simple horizontal timeline to November 2026.
4. **What to ask before November.** A checklist written for credit unions: is your platform (or your AMC's platform) retrofitting or was it built for this, does your team order by form or by field, will your appraisers see the full order scope, what happens to your pipeline loans that close near the deadline.
5. **How Appraisal Desk handles it.** The UAD locked line, then the receipts: built for 3.6 from day one, dynamic product generation from order fields, quick start presets so your team can still "order a 1004" while the system handles the new format underneath, and every order detail flowing to the appraiser so they can scope the assignment before accepting.
6. **The free offer.** "Send us your product list and we'll convert it to UAD 3.6 format. Free, no pitch." Email CTA.
7. **The article series.** Card grid linking to posts on notes.appraisaldesk.com. Build the grid data-driven (simple JS array of title, description, URL) so adding articles is a one-line change.
8. **FAQ.** When it takes effect, what loans it covers (conventional GSE; FHA and VA run on their own standards and timelines), what happens to old forms, whether a desk can transition before November.

**SEO title:** UAD 3.6 Explained for Credit Unions and Lenders | Appraisal Desk
**Meta description:** UAD 3.6 is mandatory in November 2026 and it changes how appraisals are ordered and delivered. A plain-English guide, a readiness checklist, and a free product list conversion.

---

## Page 5: For Lenders (`for-lenders.html`)

**Purpose:** the general-audience version of the pitch for lenders and AMCs running (or taking over) their own desk.
**Reader:** lender ops leadership, AMC principals.

**Sections:** mirror the credit union page structure with the general frame-setter, minus member framing and minus the calculator (link to /pricing instead). Emphasize: the core promise and receipts, the back office in one system (the financial gut-punch locked line leads this section), the panel, quality, UAD 3.6, and the build-with-you line near the close. Include the honest LOS integration note per messaging doc rules: we tell you straight what we connect to today (names pending, see open questions).

**SEO title:** Run Your Appraisal Desk In-House | Appraisal Desk for Lenders
**Meta description:** Appraisal Desk runs the whole desk in one system: orders, payments, compliance, and reporting. Proven at 20,000 appraisals a year. Do more without adding people.

---

## Page 6: For Appraisers (`for-appraisers.html`)

**Purpose:** appraiser signups, and the reputation that travels when appraisers talk to each other.
**Reader:** a working appraiser deciding whether one more platform is worth it.

**Sections, in order:**

1. **Hero.** The appraiser locked line ("Sign up once. Get work everywhere...").
2. **How assignment works here.** No broadcast orders: assignments come to you directly, matched by grade and geography, not blasted to a zip code for a race. Decline without penalty.
3. **The money.** Full fee shown before you accept, no surprises. Paid fast when the lender approves. Free, always.
4. **The small stuff that isn't small.** E&O expiration tracked automatically with advance reminders. Mobile-first. We build things appraisers ask for.
5. **CTA.** Sign up (links to the app; confirm signup URL, see open questions).

**Never on this page:** payment speed guarantees, "instant" anything, integrations that aren't live.

**SEO title:** Appraisers: Sign Up Once, Get Work Everywhere | Appraisal Desk
**Meta description:** Join Appraisal Desk once and be available to every lender and AMC on the platform. Direct assignments, full fees shown upfront, no broadcast orders, free always.

---

## Page 7: About (`about.html`)

**Purpose:** the credibility page for the prospect who Googles us and wants to know who they'd be betting on.
**Reader:** diligence mode.

**Sections, in order:**

1. **Hero.** The one-sentence company description as headline territory, "software people first" framing.
2. **The story.** The heritage locked line, expanded one paragraph: proven inside a real, high-volume operation for 15 years before it was ever sold as software. Vendor framing throughout, never AMC spinout.
3. **How we work with customers.** The build-with-you locked line, plus the customer service positioning from Section 8.7: small team, real answers fast, a human one reply away.
4. **What we believe.** Three short principles pulled from the messaging doc: honesty over hype (we publish our price), receipts over buzzwords (we name what we built), efficiency reinvested (the routine gets automated, the judgment stays human).
5. **CTA.** Book a Demo.

**SEO title:** About Appraisal Desk: Software People First
**Meta description:** Appraisal Desk was proven inside a high-volume appraisal operation for 15 years before it was sold as software. Independent, honest, and built with the people who use it.

---

## Page 8: Contact (`contact.html`)

**Purpose:** book the demo with zero friction.

**Sections:** headline ("Let's look at your numbers together"), a short form (name, credit union or company, email, orders per week, anything you want us to know), and a direct email fallback. Form backend pending (see open questions); ship v1 with a mailto fallback if the backend isn't decided.

**SEO title:** Book a Demo | Appraisal Desk
**Meta description:** See Appraisal Desk run a real order end to end, and bring your volume numbers. We'll show you exactly what your desk keeps.

---

## Also build

- `404.html` in the site voice (one line, one link home; a small honest joke is allowed).
- `sitemap.xml` and `robots.txt`.
- Favicon from the logo mark.

## Open Questions (Claude Code: append to this list, never guess)

1. Contact form backend: Mailgun endpoint, a form service, or mailto for v1?
2. Login URL for the nav, and signup URL for appraisers.
3. Public contact email: dal@appraisaldesk.com or a general address?
4. LOS integration names: pending confirmation of which are platform-level. Placeholder comment on the lenders page until then.
5. Cross-link to the anchor customer's site: hold until their alignment updates ship, then link from the proof section.
6. Volume discount question in the pricing FAQ: what's the honest answer?
7. Analytics: none, or a privacy-friendly option?
