get_intervention_duration <- function(df) {
  intervention_duration <- df %>%
    mutate(col = as.numeric(ARRIVAL_DATE_TIME) - as.numeric(LAST_UNIT_CLEARED_DATE_TIME)) %>%
    select(col)

  return(deployment_time)
}
