# ANÁLISE DE DADOS DE FUTEBOL - VERSÃO CORRIGIDA
library(tidyverse)
library(ggplot2)
library(ggrepel)

# DEFINIR DADOS MANUALMENTE (SEM DEPENDER DA COLETA)
cat("Criando dados de exemplo para análise...\n")

times <- c("Arsenal", "Man City", "Liverpool", "Chelsea", "Tottenham", 
           "Man United", "Newcastle", "Brighton", "West Ham", "Crystal Palace")

dados_equipes <- data.frame(
  Team = times,
  MP = c(38, 38, 38, 38, 38, 38, 38, 38, 38, 38),
  Gls = c(88, 94, 75, 65, 60, 58, 72, 62, 55, 45),
  xG = c(82.1, 89.4, 78.2, 68.5, 62.3, 66.8, 67.2, 65.1, 58.4, 52.7),
  Ast = c(52, 58, 48, 45, 42, 44, 50, 48, 40, 38),
  xAG = c(48.3, 54.2, 46.1, 42.8, 39.5, 41.2, 46.8, 44.5, 38.2, 35.6),
  PrgC = c(350, 320, 380, 310, 290, 300, 330, 340, 280, 260),
  PrgP = c(850, 920, 780, 720, 680, 700, 750, 760, 650, 600),
  Att_3rd = c(1200, 1250, 1150, 1050, 980, 1020, 1100, 1080, 950, 880),
  PPDA = c(9.8, 10.2, 11.1, 12.3, 13.5, 12.8, 10.5, 9.9, 14.2, 15.1),
  Press = c(5500, 5200, 4800, 4500, 4300, 4600, 5100, 5300, 4200, 4000)
)



cat(".csv Carregado com sucesso!\n")


