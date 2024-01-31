# Data read

read_and_clean_data <- function(){

#' Read game data
df <- read.csv(
  file   = file.path(data_path, data_name), 
  sep    = ";", 
  dec    = ",",
  header = FALSE#, skip   = 1
)
df <- df[df$V3 != "", ]
head(df)


# Read positions reference data
df_pos <- read.csv(
  file = file.path(data_path, pos_name), 
  sep = ";", 
  dec = ","
)

# Read starting  lay data
df_ini <- read.csv(
  file = file.path(data_path, ini_name), 
  sep = ";", 
  dec = ","
)

# Numerate rows
df$num <- c( 1:nrow(df) )

# Nombres de las columnas
colnames(df)[1:7] <- c(
  "start_time", "start_time_game_minutes", "starting_action", 
  "end_time_game_minutes","end_time","ending_action", "zone"
)

# Calcular las duraciones delas jugadas
df <- df %>% mutate(
  num             = row_number(),
  played_time_min = end_time_game_minutes - start_time_game_minutes
  
)

return( list( df = df, df_pos = df_pos, df_ini = df_ini) )
}

