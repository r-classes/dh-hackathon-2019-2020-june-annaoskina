library(tidyverse)
library(rvest)
library(lubridate)
messages1 <- read_html("https://raw.githubusercontent.com/r-classes/dh-hackathon-2019-2020-june-annaoskina/master/messages.html")
messages2 <- read_html("https://raw.githubusercontent.com/r-classes/dh-hackathon-2019-2020-june-annaoskina/master/messages2.html")

messages1 %>% 
  html_nodes("div.body") %>%
  html_text -> one

messages2 %>% 
  html_nodes("div.body") %>% 
  html_text -> two

two %>% 
  enframe() %>%
  mutate(date = str_extract(value, "[1-3]?[0-9]\\s[a-zA-Z]{3,9}\\s20[12][0-9]")) %>%
  fill(date) -> two_df

one %>% 
  enframe() %>%
  mutate(date = str_extract(value, "[1-3]?[0-9]\\s[a-zA-Z]{3,9}\\s20[12][0-9]")) %>%
  fill(date) %>% 
  mutate(text = str_match(""))

one_df$value[1:20] %>%
  str_match("(?:(?:Овен)|(?:ОВЕН))(.*)(?:(?:Телец)|(?:ТЕЛЕЦ))") %>%
  as_tibble() %>%
  select(2)

one_df%>%
  str_match("(?:Гороскоп\\sна)(.*)(?:(?:Овен)|(?:ОВЕН))(.*)(?:(?:Телец)|(?:ТЕЛЕЦ))(.*)(?:(?:Близнецы)|(?:БЛИЗНЕЦЫ))(.*)(?:(?:Рак)|(?:РАК))(.*)(?:(?:Лев)|(?:ЛЕВ))(.*)(?:(?:Дева)|(?:ДЕВА))(.*)(?:(?:Весы)|(?:ВЕСЫ))(.*)(?:(?:Скорпион)|(?:СКОРПИОН))(.*)(?:(?:Стрелец)|(?:СТРЕЛЕЦ))(.*)(?:(?:Козерог)|(?:КОЗЕРОГ))(.*)(?:(?:Водолей)|(?:ВОДОЛЕЙ))(.*)(?:(?:Рыбы)|(?:РЫБЫ))(.*)") %>%
  as_tibble()->one_new %>%
  na.omit -> one_new
  #set_names(3:14, "Oven", "Telets", "Bliznetsy", "Rak", "Lev", "Deva", "Vesy", "Skorpion", "Strelets", "Kozerog", "Vodoley", "Ryby") %>%  -> one_new

two_df %>% 
  str_match("(?:Гороскоп\\sна)(.*)(?:(?:Овен)|(?:ОВЕН))(.*)(?:(?:Телец)|(?:ТЕЛЕЦ))(.*)(?:(?:Близнецы)|(?:БЛИЗНЕЦЫ))(.*)(?:(?:Рак)|(?:РАК))(.*)(?:(?:Лев)|(?:ЛЕВ))(.*)(?:(?:Дева)|(?:ДЕВА))(.*)(?:(?:Весы)|(?:ВЕСЫ))(.*)(?:(?:Скорпион)|(?:СКОРПИОН))(.*)(?:(?:Стрелец)|(?:СТРЕЛЕЦ))(.*)(?:(?:Козерог)|(?:КОЗЕРОГ))(.*)(?:(?:Водолей)|(?:ВОДОЛЕЙ))(.*)(?:(?:Рыбы)|(?:РЫБЫ))(.*)") %>%
  as_tibble() -> two_new


one_df %>% 
  mutate(oven = str_match(value, "(?:ОВЕН)(.*)(?:(?:Телец))")) %>%
  fill(oven)
  

two %>% 
  enframe() %>%
  mutate(date = str_extract(value, "[1-3]?[0-9]\\s[a-zA-Z]{3,9}\\s20[12][0-9]")) %>%
  fill(date) -> frame_two


one_df$value %>%
  str_match("(?:Гороскоп\\sна)(.*)(?:(?:Овен)|(?:ОВЕН))(.*)(?:(?:Телец)|(?:ТЕЛЕЦ))(.*)(?:(?:Близнецы)|(?:БЛИЗНЕЦЫ))(.*)(?:(?:Рак)|(?:РАК))(.*)(?:(?:Лев)|(?:ЛЕВ))(.*)(?:(?:Дева)|(?:ДЕВА))(.*)(?:(?:Весы)|(?:ВЕСЫ))(.*)(?:(?:Скорпион)|(?:СКОРПИОН))(.*)(?:(?:Стрелец)|(?:СТРЕЛЕЦ))(.*)(?:(?:Козерог)|(?:КОЗЕРОГ))(.*)(?:(?:Водолей)|(?:ВОДОЛЕЙ))(.*)(?:(?:Рыбы)|(?:РЫБЫ))(.*)") %>%
  as_tibble() -> one_new

one_new %>% 
  mutate(date = str_extract(V2, "[1-3]?[0-9]\\s[а-яА-Я]{3,9}")) %>% 
  fill(date) -> frame_with_data
  
frame_with_data %>% 
  select(3:15) %>% 
  na.omit() -> frame_with_data
           
frame_with_data %>% 
  write_tsv("hackathon.tsv")
  ggplot(aes(data, ))
  

  