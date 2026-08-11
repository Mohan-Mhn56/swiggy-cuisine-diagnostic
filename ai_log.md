# AI-Assisted Prompting Log

## Prompt 1 — Part A (SQL: percentage_variance debugging)

**Role:** Act as a SQLite expert helping debug a query.

**Context:** I have a SQLite database (`swiggy_capstone.db`) with a `cuisine` cuisine-level
revenue total (`total_revenue`, INTEGER) and a `cuisine_targets` table with
`target_revenue_inr` (INTEGER). I'm computing
`percentage_variance = ((total_revenue - target_revenue_inr) / target_revenue_inr) * 100`
and every row is returning 0 or -1 instead of a real percentage.

**Task:** Explain why the percentage is truncating to 0/-1 and give the corrected expression.

**Constraints:** Must run on SQLite (not MySQL/Postgres syntax); cannot change the
column types in the schema.

**Format:** A one-paragraph explanation plus the corrected SQL expression only.

**AI's suggestion:** Multiply by `100.0` (a float literal) before dividing, so SQLite performs
floating-point division instead of integer division:
`((total_revenue - target_revenue_inr) * 100.0) / target_revenue_inr`

**Verification performed:** Ran both the original and corrected expressions against
`swiggy_capstone.db` for all 6 cuisines. The original expression returned 0 for every row;
the corrected expression returned real percentages (e.g. Chinese: -8.69%, Desserts: -21.22%,
Italian: +47.35%). Cross-checked the Chinese figure by hand: total_revenue 127840,
target 140000 → (127840-140000)/140000*100 = -8.69, matching the query output exactly.

---

## Prompt 2 — Part C (Tableau: Above/Below Target calculated field)

**Role:** Act as a Tableau Public expert helping design a calculated field.

**Context:** I have `monthly_cuisine_revenue.csv` connected in Tableau Public, with columns
cuisine, month, order_count, total_revenue, avg_revenue. I already know from my SQL/spreadsheet
work which cuisines are Above Target (North Indian, South Indian, Italian) and which are Below
Target (Chinese, Fast Food, Desserts).

**Task:** Give me a calculated field that tags each cuisine Above/Below Target so I can color
the cuisine revenue bar chart by that tag.

**Constraints:** Must work with SUM(total_revenue) aggregated per cuisine, since the raw CSV is
monthly-grain, not cuisine-grain.

**Format:** Just the calculated field formula and where to drag it.

**AI's suggestion:**
```
IF SUM([total_revenue]) >= 
    CASE [cuisine]
        WHEN "North Indian" THEN 180000
        WHEN "Chinese" THEN 140000
        WHEN "South Indian" THEN 50000
        WHEN "Fast Food" THEN 60000
        WHEN "Desserts" THEN 25000
        WHEN "Italian" THEN 10000
    END
THEN "Above Target" ELSE "Below Target" END
```
Drag the resulting field to Color on the cuisine bar chart.

**Verification performed:** Applied the calculated field, then checked the resulting Color
legend against my Cuisine Summary sheet's `status_tag` column from Part B — confirmed the same
3 cuisines (North Indian, South Indian, Italian) landed on "Above Target" in both places before
finalizing the chart.
