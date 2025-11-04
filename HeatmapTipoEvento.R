library(ggplot2)
library(ggsoccer)
library(dplyr) # Necessário para a função filter()

# --- Filtrar apenas Passes Progressivos ---
dados_passes_prog <- dados_eventos %>%
  filter(Event_Type == "Passes_Prog")


#__________________VISUALIZAÇAO I__________________________

p_heatmap_passes <- ggplot(dados_passes_prog, aes(x = X_Coord, y = Y_Coord)) +
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
  scale_fill_viridis_c(option = "cividis", name = "Densidade de Passes") + # Mudando a cor para diferenciar
  
  # Divide o gráfico por time
  facet_wrap(~ Team, ncol = 3) +
  
  theme_pitch() +
  labs(
    title = "Heatmap de PASSES PROGRESSIVOS por Time",
    subtitle = "Foco na área de construção e progressão ofensiva (Padrão UEFA)"
  ) +
  # Geralmente, passes progressivos podem começar um pouco mais recuados (X=40 a 105)
  coord_flip(xlim = c(40, 105), ylim = c(-5, 105))

print(p_heatmap_passes)

#______________________________VISUALIZACAO II____________________


# --- Filtrar apenas Chutes ---
dados_chutes <- dados_eventos %>%
  filter(Event_Type == "Chute")

p_heatmap_chutes <- ggplot(dados_chutes, aes(x = X_Coord, y = Y_Coord)) +
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
  scale_fill_viridis_c(option = "magma", name = "Densidade de Chutes") +
  
  # Divide o gráfico por time
  facet_wrap(~ Team, ncol = 3) +
  
  theme_pitch() +
  labs(
    title = "Heatmap de CHUTES (Finalizações) por Time",
    subtitle = "Foco na área de finalização e volume de ataque (Padrão UEFA)"
  ) +
  # Limite a visualização bem na área de ataque (X=70 a 105)
  coord_flip(xlim = c(70, 105), ylim = c(-5, 105))

print(p_heatmap_chutes)