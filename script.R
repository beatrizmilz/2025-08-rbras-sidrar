# Material: https://beatrizmilz.github.io/2025-08-rbras-sidrar/

# Instalar e carregar ------------------------------------------
# Instalar pacote sidrar
install.packages("sidrar")

# Carregar o pacote sidrar
library(sidrar)

# Funções do sidrar ------------------------------------------

# Função para buscar as tabelas do SIDRA
search_sidra("PNADCT")


# Função para buscar as informações de uma tabela específica
informacoes <- info_sidra("4092")

names(informacoes)

informacoes$table
informacoes$period
informacoes$variable
informacoes$classific_category
informacoes$geo

# Importar dados do SIDRA

resultados_sidra <- get_sidra(x = 4092)
resultados_sidra


# Buscando vários períodos -------------------
periodos <- stringr::str_split(informacoes$period, ", ")[[1]]

resultados_sidra_periodos_uf <- get_sidra(x = 4092,
                                              period = periodos,
                                              geo = c("State"))

# salvar os dados -------------------
dir.create("dados")

# o formato rds é nativo do R, preserva tipos de dados
readr::write_rds(x = resultados_sidra_periodos_uf,
                 file = "dados/dados_sidra_4092.rds")

# o formato parquet é mais leve e rápido
arrow::write_parquet(x = resultados_sidra_periodos_uf,
                 sink = "dados/dados_sidra_4092.parquet")


# o formato csv é mais universal, mas não preserva tipos de dados
readr::write_csv(x = resultados_sidra_periodos_uf,
                 file = "dados/dados_sidra_4092.csv")
