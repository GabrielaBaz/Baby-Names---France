
.homeFiles <- "/Users/gabrielabazan/Data Projects/Baby Names - France/"

#Import Data

#Names database - CSV
baby.names <- data.table::fread(paste0(.homeFiles,"Data/dpt2018.csv"))
names(baby.names) <- c("sex","name","year","dep","countof")
View(head(baby.names))

#Department reference table - XLS
departments <- readxl::read_excel(paste0(.homeFiles,"Data/departements-francais.xls"))
names(departments) <- c("dep","dep_name","region",
               "chef_lieu","superficie","population",
               "density")

#The year field has a value XXXX that needs to be reviewed
baby.names %>%
        group_by(year) %>%
        tally() -> count_by_year
#~36K records have the XXXX values, since it's 1%, I will drop those records
baby.names %>%
        dplyr::filter(.,year != 'XXXX') %>%
        dplyr::filter(.,name != '_PRENOMS_RARES')-> baby.names

#check for null values in all columns
#sum(is.na(baby.names$countof))

#bring the department and region name to the baby.names table
baby.names %>%
        left_join(.,departments,by="dep") %>%
        select(.,sex,name,year,countof,dep,dep_name,region) -> baby.names
#View(baby.names)

#Leave the Top 10 by year
baby.names %>%
        group_by(sex,year) %>%
        top_n(n = 10, wt = countof) -> top10.names




