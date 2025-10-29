# VISUALIZAÇÃO 1: xG vs Gols
cat(" Criando visualizações...\n")
p1 <- ggplot(analise, aes(x = xG, y = Gls, label = Team)) +
  geom_point(aes(size = eficiencia_finalizacao, color = eficiencia_finalizacao), alpha = 0.7) +
  geom_text_repel(size = 3) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", alpha = 0.5) +
  scale_color_gradient2(low = "red", mid = "yellow", high = "green", midpoint = 1) +
  labs(title = "Relação entre xG e Gols Reais - Premier League 23/24",
       subtitle = "Tamanho e cor representam eficiência de finalização (Gols/xG)",
       x = "xG Esperado", y = "Gols Marcados",
       color = "Eficiência", size = "Eficiência") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))


print(p1)
