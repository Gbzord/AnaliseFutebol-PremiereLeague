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
  theme(plot.title = element_text(face = "bold"))

print(p1)

# VISUALIZAÇÃO 2: Criatividade vs Intensidade
p2 <- ggplot(analise, aes(x = criatividade_ofensiva, y = intensidade_ataque, label = Team)) +
  geom_point(aes(color = Gls), size = 4, alpha = 0.7) +
  geom_text_repel(size = 3) +
  scale_color_gradient(low = "blue", high = "red", name = "Gols") +
  labs(title = "Criatividade vs Intensidade Ofensiva",
       subtitle = "Como os times criam oportunidades",
       x = "Criatividade Ofensiva (Ast + Passes Prog. por jogo)",
       y = "Intensidade de Ataque (Ações no terço final por jogo)") +
  theme_minimal()

print(p2)

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

cat("Análise concluída com sucesso!\n")
cat("Foram geradas 3 visualizações principais:\n")
cat("   1. Eficiência ofensiva (xG vs Gols)\n")
cat("   2. Criatividade vs Intensidade\n")

cat("   3. Análise defensiva (Pressing)\n")
