# ANÁLISE OFENSIVA
cat("Realizando análise ofensiva...\n")
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
