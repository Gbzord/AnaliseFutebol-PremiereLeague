# VISUALIZAÇÃO 2: Criatividade vs Intensidade
p2 <- ggplot(analise, aes(x = criatividade_ofensiva, y = intensidade_ataque, label = Team)) +
  geom_point(aes(color = Gls), size = 4, alpha = 0.7) +
  geom_text_repel(size = 3) +
  scale_color_gradient(low = "red", high = "black", name = "Gols") +
  labs(title = "Criatividade vs Intensidade Ofensiva",
       subtitle = "Como os times criam oportunidades",
       x = "Criatividade Ofensiva (Ast + Passes Prog. por jogo)",
       y = "Intensidade de Ataque (Ações no terço final por jogo)") +
  theme_minimal()

print(p2)
