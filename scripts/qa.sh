#!/bin/bash
# QA script for appraisaldesk.com
# Run from repo root: ./scripts/qa.sh
# Exits nonzero on any failure

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

ERRORS=0
WARNINGS=0

echo "=========================================="
echo "Appraisal Desk QA Check"
echo "=========================================="
echo ""

# ---------------------------------------------
# 1. Em dashes (must return nothing)
# ---------------------------------------------
echo "Checking for em dashes..."
if grep -rn "—" --include="*.html" --include="*.css" --include="*.js" . 2>/dev/null; then
    echo "ERROR: Em dashes found. Replace with periods, commas, colons, or parentheses."
    ERRORS=$((ERRORS + 1))
else
    echo "  PASS: No em dashes found."
fi
echo ""

# ---------------------------------------------
# 2. One-word product name (must return nothing)
# ---------------------------------------------
echo "Checking for one-word 'AppraisalDesk' (should be two words)..."
if grep -rni "appraisaldesk" --include="*.html" . 2>/dev/null | grep -vi "appraisaldesk\.com" | grep -vi "appraisaldesk\.css" | grep -vi "appraisaldesk\.js" | grep -vi "href=" | grep -vi "src=" | grep -vi "url(" | grep -v "mailto:" | grep -vi "app\.appraisaldesk" | grep -vi "notes\.appraisaldesk"; then
    echo "ERROR: One-word 'AppraisalDesk' found in copy. Use 'Appraisal Desk' (two words)."
    ERRORS=$((ERRORS + 1))
else
    echo "  PASS: Product name properly written as two words."
fi
echo ""

# ---------------------------------------------
# 3. Banned vocabulary (must return nothing)
# ---------------------------------------------
echo "Checking for banned vocabulary..."
BANNED_PATTERN="streamlin|optimiz|seamless|leverag|cutting-edge|enterprise-grade|operational efficiency|AI-powered|best-in-class|revolutioniz|only platform|24/7"
if grep -rniE "$BANNED_PATTERN" --include="*.html" . 2>/dev/null; then
    echo "ERROR: Banned vocabulary found. Rewrite in plain language."
    ERRORS=$((ERRORS + 1))
else
    echo "  PASS: No banned vocabulary found."
fi
echo ""

# ---------------------------------------------
# 4. Borrower language on credit union pages (must return nothing)
# ---------------------------------------------
echo "Checking for 'borrower' on credit union pages..."
if [ -f "for-credit-unions.html" ]; then
    if grep -ni "borrower" for-credit-unions.html 2>/dev/null; then
        echo "ERROR: 'borrower' found on credit union page. Use 'member' instead."
        ERRORS=$((ERRORS + 1))
    else
        echo "  PASS: No 'borrower' language on credit union pages."
    fi
else
    echo "  SKIP: for-credit-unions.html not found yet."
fi
echo ""

# ---------------------------------------------
# 5. Fabricated proof (must return nothing)
# ---------------------------------------------
echo "Checking for fabricated testimonials or ratings..."
if grep -rniE "testimonial|★|☆|5 stars|4 stars|star rating" --include="*.html" . 2>/dev/null; then
    echo "ERROR: Fabricated proof found. No testimonials or star ratings allowed."
    ERRORS=$((ERRORS + 1))
else
    echo "  PASS: No fabricated proof found."
fi
echo ""

# ---------------------------------------------
# 6. Numbers check (approved list only)
# ---------------------------------------------
echo "Checking numbers against approved list..."
# Approved numbers from Section 14:
# $55, $95, $150, $247,000, $390,000, 20,000, 400+, 15 years, November 2026
# Also allowed: 50 orders/week (example volume), 10, 200 (pricing page volumes)
# Also allowed: percentages, dates, and structural numbers (like "one", "two", "three")

# Extract all dollar amounts and large numbers from HTML files
UNAPPROVED_NUMBERS=""

# Check for dollar amounts that aren't in the approved list
for file in $(find . -name "*.html" -type f 2>/dev/null); do
    # Skip legal pages for number checking (they have their own terms)
    if [[ "$file" == *"/legal/"* ]]; then
        continue
    fi

    # Find dollar amounts
    while IFS= read -r line; do
        # Extract dollar amounts
        amounts=$(echo "$line" | grep -oE '\$[0-9,]+' | tr '\n' ' ')
        for amt in $amounts; do
            # Remove $ and commas for comparison
            clean=$(echo "$amt" | tr -d '$,')
            # Check against approved amounts
            case "$clean" in
                55|95|150|247000|390000) ;;  # Approved
                *)
                    if [ -n "$clean" ]; then
                        UNAPPROVED_NUMBERS="$UNAPPROVED_NUMBERS\n  $file: $amt"
                    fi
                    ;;
            esac
        done
    done < "$file"
done

# Check for specific large numbers that should be approved
for file in $(find . -name "*.html" -type f 2>/dev/null); do
    if [[ "$file" == *"/legal/"* ]]; then
        continue
    fi

    # Check for "X,000" patterns (excluding approved ones)
    while IFS= read -r match; do
        num=$(echo "$match" | grep -oE '[0-9]+,[0-9]+')
        case "$num" in
            "20,000"|"247,000"|"390,000") ;;  # Approved
            *)
                if [ -n "$num" ]; then
                    UNAPPROVED_NUMBERS="$UNAPPROVED_NUMBERS\n  $file: $num"
                fi
                ;;
        esac
    done < <(grep -oE '[0-9]+,[0-9]+' "$file" 2>/dev/null || true)
