#!/usr/bin/env bash
# Initialize a new multi-repo system from this template.
# Replaces SYSTEM_NAME / SYSTEM_DESCRIPTION placeholders, sets up git, self-deletes.
#
# Usage: ./init-workspace.sh <system-name> [description]
# Example: ./init-workspace.sh rag-system "A local retrieval-augmented generation stack"

set -euo pipefail

if [ -z "${1:-}" ]; then
    echo "Usage: $0 <system-name> [description]"
    echo "Example: $0 rag-system \"A local RAG stack\""
    exit 1
fi

SYSTEM_NAME_RAW="$1"
SYSTEM_DESC="${2:-A new multi-repo system}"

echo "→ System name: $SYSTEM_NAME_RAW"
echo "→ Description: $SYSTEM_DESC"
echo ""

# Replace placeholders across the workspace (skip git, the cloned child repos, and the
# examples/ directory — the example is meant to keep its own filled-in names).
echo "→ Replacing placeholders..."
find . -type f \
    \( -name "*.md" -o -name "*.yaml" -o -name "*.yml" -o -name "*.toml" -o -name "*.sh" \) \
    -not -path "./.git/*" \
    -not -path "./repos/*" \
    -not -path "./examples/*" \
    -print0 | while IFS= read -r -d '' file; do
    if grep -q "SYSTEM_NAME\|SYSTEM_DESCRIPTION" "$file" 2>/dev/null; then
        sed -e "s/SYSTEM_NAME/$SYSTEM_NAME_RAW/g" \
            -e "s|SYSTEM_DESCRIPTION|$SYSTEM_DESC|g" \
            "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    fi
done
echo "✓ Placeholders replaced"

# Strip the template-only usage section from the README.
if [ -f README.md ] && grep -q "TEMPLATE-USAGE:START" README.md; then
    sed '/<!-- TEMPLATE-USAGE:START/,/<!-- TEMPLATE-USAGE:END/d' README.md > README.md.tmp \
        && mv README.md.tmp README.md
    echo "✓ Removed template-only README section"
fi

# Make the scripts executable.
chmod +x workspace.sh scripts/manifest.py 2>/dev/null || true

# Initialize git if not already a repo.
if [ ! -d .git ]; then
    git init -q
    echo "✓ Initialized git repository"
fi

# Remove this init script (one-time use).
rm -- "$0"
echo "✓ Removed init script (one-time use)"

echo ""
echo "Next steps:"
echo "  1. Fill in docs/ai/SYSTEM.md (the service list + dependency graph)"
echo "  2. Scaffold services:  ./workspace.sh new api \"HTTP API\""
echo "  3. Wire them into repos.yaml (consumes/exposes/port)"
echo "  4. ./workspace.sh check   (system-wide quality gate)"
echo "  5. git add . && git commit -m 'chore: initial commit from multirepo-template'"
