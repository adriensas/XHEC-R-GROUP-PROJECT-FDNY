incidents <- read_csv("data/incidents.csv")

tidy_incidents <- incidents %>%
  select(IM_INCIDENT_KEY,
         FIRE_BOX,
         INCIDENT_TYPE_DESC,
         INCIDENT_DATE_TIME,
         ARRIVAL_DATE_TIME,
         LAST_UNIT_CLEARED_DATE_TIME,
         UNITS_ONSCENE,
         HIGHEST_LEVEL_DESC,
         ZIP_CODE,
         BOROUGH_DESC) %>%
  mutate(FIRE_BOX = factor(FIRE_BOX),
         INCIDENT_TYPE_DESC = factor(INCIDENT_TYPE_DESC),
         INCIDENT_DATE_TIME = as.POSIXct(INCIDENT_DATE_TIME),
         ARRIVAL_DATE_TIME = as.POSIXct(ARRIVAL_DATE_TIME),
         LAST_UNIT_CLEARED_DATE_TIME = as.POSIXct(LAST_UNIT_CLEARED_DATE_TIME),
         UNITS_ONSCENE = factor(UNITS_ONSCENE),
         HIGHEST_LEVEL_DESC = factor(HIGHEST_LEVEL_DESC),
         ZIP_CODE = factor(ZIP_CODE),
         BOROUGH_DESC = factor(BOROUGH_DESC)) %>%
  rename(id = IM_INCIDENT_KEY,
         inc_type = INCIDENT_TYPE_DESC,
         inc_time = INCIDENT_DATE_TIME,
         arr_time = ARRIVAL_DATE_TIME,
         dep_time = LAST_UNIT_CLEARED_DATE_TIME,
         units = UNITS_ONSCENE,
         inc_level = HIGHEST_LEVEL_DESC,
         zip_code = ZIP_CODE,
         borough = BOROUGH_DESC)

save(tidy_incidents, file = "data/incidents.RData")