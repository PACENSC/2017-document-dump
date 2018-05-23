teamsum <- read.csv("~/Downloads/convertcsv.csv")
teamsum$Bracket <- rep(c("Birch","Willow","Pine","Hemlock",
                         "Cedar","Dogwood","Magnolia","Ash",
                         "Oak","Elm","Maple","Chestnut"), each = 8)
library(dplyr)
teamsum <- teamsum %>% arrange(Bracket)
# plot_ly(teamsum, x = ~PPG, y = ~X20, text = ~paste0(Team, " (", Bracket, ")"), color = ~Bracket, size =.1,  sizes = c(10, 10))
# plot_ly(teamsum, x = ~Bracket, y = ~P.B, type = "box", boxpoints = "all", pointpos = 0 )

ppb <- plot_ly(teamsum, type = "box") %>%
  add_trace(y = ~P.B, color = ~Bracket, boxpoints = 'all', pointpos = 0, marker = list(color = 'rgb(7,40,89)'),
              line = list(color = 'rgb(7,40,89)')) %>% layout (title = "PPB by prelim bracket", showlegend = F)
ppg <- plot_ly(teamsum, type = "box") %>%
  add_trace(y = ~PPG, color = ~Bracket, boxpoints = 'all', pointpos = 0, marker = list(color = 'rgb(7,40,89)'),
            line = list(color = 'rgb(7,40,89)')) %>% layout (title = "PPG by prelim bracket", showlegend = F)

ppb
ppg

teamsum <- teamsum %>% arrange(Team)
teamdetail <- read.csv("~/Downloads/teamdet.csv")
pledetail <- read.csv("~/Downloads/playerdet.csv")
teamdetail$Team1 <- rep(unique(pledetail$Individuals), each = 7)
teamdetail$Round <- rep(1:7, 96)
teamdetail$Bracket <- rep(teamsum$Bracket, each = 7)
teamdetail <- teamdetail %>% select(Round, Team1, Bracket, Team2:PBB)

# plot_ly(teamdetail, y = ~PB, x = ~Round, text = ~Team1, mode = "markers")# + add_trace(y = ~PB, x = ~Round, mode = "lines")



pp <- ggplot(data = teamdetail) + facet_wrap(~Bracket)  +  geom_point(aes(y = PB, x = Round, color = Team1)) +geom_line(aes(y = PB, x = Round, colour = Team1))  
pp2 <- pp +  theme(legend.position="none")
ggplotly(pp2) 
