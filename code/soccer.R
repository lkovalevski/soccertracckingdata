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
loadPackages( c("ggplot2", "grid", "dplyr", "tidyr") )


#' Relative datapath
data_path  <- here::here("data", "raw") 

#' Relative figurepath
fig_path  <- here::here("result", "figures") 

#' File name vs CC 25/01/2024
data_name  <- "2024_01_25_excel_data_tracker.2do.csv"

#' Positions file name
pos_name  <- "positions.csv"

#' Starting file name
ini_name  <- "inicio_jugada.csv"

#' Read data
datasets <- read_and_clean_data()

#--------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# Plot NOB Zone starting play



df_starting_play <- datasets[["df"]][
  , c("start_time_game_minutes", "starting_action", "end_time_game_minutes",
      "zone" )
  ] %>% merge(.,   datasets[["df_ini"]], by = "starting_action")

df_starting_play

# Starting play zone frequency
zone_freq     <- data.frame(with(df_starting_play, table(zone))) %>% 
  mutate(
    pct  = Freq / sum(Freq),
    text = paste0( round(100 * pct, 0), "%")
  )
starting_play <- merge(zone_freq, datasets[["df_pos"]], by = "zone")

datasets[["df_ini"]]

# generate soccer field
soccer_field  <- generate_soccer_field()

# Zone graph
graph01 <- soccer_field +
  geom_point(data = starting_play, aes( x = x, y = y, color = "red", alpha = pct), size = 32  ) + 
  geom_text(data = starting_play, aes( x = x, y = y, alpha = pct, label = text), size = 8  ) +
  theme(legend.position = "none") +
  scale_x_discrete(name = "") +
  scale_y_discrete(name = "") +
  labs(title    = "Zona de Iniciacion de Jugadas Newells",
       subtitle = "vs Central Cordoba (2do T) - 2024-01-25")

ggsave("graph01.png", graph01, width = 17.5, height = 10)


#--------------------------------------------------------------------------------
# Plot NOB Way of starting play


df_inicio <- data.frame(with(df_starting_play, table(inicio))) %>% 
  mutate(
    pct  = 100 * Freq / sum(Freq),
    text = paste0( round( pct, 0), "%"),
    destacado = factor(1 * (pct == max(pct) ))
  ) %>% arrange( - pct)

var             = "inicio"
color_base      = "grey20" 
color_destacado = "#fc3f3f" 
titulo1         = "Modo de Iniciacion de Jugadas Newells"
titulo2         = "vs Central Cordoba (2do T) - 2024-01-25"

# Grafico de barras
graph02 <- ggplot(df_inicio, aes(x = factor(get(var), levels = rev(df_inicio[, var])), y = pct,
               fill = destacado)) +           
  geom_bar(stat = "identity") +               
  scale_fill_manual(values = c(color_base, color_destacado)) +
  guides(fill = FALSE)+ 
  scale_x_discrete(name = "Inicio jugada") + 
  scale_y_continuous(name = paste0("Porcentaje")) + 
  theme_bw() + 
  coord_flip() + 
  geom_hline(yintercept = 0, color = "grey", linewidth = .5) +
  labs(title    = titulo1, subtitle = titulo2) +
  annotate("text", x = df_inicio[6, var], y = 40, label = "@leokova",
           hjust = 0, vjust = 1.5, col = "grey70",# cex= 3,
           fontface = "bold", alpha = 0.5, size=rel(5)) +
  theme(panel.border     = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(),
        plot.title       = element_text(size = rel(2.2)),
        plot.subtitle    = element_text(size = rel(1.7)),
        axis.text.y      = element_text(size = rel(2)),
        axis.text.x      = element_text(size = rel(1.4)),
        axis.title.x     = element_text(size = rel(1.2)),
        axis.title.y     = element_text(size = rel(1.2))
  )


graph02


ggsave("graph2.png", graph02, width = 17.5, height = 10)


#--------------------------------------------------------------------------------
# Plot NOB Zone ending play



df <- datasets[["df"]] %>% select(-zone)

head(datasets[["df"]], 20)

df_long <- gather(df, condition, zone, V8:V27, factor_key = TRUE) %>% 
  mutate(
    orden = as.numeric(as.character(substring(condition, 2, nchar(as.character(condition)))))
  ) %>% 
  arrange(num, orden) %>% 
  filter(zone >= 1)

df_ending_play <- df_long %>% group_by(num) %>% filter(orden == max(orden)) %>% 
  select(start_time, end_time, ending_action, num, zone)


# Ending play zone frequency
end_zone_freq     <- data.frame(with(df_ending_play, table(zone))) %>% 
  mutate(
    pct  = Freq / sum(Freq),
    text = paste0( round(100 * pct, 0), "%")
  )

ending_play <- merge(end_zone_freq, datasets[["df_pos"]], by = "zone")

# Zone graph
graph03 <- soccer_field +
  geom_point(data = ending_play, aes( x = x, y = y, color = "red", alpha = pct), size = 32  ) + 
  geom_text(data = ending_play, aes( x = x, y = y, alpha = pct, label = text), size = 8  ) +
  theme(legend.position = "none") +
  scale_x_discrete(name = "") +
  scale_y_discrete(name = "") +
  labs(title    = "Zona de Finalizacion de Jugadas Newells",
       subtitle = "vs Central Cordoba (2do T) - 2024-01-25")

ggsave("graph3.png", graph03, width = 17.5, height = 10)

