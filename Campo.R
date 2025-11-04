library(ggsoccer)

# Define o padrão de campo da UEFA Categoria 4
DIMENSOES_UEFA <- pitch_international

# Adaptação pra dados do Campo
analise <- data.frame(
   Team = c("Man city", "Arsenal", "West Ham"),
   criatividade_ofensiva = c(25.7, 23.7, 18.2),
   intensidade_ataque = c(32.9, 31.6, 25.0),  Gls = c(94,  88, 55)
   )

dados_campo_uefa <- analise %>% 
  mutate(
    # Posição central de referência (no terço final do campo)
    x = 83,
    y = 50,
    # Ajuste o tamanho do ponto pela Intensidade de Ataque
    tamanho_ponto = 2 + (intensidade_ataque - min(intensidade_ataque)) /
      (max(intensidade_ataque) - min(intensidade_ataque)) * 5
  )


#Visualização Do Campo

p_uefa <- ggplot(dados_campo_uefa, aes(x = x, y = y)) +
  # Adiciona o campo de futebol com as dimensões UEFA
  annotate_pitch(
    dimensions = DIMENSOES_UEFA,
    fill = "#377d22",
    colour = "white",
    # O ataque será da esquerda para a direita (X=0 para X=100)
  ) +
  
  # Adiciona os dados como pontos
  geom_point(
    aes(size = tamanho_ponto, color = criatividade_ofensiva),
    alpha = 0.8,
    stroke = 1.5
  ) +
  
  # Adiciona os rótulos dos times
  geom_text_repel(
    aes(label = Team),
    color = "white",
    size = 4,
    box.padding = 0.5,
    point.padding = 0.5,
    nudge_x = 5,
    segment.color = 'gray'
  ) +
  
  # Define a escala de cores (para Criatividade - Mantendo seu padrão de cor)
  scale_colour_gradient(
    low = "blue",
    high = "red",
    name = "Criatividade Ofensiva"
  ) +
  
  # Define a escala de tamanhos (para Intensidade)
  scale_size(
    name = "Intensidade de Ataque"
  ) +
  
  # Aplica o tema do ggsoccer
  theme_pitch() +
  theme(legend.position = "none")+
  
  # Adiciona títulos
  labs(
    title = "Criatividade vs Intensidade Ofensiva - Padrão UEFA",
    subtitle = "Tamanho do Ponto = Intensidade de Ataque | Cor do Ponto = Criatividade Ofensiva"
  ) +
  
  # Foca apenas no campo de ataque para dar contexto (opcional, mas recomendado)
  coord_flip(xlim = c(50, 105), ylim = c(-5, 105)) # De 50 a 100 é o campo de ataque

print(p_uefa)