library(ggplot2)
library(dplyr)
glimpse(diamonds)
#1
diamonds %>% ggplot(aes(cut)) +geom_bar()
#2
diamonds %>% ggplot(aes(cut)) +geom_bar() + coord_polar("y")
#3
diamonds %>% ggplot(aes(carat, fill=color)) + geom_histogram()
diamonds %>% ggplot(aes(carat, fill=color)) + geom_histogram(position="dodge")
#4
diamonds %>% ggplot(aes(carat, price))+geom_point()
#5
diamonds %>% filter(carat>=3) %>% ggplot(aes(carat, price, color=clarity, size=cut))+geom_point()
