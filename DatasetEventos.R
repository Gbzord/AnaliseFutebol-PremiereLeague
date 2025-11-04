library(dplyr)
library(tibble) # Para a função tibble()

#Dataset
analise <- tribble(
  ~Team, ~Gls, ~xG, ~eficiencia_finalizacao, ~criatividade_ofensiva, ~intensidade_ataque, ~eficiencia_passes,
  "Man City", 94, 89.4, 1.05, 25.7, 32.9, 73.6,
  "Arsenal", 88, 82.1, 1.07, 23.7, 31.6, 70.8,
  "Liverpool", 75, 78.2, 0.96, 21.8, 30.3, 67.8,
  "Newcastle", 72, 67.2, 1.07, 21.1, 28.9, 68.2,
  "Chelsea", 65, 68.5, 0.95, 20.1, 27.6, 68.6,
  "Brighton", 62, 65.1, 0.95, 21.3, 28.4, 70.4,
  "Tottenham", 60, 62.3, 0.96, 19.0, 25.8, 69.4,
  "Man United", 58, 66.8, 0.87, 19.6, 26.8, 68.6,
  "West Ham", 55, 58.4, 0.94, 18.2, 25.0, 68.4,
  "Crystal Palace", 45, 52.7, 0.85, 16.8, 23.2, 68.2
)

# Normalizar as métricas para determinar a quantidade e o avanço dos eventos
max_intensidade <- max(analise$intensidade_ataque)
max_criatividade <- max(analise$criatividade_ofensiva)

analise_normalizada <- analise %>%
  mutate(
    # Numero de eventos simulados (baseado na Intensidade)
    n_events = round(100 + 400 * (intensidade_ataque / max_intensidade)),
    # Posiçao X media (avançada se a Criatividade for alta)
    mean_x = 75 + 10 * (criatividade_ofensiva / max_criatividade),
    # Variancia em Y (mais centralizado se a Eficiencia de Passes for alta, menos variacao lateral)
    sd_y = 15 - 5 * (eficiencia_finalizacao / max(analise$eficiencia_passes))
  )

# Gerar o dataset de eventos por iteração
set.seed(42) # Para reprodutibilidade

dados_eventos <- analise_normalizada %>%
  rowwise() %>%
  do({
    n <- .$n_events
    
    # Simular Coordenadas X: Distribuição normal em torno da mean_x
    x_coords <- rnorm(n, mean = .$mean_x, sd = 5) %>%
      pmin(99) %>% pmax(55) # Limita entre o meio-campo e a linha de fundo
    
    # Simular Coordenadas Y: Distribuição normal centrada em 50, com sd_y variável
    y_coords <- rnorm(n, mean = 50, sd = .$sd_y) %>%
      pmin(95) %>% pmax(5) # Limita dentro das laterais
    
    # Definir o tipo de evento (simplesmente distribuído para este exemplo)
    event_type <- sample(c("Passes_Prog", "Acao_Terco_Final", "Chute"), n, replace = TRUE, prob = c(0.6, 0.3, 0.1))
    
    tibble(
      Team = .$Team,
      Event_Type = event_type,
      X_Coord = x_coords,
      Y_Coord = y_coords
    )
  }) %>%
  ungroup()

# Exibir as primeiras linhas e o resumo
print("Primeiras linhas do novo dataset de eventos:")
print(head(dados_eventos))
print(paste("Total de eventos simulados:", nrow(dados_eventos)))


#_____________VISUALIZAÇÃO___________________________________


library(ggplot2)
library(ggsoccer)

p_heatmap_custom <- ggplot(dados_eventos, aes(x = X_Coord, y = Y_Coord)) +
  annotate_pitch(
    dimensions = pitch_international,
    fill = "#377d22",
    colour = "white"
  ) +
  # Adiciona o heatmap
  stat_density_2d(
    aes(fill = after_stat(density)),
    geom = "raster",
    contour = FALSE,
    alpha = 0.7
  ) +
  scale_fill_viridis_c(option = "magma", name = "Densidade de Ações") +
  
  # Divide o gráfico por time
  facet_wrap(~ Team, ncol = 3) + # 3 colunas para os 10 times
  
  theme_pitch() +
  labs(
    title = "Heatmap de Ações Ofensivas por Time - Simulação Baseada em Métricas",
    subtitle = "Criatividade e Intensidade influenciam a densidade e o avanço (Padrão UEFA)"
  ) +
  coord_flip(xlim = c(50, 105), ylim = c(-5, 105)) # Foca no campo de ataque e inverte

print(p_heatmap_custom)