setHook("rstudio.sessionInit", function(newSession) {
  if (newSession) {
    update_prefs <- function(...) {
      list_updated_prefs <- rlang::dots_list(...)
      purrr::iwalk(list_updated_prefs, ~rstudioapi::writeRStudioPreference(name = .y, value = .x))
      return(invisible(list_updated_prefs))
    }
    
    update_prefs(
      auto_detect_indentation = TRUE,
      auto_discover_package_dependencies = FALSE,
      load_workspace = FALSE,
      insert_native_pipe_operator = TRUE,
      rainbow_parentheses = TRUE,
      rmd_auto_date = TRUE,
      rmd_viewer_type = "pane",
      save_workspace = "never",
      show_help_tooltip_on_idle = TRUE,
      show_margin = FALSE,
      soft_wrap_r_files = TRUE,
      source_with_echo = TRUE
    )
    message("RStudio global preferences have been set.")
    rm(update_prefs)
  }
}, action = "append")
