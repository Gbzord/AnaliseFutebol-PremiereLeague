# ANÁLISE DEFENSIVA
cat(" Analisando métricas defensivas...\n")
analise_defesa <- dados_equipes %>%
  mutate(
    intensidade_pressing = round(Press / MP, 1),
    eficiencia_defensiva = round(PPDA, 1)  # PPDA mais baixo = pressing mais eficiente
  ) %>%
  select(Team, PPDA, intensidade_pressing, eficiencia_defensiva) %>%
  arrange(PPDA)  # Ordenar do menor PPDA (melhor defesa) para o maior

print(analise_defesa)

cat(" Análise defensiva (Pressing)\n")
# VISUALIZAÇÃO 3: Análise Defensiva
p3 <- ggplot(analise_defesa, aes(x = intensidade_pressing, y = PPDA, label = Team)) +
  geom_point(aes(size = eficiencia_defensiva, color = PPDA), alpha = 0.7) +
  geom_text_repel(size = 3) +
  scale_color_gradient(low = "green", high = "red", name = "PPDA") +
  labs(title = "Análise de Pressing e Eficiência Defensiva",
       subtitle = "PPDA mais baixo = defesa mais eficiente | Bolhas menores = melhor",
       x = "Intensidade de Pressing (ações por jogo)",
       y = "PPDA (Passes por Ação Defensiva)") +
  theme_minimal()

print(p3)

