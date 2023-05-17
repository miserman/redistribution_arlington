library(community)

file.copy(
  "../estimate_comparison/results_tract.csv",
  "../redistribution_arlington/docs/data/results.csv",
  TRUE
)
data_add(
  "results.csv",
  list(ids = list(variable = "geoid")),
  dir = "../redistribution_arlington/docs/data/"
)

site_build("../redistribution_arlington", serve = TRUE, options = list(
  theme_dark = TRUE, color_scale_center = "median", palette = "purple"
))
