## ------------------------------------------------------------------------
library("tidyverse")
library("dplyr")
library("tidyr")
library("readr")

survey <- read_csv("https://raw.githubusercontent.com/introdsci/MusicSurvey/master/music-survey.csv")
prefernces <- read_csv("https://raw.githubusercontent.com/introdsci/MusicSurvey/master/preferences-survey.csv")


## ------------------------------------------------------------------------
colnames(survey)[colnames(survey)=="Timestamp"] <- "time_submitted"

colnames(survey)[colnames(survey)=="First, we are going to create a pseudonym for you to keep this survey anonymous (more or less). Which pseudonym generator would you prefer?"] <- "pyseudonym_generator"

colnames(survey)[colnames(survey)=="What is your pseudonym?"] <- "pseudonym"

colnames(survey)[colnames(survey)=="Sex"] <- "sex"

colnames(survey)[colnames(survey)=="Major"] <- "academic_major"

colnames(survey)[colnames(survey)=="Academic Year"] <- "academic_level"

colnames(survey)[colnames(survey)=="Year you were born (YYYY)"] <- "year_born"

colnames(survey)[colnames(survey)=="Which musical instruments/talents do you play? (Select all that apply)"] <- "instrument_list"

colnames(survey)[colnames(survey)=="Artist"] <- "favorite_song_artist"

colnames(survey)[colnames(survey)=="Song"] <- "favorite_song"

colnames(survey)[colnames(survey)=="Link to song (on Youtube or Vimeo)"] <- "favorite_song_link"


## ------------------------------------------------------------------------
Person <- tibble(time_submitted=survey$time_submitted, pyseudonym_generator=survey$pyseudonym_generator, psyeudonym=survey$pseudonym, sex=survey$sex, academic_major=survey$academic_major, academic_level=survey$academic_level, year_born=survey$year_born, instruments=survey$instrument_list)


## ------------------------------------------------------------------------
FavoriteSong <- tibble(psyeudonym=survey$pseudonym, artist=survey$favorite_song_artist, song=survey$favorite_song, song_link=survey$favorite_song_link)


## ------------------------------------------------------------------------
temp <- gather(prefernces, key = "artist_song", value = "rating", 3:45)
Ratings <- tibble(psyeudonym=temp$`What was your pseudonym?`, artist_song=temp$artist_song, rating=temp$rating)


## ------------------------------------------------------------------------
Person$time_submitted <- as.POSIXlt(parse_datetime(Person$time_submitted, format="%m/%d/%y %H:%M"))


## ------------------------------------------------------------------------
Person$pyseudonym_generator <- as.factor(Person$pyseudonym_generator)
Person$sex <- as.factor(Person$sex)
Person$academic_level <- as.factor(Person$academic_level)
Person$academic_major <- as.factor(Person$academic_major)
levels(Person$academic_major)[levels(Person$academic_major)=="Computer information systems"] <- "Computer Information Systems"

