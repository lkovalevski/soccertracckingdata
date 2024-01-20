# soccertracckingdata
Esta fue una prueba para armar una herramienta (en Excel, usando Visual Basic) para recolectar información en vivo de un partido de futbol.


Overview
--------

    proyecto
    |- doc/            # documentacion del estudio
    |  |- articles/    # related articles, reviews 
    |  +- paper/       # manuscript(s), whether generated or not
    |
    |- data            # raw and primary data, are not changed once created 
    |  |- raw/         # raw data, will not be altered
    |  +- clean/       # cleaned data, will not be altered once created
    |
    |- code/           # any programmatic code
    |
    |- results         # all output from workflows and analyses
    |  +-  figures/     # graphs, likely designated for manuscript figures
    |
    |- scratch/        # temporary files that can be safely deleted or lost
    |
    |- README          # the top level description of content


[Plot01](results/figures/excel_data_collector.png)
[Plot02](results/figures/cacha.png)
[Plot03](results/figures/quites.png)
[Plot04](results/figures/inicio.png)


How to use
----------

Se ejecuta el archivo 'ejecutarAnalisisTexto.R' en el directorio raíz y los resultados del análisis se guardan enel archivo 'analisisTexto_yyyy-mm-dd.html' de la carpeta 'results'. 
