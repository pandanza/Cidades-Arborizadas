setwd("C:/R/SA/siga_planejamento_infraestrutura_domicilio_arborizacao")
dir()

library(sf) # formato espacial e CRS (Coordinate Reference Systems)
library(tmap) # mapa tem√°tico e interativo

a <- read_sf("siga_planejamento_infraestrutura_domicilio_arborizacao.shp")
a <- as.data.frame(a)
a$porcentagem <- a$porcento_d / 100
a <- st_as_sf(a)
a <- st_set_crs(a, 31983)
plot(st_geometry(a))

# mapa tem√°tico

tm_polygons( )+ tm_grid( )
tm_shape(a) + 
  tm_grid(alpha = 0.3, labels.rot = c(0,90), labels.inside.frame = FALSE) + 
  tm_fill(col = "porcento_d", style = "jenks", palette = "viridis", title = "Percentual por bairro, SA") +
  tm_compass(position = c("right","top")) + tm_scale_bar() + 
  tm_credits("Datum: SIRGAS 2000 // ProjeÁ„o: UTM 23S // Fonte dos dados: siga.santoandre.sp.gov.br // Daniela - blog Reciclarte") +
  tm_layout(main.title = "Percentual de domicÌlios com arborizaÁ„o", main.title.position = "center", outer.margins = 0.05)

# mapa interativo

tmap_mode("view")
tm_shape(a) +
tm_borders(alpha = NA) +
tm_fill(id = "NA",
        col = "porcento_d",
        palette = "viridis",
        popup.vars=c("Bairro:"="bairro", 
                     "Taxa de domicÌlios com arborizaÁ„o:"="porcentagem"),
        title = "% de domicÌlios com arborizaÁ„o") +
tm_layout(title = "Percentual de domicÌlios com arborizaÁ„o<br>por bairro em Santo AndrÈ") +
tmap_options(check.and.fix = TRUE)

### salvar arquivo HTML: 'export' >> 'save as web page' >> nome_do_arquivo.html




