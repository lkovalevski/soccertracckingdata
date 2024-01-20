#' ---
#' title: "Soccer Analytics - Data Visualization"
#' author: Kovalevski, L.
#' date: January 2024 
#' output:
#'    rmdformats::readthedown:
#'      highlight: kate
#'    toc: true
#'    toc_depth: 2
#' ---


# Load generic functions ----
source(here::here("code", "utils.R"), encoding = "UTF-8")
source(here::here("code", "read_data.R"), encoding = "UTF-8")

# Load and/or install packages ----
loadPackages( c("ggplot2", "grid", "dplyr") )


#' Relative datapath
data_path  <- here::here("data", "raw") 

#' File name vs BOCA 20/05/2017
data_name  <- "data_boca_1h.csv"

#' Positions file name vs BOCA 20/05/2017
pos_name  <- "positions.csv"

#' Read data
datasets <- read_and_clean_data()

#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Plot NOB Zone starting play



df_starting_play <- datasets[["df"]][
  , c("start_time_game_minutes", "starting_action", "end_time_game_minutes",
      "zone" )
  ]

# Starting play zone frequency
zone_freq     <- data.frame(with(df_starting_play, table(zone)))
starting_play <- merge(zone_freq, datasets[["pos"]], by = "zone")

# generate soccer field
soccer_field  <- generate_soccer_field()

# Rectangles
graph01 <- soccer_field +
  geom_tile( data = starting_play, aes(x = x, y = y, alpha = Freq, fill="red")) + 
  theme(legend.position = "none") 
graph01

# Density
graph02 <- soccer_field + 
  stat_density2d(aes(x = x, y = y, alpha=..density..), 
                 data = starting_play, geom = "tile", contour = FALSE) + 
  theme(legend.position = "none") 
graph02


#--------------------------------------------------------------------------------
# Plot NOB Zone ball recovery 

df_recovery <- df_starting_play[df_starting_play$starting_action == "Q",]

# Starting play zone frequency
recovery_zone_freq     <- data.frame(with(df_recovery, table(zone)))
recovery_zone <- merge(recovery_zone_freq, datasets[["pos"]], by = "zone")

soccer_field +stat_density2d(aes(x = jitter(x), y = jitter(y), fill=..level..), data=recovery_zone,geom="polygon", alpha=0.2)
soccer_field +stat_density2d(aes(x = x, y = y, alpha=..density..), data=recovery_zone,geom="tile", contour = FALSE)

graph03 <- soccer_field +
  geom_tile( data = recovery_zone, aes(x = x, y = y, alpha = Freq, fill="orange")) + 
  theme(legend.position = "none") 
graph03




















