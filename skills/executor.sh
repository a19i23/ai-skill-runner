#!/bin/bash
# Skill Executor - Routes to the appropriate skill based on input

set -e

# Create results directory
mkdir -p results

# Get skill name
SKILL=${SKILL:-"travel-search"}

echo "🎯 Executing skill: $SKILL"
echo "Target: $TARGET"
echo "================================"
echo ""

# Route to the appropriate skill
case "$SKILL" in
  travel-search)
    echo "🤖 Using cursor-agent for autonomous travel search..."
    ./skills/travel-search/run.sh
    ;;
  
  market-research)
    echo "🤖 Using cursor-agent for market research..."
    ./skills/market-research/run.sh
    ;;
  
  competitor-analysis)
    echo "🤖 Using cursor-agent for competitor analysis..."
    ./skills/competitor-analysis/run.sh
    ;;
  
  price-monitoring)
    echo "🐍 Using Python script for price monitoring..."
    ./skills/price-monitoring/run.sh
    ;;
  
  website-scraping)
    echo "🐍 Using Python script for website scraping..."
    ./skills/website-scraping/run.sh
    ;;
  
  *)
    echo "❌ Unknown skill: $SKILL"
    echo "Available skills:"
    echo "  - travel-search (uses cursor-agent)"
    echo "  - market-research (uses cursor-agent)"
    echo "  - competitor-analysis (uses cursor-agent)"
    echo "  - price-monitoring (uses Python)"
    echo "  - website-scraping (uses Python)"
    exit 1
    ;;
esac

# Generate summary
if [ -f results/output.md ]; then
  echo "✅ Skill execution completed successfully" > results/summary.txt
  echo "" >> results/summary.txt
  echo "Output files generated:" >> results/summary.txt
  ls -lh results/ >> results/summary.txt
else
  echo "⚠️  Skill execution completed but no output file found" > results/summary.txt
fi

echo ""
echo "================================"
echo "✅ Skill execution complete!"
echo "Check the artifacts for results"