done

if [ -n "$UNAPPROVED_NUMBERS" ]; then
    echo "WARNING: Numbers found that may not be in approved list:"
    echo -e "$UNAPPROVED_NUMBERS"
    echo "  Approved: \$55, \$95, \$150, \$247,000, \$390,000, 20,000, 400+, 15 years, November 2026"
    echo "  Also allowed for examples: 10, 50, 200 orders/week"
    WARNINGS=$((WARNINGS + 1))
else
    echo "  PASS: All numbers appear to be from approved list."
fi
echo ""

# ---------------------------------------------
# 7. Locked lines check
# ---------------------------------------------
echo "Checking locked lines for verbatim usage..."
LOCKED_LINES_FILE="$SCRIPT_DIR/locked-lines.txt"

if [ ! -f "$LOCKED_LINES_FILE" ]; then
    echo "  SKIP: locked-lines.txt not found."
else
    # Check that locked lines, when used, are verbatim
    LOCKED_LINE_ERRORS=0

    # Key phrases to search for (partial matches that indicate a locked line is being used)
    # If found, verify the full line is verbatim

    # Frame-setter check
    if grep -rli "We're not an AMC" --include="*.html" . 2>/dev/null | head -1 > /dev/null; then
        # Verify it's one of the two approved versions
        if ! grep -r "We're not an AMC. We're the software that runs one. Credit unions run their whole appraisal desk in this system." --include="*.html" . 2>/dev/null > /dev/null && \
           ! grep -r "We're not an AMC. We're the software that runs one. You keep the relationships, the revenue, and the control." --include="*.html" . 2>/dev/null > /dev/null; then
            # Check if there's a non-verbatim version
            if grep -r "We're not an AMC" --include="*.html" . 2>/dev/null | grep -v "Credit unions run their whole appraisal desk" | grep -v "You keep the relationships" > /dev/null; then
                echo "  WARNING: Frame-setter line may not be verbatim."
                LOCKED_LINE_ERRORS=$((LOCKED_LINE_ERRORS + 1))
            fi
        fi
    fi

    # Primary savings line check
    if grep -rli "Stop losing \$95" --include="*.html" . 2>/dev/null > /dev/null; then
        if ! grep -r "Stop losing \$95 an order. Start earning it back." --include="*.html" . 2>/dev/null > /dev/null; then
            echo "  WARNING: Primary savings line may not be verbatim."
            LOCKED_LINE_ERRORS=$((LOCKED_LINE_ERRORS + 1))
        fi
    fi

    # Efficiency line check
    if grep -rli "Do more without adding people" --include="*.html" . 2>/dev/null > /dev/null; then
        if ! grep -r "Do more without adding people. Your team handles more orders per person, and nothing slips." --include="*.html" . 2>/dev/null > /dev/null; then
            # This might be used as a headline without the full sentence, which is OK
            :
        fi
    fi

    if [ $LOCKED_LINE_ERRORS -gt 0 ]; then
        echo "  Found $LOCKED_LINE_ERRORS potential locked line issues. Verify manually."
        WARNINGS=$((WARNINGS + 1))
    else
        echo "  PASS: Locked lines appear to be used verbatim where present."
    fi
fi
echo ""

# ---------------------------------------------
# 8. Check for TODO/placeholder comments
# ---------------------------------------------
echo "Checking for TODO or placeholder comments..."
if grep -rniE "TODO|FIXME|PLACEHOLDER|lorem ipsum|coming soon" --include="*.html" . 2>/dev/null | grep -v "legal/"; then
    echo "ERROR: TODO/placeholder content found. Complete before shipping."
    ERRORS=$((ERRORS + 1))
else
    echo "  PASS: No TODO or placeholder content found."
fi
echo ""

# ---------------------------------------------
# 9. Check for empty hrefs
# ---------------------------------------------
echo "Checking for empty or placeholder hrefs..."
if grep -rniE 'href=""' --include="*.html" . 2>/dev/null; then
    echo "ERROR: Empty href found."
    ERRORS=$((ERRORS + 1))
fi
if grep -rniE 'href="#"' --include="*.html" . 2>/dev/null | grep -v 'href="#[a-z]'; then
    echo "WARNING: Placeholder href='#' found (unless it's an anchor link)."
    WARNINGS=$((WARNINGS + 1))
fi
if grep -rniE 'href="javascript:' --include="*.html" . 2>/dev/null; then
    echo "ERROR: javascript: href found. Use proper links."
    ERRORS=$((ERRORS + 1))
else
    echo "  PASS: No empty or placeholder hrefs found."
fi
echo ""

# ---------------------------------------------
# Summary
# ---------------------------------------------
echo "=========================================="
echo "QA Summary"
echo "=========================================="
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -gt 0 ]; then
    echo "FAILED: Fix $ERRORS error(s) before proceeding."
    exit 1
else
    if [ $WARNINGS -gt 0 ]; then
        echo "PASSED with $WARNINGS warning(s). Review manually."
    else
        echo "PASSED: All checks clean."
    fi
    exit 0
fi
