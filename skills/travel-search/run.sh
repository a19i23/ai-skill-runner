#!/bin/bash
# Travel Search Skill - Uses cursor-agent for autonomous research

TARGET=${TARGET:-"Hawaii"}
START_DATE=${START_DATE:-"2025-12-15"}
END_DATE=${END_DATE:-"2025-12-22"}
ORIGIN=${ORIGIN:-"LAX"}
BUDGET=${BUDGET:-"1500"}
TRAVELERS=${TRAVELERS:-"2"}

# Parse additional params if provided
if [ -n "$ADDITIONAL_PARAMS" ] && [ "$ADDITIONAL_PARAMS" != "{}" ]; then
  ORIGIN=$(echo "$ADDITIONAL_PARAMS" | jq -r '.origin // "LAX"')
  TRAVELERS=$(echo "$ADDITIONAL_PARAMS" | jq -r '.travelers // "2"')
fi

FILENAME="results/travel_${TARGET// /_}_$(date +%Y%m%d_%H%M%S).md"

echo "🔍 Travel Search Configuration:"
echo "   Destination: $TARGET"
echo "   Dates: $START_DATE to $END_DATE"
echo "   Origin: $ORIGIN"
echo "   Budget: \$$BUDGET per person"
echo "   Travelers: $TRAVELERS"
echo ""

echo "🤖 Launching cursor-agent for autonomous search..."
echo ""

# Run cursor-agent with comprehensive travel search prompt
cursor-agent "Search for flights and hotels to $TARGET from $ORIGIN, \
departing $START_DATE, returning $END_DATE, budget \$$BUDGET per person, \
$TRAVELERS travelers.

COMPREHENSIVE SEARCH REQUIREMENTS:
1. Search Google Flights, Kayak, and Expedia for flight options
2. Search Hotels.com, Booking.com, and Airbnb for accommodations in $TARGET
3. Look for package deals (flight + hotel combinations) on Expedia and Priceline
4. Compare all options and calculate total costs
5. Consider factors like: flight times, layovers, hotel location, ratings, amenities
6. Recommend the best value option with detailed reasoning

PROVIDE DETAILED ANALYSIS:
- Top 3 flight options with:
  * Airline and flight numbers
  * Departure/arrival times
  * Layovers (if any)
  * Price per person
  * Baggage policy
  * Pros and cons

- Top 3 hotel/accommodation options with:
  * Name and location
  * Rating and number of reviews
  * Price per night and total for stay
  * Key amenities
  * Distance to main attractions
  * Pros and cons

- Best package deal (if available):
  * What's included
  * Total price
  * Savings vs booking separately
  * Booking link

- Your RECOMMENDATION:
  * Which option to choose and why
  * Total estimated cost breakdown
  * Any tips to save money
  * Best booking strategy

Format as a comprehensive, well-structured markdown report.
Save the complete analysis to: $FILENAME"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Travel search completed successfully!"
    echo "📄 Results saved to: $FILENAME"
    
    # Copy to standard output location
    cp "$FILENAME" results/output.md
    
    # Create a summary
    echo "Travel search for $TARGET completed" > results/summary.txt
    echo "Dates: $START_DATE to $END_DATE" >> results/summary.txt
    echo "Budget: \$$BUDGET per person ($TRAVELERS travelers)" >> results/summary.txt
else
    echo ""
    echo "❌ cursor-agent execution failed"
    echo "Check that cursor-agent is properly installed"
    exit 1
fi
