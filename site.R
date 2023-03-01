library(community)
page_head(
  title = "Redistribution Methods Errors",
  icon = "https://raw.githubusercontent.com/uva-bi-sdad/community/main/logo.svg",
  description = "Comparison of desitribution/estimation methods."
)
page_navbar(
  title = "Redistribution Methods Errors",
  logo = "https://raw.githubusercontent.com/uva-bi-sdad/community/main/logo.svg",
  input_button("Reset", "reset_selection", "reset.selection", class = "btn-link"),
  list(
    name = "Settings",
    backdrop = "false",
    class = "menu-compact",
    items = list(
      input_switch("Dark Theme", default_on = TRUE, id = "settings.theme_dark"),
      input_select("Color Palette", "palettes", "purple", id = "settings.palette", floating_label = FALSE),
      input_switch(
        "Color by Rank", id = "settings.color_by_order",
        note = paste(
          "Switch from coloring by value to coloring by sorted index.",
          "This may help differentiate regions with similar values."
        )
      ),
      input_switch("Hide URL Settings", id = "settings.hide_url_parameters"),
      input_switch("Hide Tooltips", id = "settings.hide_tooltips"),
      input_number("Digits", "settings.digits", default = 3, min = 0, max = 6, floating_label = FALSE),
      input_select(
        "Color Scale Center", options = c("none", "median", "mean"), default = 0,
        display = c("None", "Median", "Mean"), id = "settings.color_scale_center",
        floating_label = FALSE,
        note = "Determines whether and on what the color scale should be centered."
      ),
      '<p class="section-heading">Map Options</p>',
      input_number(
        "Outline Weight", "settings.polygon_outline", default = 1.5, step = .5, floating_label = FALSE,
        note = "Thickness of the outline around region shapes."
      ),
      '<p class="section-heading">Plot Options</p>',
      input_number(
        "Trace Limit", "settings.trace_limit", default = 210, floating_label = FALSE,
        note = "Limit the number of plot traces that can be drawn, split between extremes of the variable."
      )
    ),
    foot = list(
      input_button("Clear Settings", "reset_storage", "clear_storage", class = "btn-danger")
    )
  )
)


input_dataview("view_a", y = "variable_a")
input_dataview("view_b", y = "variable_b")

page_section(
  page_section(
    type = "col",
    output_map(
      list(
        name = "results",
        url = paste0(
          "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/NCR/Census%20Geographies/",
          "Block%20Group/2020/data/distribution/ncr_geo_census_cb_2020_census_block_groups.geojson"
        )
      ),
      dataview = "view_a",
      id = "map_a",
      subto = c("plot_a", "legend_a"),
      options = list(
        attributionControl = FALSE,
        scrollWheelZoom = FALSE,
        center = c(38.938, -77.315),
        zoom = 7,
        height = "400px"
      ),
      tiles = list(
        light = list(url = "https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png"),
        dark = list(url = "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png")
      )
    ),
    output_legend(
      palette = "settings.palette", dataview = "view_a", subto = c("map_a", "plot_a"),
      id = "legend_a", show_na = FALSE
    ),
    input_select(
      "Variable A", options = "variables",
      default = "sex_female.pums_1step", id = "variable_a"
    ),
    output_plot(
      x = "selected_x", y = "variable_a", dataview = "view_a",
      subto = c("map_a", "legend_a"), id = "plot_a",
      options = list(
        layout = list(
          showlegend = FALSE,
          xaxis = list(fixedrange = TRUE),
          yaxis = list(fixedrange = TRUE, zeroline = FALSE)
        ),
        config = list(modeBarButtonsToRemove = c("select2d", "lasso2d", "sendDataToCloud"))
      )
    )
  ),
  page_section(
    type = "col",
    output_map(
      list(
        name = "results",
        url = paste0(
          "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/NCR/Census%20Geographies/",
          "Block%20Group/2020/data/distribution/ncr_geo_census_cb_2020_census_block_groups.geojson"
        )
      ),
      dataview = "view_b",
      id = "map_b",
      subto = c("plot_b", "legend_b"),
      options = list(
        attributionControl = FALSE,
        scrollWheelZoom = FALSE,
        center = c(38.938, -77.315),
        zoom = 7,
        height = "400px"
      ),
      tiles = list(
        light = list(url = "https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png"),
        dark = list(url = "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png")
      )
    ),
    output_legend(
      palette = "settings.palette", dataview = "view_b", subto = c("map_b", "plot_b"),
      id = "legend_b", show_na = FALSE
    ),
    input_select(
      "Variable B", options = "variables",
      default = "sex_female.pums_2step", id = "variable_b"
    ),
    output_plot(
      x = "selected_x", y = "variable_b", dataview = "view_b",
      subto = c("map_b", "legend_b"), id = "plot_b",
      options = list(
        layout = list(
          showlegend = FALSE,
          xaxis = list(fixedrange = TRUE),
          yaxis = list(fixedrange = TRUE, zeroline = FALSE)
        ),
        config = list(modeBarButtonsToRemove = c("select2d", "lasso2d", "sendDataToCloud"))
      )
    )
  )
)

# bottom
input_select(
  "X Variable", options = "variables",
  default = "sex_female.pums_baseline", id = "selected_x"
)