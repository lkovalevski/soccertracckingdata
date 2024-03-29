# Definir el directorio
datapath<-"C:/Users/Leo/Dropbox/Consultora/Soccer"
# datapath<-"C:/Users/lkoval/Dropbox/Consultora/Soccer"

# Leer los datos de las jugadas
# datos<-read.csv(file=paste(datapath,'soccer.csv', sep="/"), sep = ";", dec = ",")
# Leer los datos de las jugadas del 1er tiempo del partido vs BOCA 20/05/2017
datos<-read.csv(file=paste(datapath,'data_boca1.csv', sep="/"), sep = ";", dec = ",", header = F)

# Leer los datos de las posiciones
pos<-read.csv(file=paste(datapath,'posiciones.csv', sep="/"), sep = ";", dec = ",")

head(datos)
head(pos)

#--------------------------------------------------------------------------------
# ---------------- Depurar losdatos de los partidos
#--------------------------------------------------------------------------------

# Eliminar 1er renglon
jug <- datos[-1,]

# Numerar las jugadas
jug$nro <- c(1:nrow(jug))

# Nombres de las columnas
colnames(jug)[1:6] <- c("h.ini","min.ini","ini","min.fin","h.fin","fin")

# Calcular las duraciones delas jugadas
jug$dur <- jug$min.fin-jug$min.ini
summary(jug$dur)
t1 <- table(jug$ini)
prop.table(t1)

t2 <- table(jug$fin)
prop.table(t2)

t3 <- table(jug$V7)
prop.table(t3)

head(jug)




pos

#--------------------------------------------------------------------------------


#--------------------------------------------------------------------------------
# Graficar el inicio de la jugada

inicio <- jug[,c("min.ini", "ini","min.fin","V7" )]
colnames(inicio)[4] <- c("Zona")

# ---------------  Frecuencia por Zona
heat <- data.frame(with(inicio,table(Zona)))
heat <- heat[!heat$Zona=="",]


inicio <- merge(heat, pos, by="Zona")

campo.3<- campo+geom_tile(data=inicio, aes(x = x, y = y, alpha=Freq, fill="red"))+ theme(legend.position = "none") # Remover la legenda

campo.3
campo.q2


campo.q + scale_fill_gradient(low = "yellow", high = "red") + theme(legend.position = "none") # Remover la legenda

campo.q2 + scale_fill_gradient(low = "yellow", high = "red") + theme(legend.position = "none") # Remover la legenda




quite <- inicio[inicio$ini=="Q",]
head(inicio)
head(quite)


campo.q<- campo+stat_density2d(aes(x = jitter(x), y = jitter(y), fill=..level..), data=inicio,geom="polygon", alpha=0.2)
campo.q2<- campo+stat_density2d(aes(x = x, y = y, alpha=..density..), data=inicio,geom="tile",contour = FALSE)


# Incluir las posiciones en el gr?fico
campo+ geom_point(data=pos,aes(x,y),colour = "black", size = 5)

summary(datos)

campo.2<- campo+stat_density2d(aes(x = x, y = y, fill=..level..), 
                               data=pos,geom="polygon", alpha=0.2)
campo.2 + scale_fill_gradient(low = "yellow", high = "red")



#










#' ggplot football pitch
#' just done in 5mins at lunch
#' possible to add centre circles with geom_path, 
#' should be possible to draw arcs outside penalty area first, then draw penalty area over the top with 'fill = "#FFFFFF"'
ggplot() +
  geom_rect(aes(xmin = 0, xmax = 100, ymin = 0, ymax = 100), fill = NA, colour = "#000000", size = 1) +
  geom_rect(aes(xmin = 0, xmax = 50, ymin = 0, ymax = 100), fill = NA, colour = "#000000", size = 1) +
  geom_rect(aes(xmin = 17, xmax = 0, ymin = 21, ymax = 79), fill = NA, colour = "#000000", size = 1) +
  geom_rect(aes(xmin = 83, xmax = 100, ymin = 21, ymax = 79), fill = NA, colour = "#000000", size = 1) +
  geom_rect(aes(xmin = 0, xmax = 6, ymin = 36.8, ymax = 63.2), fill = NA, colour = "#000000", size = 1) +
  geom_rect(aes(xmin = 100, xmax = 94, ymin = 36.8, ymax = 63.2), fill = NA, colour = "#000000", size = 1) +
  theme(rect = element_blank(), 
        line = element_blank(),
        text = element_blank())


```

## Including Plots

You can also embed plots, for example:
  
  ```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
