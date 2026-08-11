# Data Story — Swiggy Cuisine Performance Diagnostic

## Where each cuisine stands against its target (Jan–Jun 2026)

| Cuisine | Revenue | Target | Variance | % Variance | Status |
|---|---|---|---|---|---|
| North Indian | ₹216,297 | ₹180,000 | +₹36,297 | +20.17% | Above Target |
| South Indian | ₹63,417 | ₹50,000 | +₹13,417 | +26.83% | Above Target |
| Italian | ₹14,735 | ₹10,000 | +₹4,735 | +47.35% | Above Target |
| Chinese | ₹127,840 | ₹140,000 | -₹12,160 | -8.69% | Below Target – Watch |
| Fast Food | ₹55,123 | ₹60,000 | -₹4,877 | -8.13% | Below Target – Watch |
| Desserts | ₹19,694 | ₹25,000 | -₹5,306 | -21.22% | Below Target – Critical |

**Three cuisines are clearing target** — North Indian by the widest rupee margin
(+₹36,297), and Italian by the widest percentage margin (+47.35%), though Italian's
small target (₹10,000) makes that percentage easy to hit.

**Three cuisines are behind target.** Chinese and Fast Food are both modestly short
(-8–9%) — close enough to be a "Watch" rather than a crisis. Desserts is the one
cuisine in "Critical" territory, missing its target by over a fifth (-21.22%), the
largest percentage shortfall on the platform.

## Recommendations

1. **Prioritize catalog growth in Desserts.** It's the only cuisine in Critical status
   and has the fewest restaurants and lowest order volume of any cuisine in the
   dataset — onboarding a handful of additional dessert restaurants is the most
   direct lever to close a -21% gap that's structural (too few sellers), not just a
   demand problem.
2. **Review Chinese cuisine's underperforming restaurants individually**, rather than
   treating the -8.69% shortfall as a category-wide issue. Chinese has the second-highest
   revenue of any cuisine in absolute terms, so the gap likely traces to a handful of
   lower-performing restaurants dragging the average down — the restaurant-level LEFT
   JOIN report from Part A is the place to find them.
