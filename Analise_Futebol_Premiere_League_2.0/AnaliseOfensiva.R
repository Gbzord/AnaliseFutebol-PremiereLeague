
# ANÁLISE OFENSIVA
cat("Realizando análise ofensiva...")
analise <- dados_equipes %>%
  mutate(
    eficiencia_finalizacao = round(Gls / xG, 2),
    criatividade_ofensiva = round((Ast + PrgP) / MP, 1),
    intensidade_ataque = round(Att_3rd / MP, 1),
    eficiencia_passes = round(PrgP / Att_3rd * 100, 1)
  ) %>%
  select(Team, Gls, xG, eficiencia_finalizacao, criatividade_ofensiva, 
         intensidade_ataque, eficiencia_passes) %>%
  arrange(desc(Gls))


print(analise)


cat(" Análise Ofensiva Efetuada Com Sucesso !")

# VISUALIZAÇÃO 1: xG vs Gols
cat("📈 Criando visualizações...\n")
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
  theme(legend.position = "none")
  theme(plot.title = element_text(face = "bold"))

print(p1)

cat(" Visualização : Eficiência ofensiva (xG vs Gols)")

# VISUALIZAÇÃO 2: Criatividade vs Intensidade
p2 <- ggplot(analise, aes(x = criatividade_ofensiva, y = intensidade_ataque, label = Team)) +
  geom_bar(aes(fill = Gls), stat = 'identity') +
  geom_text_repel(size = 3) +
  scale_color_gradient(low = "blue", high = "red", name = "Gols") +
  labs(title = "Criatividade vs Intensidade Ofensiva",
       subtitle = "Como os times criam oportunidades",
       x = "Criatividade Ofensiva (Ast + Passes Prog. por jogo)",
       y = "Intensidade de Ataque (Ações no terço final por jogo)") +
  theme_minimal()+
  theme(legend.position = "none")

print(p2)

cat(" Criatividade vs Intensidade\n")