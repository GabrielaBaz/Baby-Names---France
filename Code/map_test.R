
#library(rgdal)
world_spdf <- readOGR( 
        dsn= paste0(getwd(),"/data/world_shape_file/") , 
        layer="TM_WORLD_BORDERS_SIMPL-0.3",
        verbose=FALSE
)

par(mar=c(0,0,0,0))
plot(world_spdf, col="#f2f2f2", bg="skyblue", lwd=0.25, border=2 )

# 'fortify' the data to get a dataframe format required by ggplot2
library(broom)
library(maptools)
library(rgdal)
library(rgeos)
spdf_fortified <- broom::tidy(world_spdf, region = "NAME")

# Plot it
library(ggplot2)
ggplot() +
        geom_polygon(data = spdf_fortified, aes( x = long, y = lat, group = group), fill="#69b3a2", color="white") +
        theme_void() 

france=get_map(location = 'France', zoom = 4, language= "fr-FR", maptype="roadmap")

FranceFormes <- getData(name="GADM", country="FRA", level=0)
plot(FranceFormes, main="Carte de la France")

##############

#install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel", "ggspatial", 
 #                   "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
library(broom)
library(maptools)
library(rgdal)
library(ggspatial)
library(ggrepel)
library(rgeos)
library("ggplot2") 
library("sf") 
library("rnaturalearth") 
library("rnaturalearthdata") 

world <- ne_countries(scale = "medium", returnclass = "sf")
#class(world)

#ggplot(data = world) +
#        geom_sf() +
#        xlab("Longitude") + ylab("Latitude") +
#        ggtitle("France Metropolitan", subtitle = paste0("(", length(unique(world$NAME)), " regions)")) +
#        coord_sf(xlim = c(-6, 10), ylim = c(42,52), expand = FALSE)

spdf_france <- readOGR( 
        dsn= paste0(getwd(),"/Baby Names - France/data/france_shapefile/") , 
        layer="fr_10km",
        verbose=FALSE
)

spdf_france_dep <- readOGR( 
        dsn= paste0(getwd(),"/Baby Names - France/data/departements-20180101-shp/") , 
        layer="departements-20180101",
        verbose=FALSE
)

spdf_france_reg <- readOGR( 
        dsn= paste0(getwd(),"/Baby Names - France/data/regions-20180101-shp/") , 
        layer="regions-20180101",
        verbose=FALSE
)

france_reg <- st_as_sf(spdf_france_reg)

ggplot(data = world) +
        geom_sf() +
        geom_sf(data=france_reg) +
        coord_sf(xlim = c(-6, 10), ylim = c(42,52), expand = FALSE)

        
        xlab("Longitude") + ylab("Latitude") +
        ggtitle("France Metropolitan", subtitle = paste0("(", length(unique(world$NAME)), " regions)")) +


