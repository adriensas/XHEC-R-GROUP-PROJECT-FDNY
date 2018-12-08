nyfc <- st_read(dsn = "data/nyfc",
                layer = "nyfc",
                quiet = TRUE)

nyfc <- nyfc %>%
  mutate(FireCoNum = factor(FireCoNum),
         FireBN = factor(FireBN),
         FireDiv = factor(FireDiv))

plot_fire_dept <- function(x, by = "Div") {
  if (by == "Div") {
    tm_shape(nyfc %>% filter(FireDiv %in% x)) +
      tm_fill(col = "FireDiv") +
      tm_shape(nyfc) +
      tm_borders()
  }
  else if (by == "BN") {
    tm_shape(nyfc %>% filter(FireBN %in% x)) +
      tm_fill(col = "FireBN") +
      tm_shape(nyfc) +
      tm_borders()
  }
  else if (by == "Co") {
    tm_shape(nyfc %>% filter(FireCoNum %in% x)) +
      tm_fill(col = "FireCoNum") +
      tm_shape(nyfc) +
      tm_borders()
  }
  else {
    "Please enter a correct 'by' argument."
  }
}
