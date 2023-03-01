library(community)

file.copy("../estimate_comparison/results.csv", "docs/data/results.csv", TRUE)
data_add(
  "results.csv",
  list(ids = list(variable = "geoid")),
  dir = "../redistribution_arlington/docs/data/", refresh = TRUE
)

site_build('../redistribution_arlington', serve = TRUE, options = list(
  theme_dark = TRUE, color_scale_center = "none", palette = "purple"
))
