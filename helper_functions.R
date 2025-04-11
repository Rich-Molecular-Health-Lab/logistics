react_stub <- function(field) {
  js_code <- sprintf("
    function(rowInfo, column, state) {
      const firstSorted = state.sorted[0];
      if (!firstSorted || firstSorted.id === '%s') {
        const prevRow = state.pageRows[rowInfo.viewIndex - 1];
        if (prevRow && rowInfo.values['%s'] === prevRow['%s']) {
          return { visibility: 'hidden' };
        }
      }
    }
  ", field, field, field)

  JS(js_code)
}

map_courses <- function(list = timeline_ms) {
  map_depth(list, 1, \(x) keep_at(x, "coursework")) %>% compact() %>%
    enframe(name = "semester") %>%
    unnest_longer(value, indices_include = FALSE) %>%
    unnest_longer(value, indices_to = "course") %>%
    unnest_wider(value, names_sep = "_") %>%
    mutate(semester = str_remove_all(semester, "semester_"),
           value_1  = str_to_title(value_1)) %>%
    select(
      semester,
      course,
      title   = value_1,
      credits = value_2
    ) %>%
    arrange(semester, course) %>%
    select(semester, course, credits, title)
}

map_credits <- function(list = timeline_ms) {
  map_courses(list) %>%
  summarize(credits = sum(credits), .by = semester) %>%
    mutate(
      semester_lab = as.character(semester),
      year         = if_else(semester_lab %in% c("1", "2"), "Year 1", "Year 2"),
      semester_lab = if_else(semester_lab %in% c("1", "3"), "Fall", "Spring")) %>%
    select(year, semester_lab, semester, credits)
}

map_thesis <- function(list = timeline_ms) {
  map_depth(list, 1, \(x) keep_at(x, "thesis")) %>% compact() %>%
    enframe(name = "semester")  %>%
    unnest_longer(value, indices_include = FALSE) %>%
    unnest_longer(value, values_to = "goal") %>%
    mutate(semester = str_remove_all(semester, "semester_")) %>%
    mutate(order    = as.character(row_number()),
           order    = str_glue("{order}", "."), .by = semester)
}

credits_colDef <- function(values, name) {
  colDef(
    name      = name,
    align     = "left",
    minWidth  = 40,
    aggregate = "sum",
    footer    = function(values) sum(values)
  )
}

subtbl_courses <- function(list = timeline_ms, index) {
  summary <- map_credits(list)
  map_courses(list) %>%
  filter(semester == summary$semester[index]) %>%
  select(course, credits, title) %>%
  reactable(
      fullWidth     = FALSE,
      theme         = fivethirtyeight(),
      defaultColDef = colDef(footerStyle = list(fontWeight = "bold")),
      outline       = FALSE,
      columns       = list(
        course      = colDef(name   = "Course", minWidth = 90, footer = "Sem. Total"),
        title       = colDef(name = "Title" , minWidth = 260),
        credits     = credits_colDef(values, "Cr")
      )
    )
}

subtbl_thesis <- function(list = timeline_ms, index) {
  summary <- map_credits(list)
  map_thesis(list) %>%
  filter(semester == summary$semester[index]) %>%
  select(order, goal) %>%
  reactable(
      fullWidth = FALSE,
      theme     = void(),
      outline   = FALSE,
      columns   = list(
        order = colDef(name = ""      , minWidth = 25, align = "left"),
        goal  = colDef(name = "Thesis", minWidth = 250)
      )
    )
}

timeline_cols <- function(list = timeline_ms, values = values) {
  list(
    year    = colDef(
      name      = "",
      minWidth  = 110,
      style     = react_stub("year"),
      footer    = "Total"
    ),
    semester_lab = colDef(
      name     = "",
      align    = "left",
      minWidth = 70,
      style    = react_stub("semester_lab")
    ),
    credits  = credits_colDef(values, "Cr"),
    semester = colDef(show = FALSE)
  )
}

timeline_react <- function(list = timeline_ms, file_path = "outputs/grad_timeline_ms.html") {
  timeline <- map_credits(list) %>%
    reactable(
      theme           = pff(),
      groupBy         = "year",
      defaultExpanded = TRUE,
      fullWidth       = FALSE,
      defaultColDef   = colDef(footerStyle = list(fontWeight = "bold")),
      columns         = timeline_cols(),
      details         = function(index) {
        thesis_tbl  <- subtbl_thesis(list, index)
        courses_tbl <- subtbl_courses(list, index)
        div(style = "padding: 0.5rem 1rem; display: flex; gap: 0.5rem; align-items: flex-start;",
            div(thesis_tbl),
            div(courses_tbl)
        )
      }
    ) %>%
    add_title("Proposed Timeline for Biology MS")
  save_reactable_test(timeline, file_path)
  return(timeline)
}

