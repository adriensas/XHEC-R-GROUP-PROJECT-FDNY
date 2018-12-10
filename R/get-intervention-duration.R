get_intervention_duration <- function(df) {
  intervention_duration <- df %>%
    mutate(col = as.numeric(dep_time) - as.numeric(arr_time)) %>%
    select(col)

  return(intervention_duration)
}
