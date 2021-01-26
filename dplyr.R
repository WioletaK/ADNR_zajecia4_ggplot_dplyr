#install.packages("DBI")
#install.packages("tidyverse",dependencies=TRUE)
#install.packages("nycflights13")
#install.packages("RSQLite")

library(DBI)
library(tidyverse)
library(nycflights13)
library(RSQLite)

?nycflights13

?flights
#year, month, day - Date of departure.
#dep_delay, arr_delay - Departure and arrival delays, in minutes. Negative times represent early departures/arrivals.
#dep_time, arr_time - Actual departure and arrival times (format HHMM or HMM), local tz.
#sched_dep_time, sched_arr_time - Scheduled departure and arrival times (format HHMM or HMM), local tz.
#dep_delay, arr_delay - Departure and arrival delays, in minutes. Negative times represent early departures/arrivals.
#carrier - wo letter carrier abbreviation. See airlines to get name.
#flight - Flight number.
#tailnum - Plane tail number. See planes for additional metadata.
#origin, dest - Origin and destination. See airports for additional metadata.
#air_time - Amount of time spent in the air, in minutes.
#distance - Distance between airports, in miles.
#hour, minute - Time of scheduled departure broken into hour and minutes.
#time_hour - Scheduled date and hour of the flight as a POSIXct date. Along with origin, can be used to join flights data to weather data.

View(flights)
class(flights)

?RSQLite

#Zadanie 0

#a) Połączyć się z serwerem MySQL,

#b) Przetestować polecenie select dla tabeli flights.

#c) Pobrać tabelę z serwera bazy danych mysql jako tibble.

#d) skopiować tabelę z R do bazy SQLITE

# Initialize a temporary in memory database and copy a data.frame into it
con <- dbConnect(RSQLite::SQLite(), ":memory:")
?data
data(flights)
dbWriteTable(con, "flights", flights)
dbListTables(con)
dbGetQuery(con, "SELECT * FROM flights limit 10")
# clean up
dbDisconnect(con)



class(flights)

drugiGrudnia <- filter(flights, month==12, day==2)
drugiGrudnia

flights$month <-
  factor(
    flights$month,
    levels=c(1,2,3,4,5,6,7,8,9,10,11,12),
    labels=c("January","February","March","April","May","June","July","August","September","October","November","December")
  )

flights

drugiGrudnia <- filter(flights, month=="December",day==2)
drugiGrudnia

daneZwakacji <- filter(flights, month=="July"|month=="August"|month=="September")
daneZwakacji

daneZwakacji <- filter(flights, flights$month %in% c("July","August","September"))
daneZwakacji

# Filtrując korzystamy z operatorów <.> , <=, >=, !=, ==
# Można też korzystać z operatorów logicznych i: &, lub: | i nie: !



#Zadania 1

#Ćwiczenia 1

#1. Znajdź wszystkie loty, które:
#a) Były opóźnione podczas przylotu co najmniej o dwie godziny.
opoznione_przyloty <- filter(flights, arr_delay>=120)
opoznione_przyloty

#b) Leciały do Houston (IAH lub HOU).
houston <- filter(flights, dest %in% c("IAH","HOU"))
houston

#c) Były obsługiwane przez linie United, American lub Delta.
airlines
uad <- filter(flights, carrier %in% c("UA","AA","DL"))
uad

#d) Odlatywały latem (w lipcu, sierpniu i wrześniu)
lato <- filter(flights, flights$month %in% c("July","August","September"))
lato

#e) Przyleciały z ponad dwugodzinnym opóźnieniem, ale nie odleciały opóźnione.
delay_only_arr <- filter(flights, arr_delay>=120 & dep_delay<=0)
delay_only_arr

#f) Były opóźnione o co najmniej godzinę, ale zrekompensowały opóźnienie o ponad 30 minut podczas lotu.
delay_dep <- filter(flights, dep_delay>=60 & dep_delay-arr_delay>30)
delay_dep

#g) Wyruszyły między północą a 6 rano (włącznie).
dep_night <- filter(flights, dep_time>=0 & dep_time<=600)
dep_night



?arrange
#arrange() orders the rows of a data frame by the values of selected columns.

arrange(flights,month,day)

arrange(flights,month,desc(day))



#Ćwiczenia 2

#1. Jak za pomocą funkcji arrange() posortować wszystkie brakujące wartości, tak aby znalazły się na początku?
#(Wskazówka: użyj funkcji is.na()).
?is.na
?flights
is.na(flights$time_hour) %>% unique()
anyNA(flights$air_time)

arrange(flights,
        desc(is.na(flights$dep_time)),
        desc(is.na(flights$arr_time)),
        desc(is.na(flights$dep_delay)),
        desc(is.na(flights$arr_delay)),
        desc(is.na(flights$tailnum)),
        desc(is.na(flights$air_time))
)

#2. Posortuj dane flights, aby znaleźć najbardziej opóźnione loty. Znajdź te, które odleciały najwcześniej.
arrange(flights, desc(dep_delay)) %>% head(10)
arrange(flights, dep_delay) %>% head(10)

#3. Posortuj dane flights, aby znaleźć najszybsze loty.
fastest <- arrange(flights, desc(distance/air_time)) %>% head(10)
View(fastest)

#4. Które loty trwały najdłużej? Które najkrócej?
time_max <- arrange(flights, desc(air_time)) %>% head(10)
View(time_max)
time_min <- arrange(flights, air_time, desc(distance)) %>% head(10)
View(time_min)

select(flights,month,day,dep_time,dep_delay,arr_time,arr_delay,tailnum)
select(flights,tailnum,month,day)
select(flights, month:tailnum)
select(flights, -(year:day))

#Funkcje pomocnicze funkcji select():
#starts_with("abc") wybiera nazwy rozpoczynające się od „abc”.
#ends_with("xyz") wybiera nazwy kończące się na „xyz”.
#contains("abc") wybiera nazwy zawierające „abc”.
#matches("”) wybiera zmienne pasujące do wyrażenia regularnego
#num_range("x", 1:3) pasuje do x1, x2 i x3.

?starts_with
select(flights,month,day,starts_with("dep"))

select(flights, dep_time, arr_time, everything())



#Ćwiczenia 3

#1. Wybierz wartości zmiennych dep_time, dep_delay, arr_time i arr_delay ze zbioru danych flights
select(flights, dep_time, dep_delay, arr_time, arr_delay)

#2. Co się stanie, gdy w wywołaniu select() kilkakrotnie wpiszesz nazwę tej samej zmiennej?
select(flights, year, month, day, month, day, dep_time, dep_delay, arr_time, arr_delay)
#Jeśli w wywołaniu select() kilkakrotnie wpiszemy nazwę tej samej zmiennej, ona na wyniku pojawi się tylko raz.

#3. Do czego służy funkcja one_of()? Dlaczego może się okazać przydatna razem z tym wektorem?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
vars2 <- c("year", "month", "day", "dep_time", "arr_time")
?dplyr::one_of
select(flights, one_of(vars,vars2))
#When called from inside selecting functions like dplyr::select() these are automatically set to the names of the table.



flights_small <- select(flights, ends_with("delay"), distance, air_time)
flights_small

mutate(flights_small, gain = dep_delay - arr_delay, speed=distance/air_time*60)
flights_small

# Operatory arytmetyczne +, -, *, /, ^
# Arytmetyka modulo(%/% i %%)
# %/% (dzielenie całkowite) i %% (reszta), gdzie x == y * (x %/% y) + (x %% y).



#Ćwiczenia 4

#1. Na podstawie zmiennej dep_time oblicz hour i minute.
my_flights <- select(flights, dep_time)
my_flights <- mutate(my_flights, hour=dep_time %/% 100, minute=dep_time %% 100)
View(my_flights)

#2. Przekształć dep_time i sched_dep_time, wyznaczając liczbę minut, jaka upłynęła od północy.
my_flights <- select(flights, dep_time, sched_dep_time)
my_flights <-
  mutate(my_flights,
         dep_min_midnight = (dep_time %/% 100)*60+dep_time %% 100,
         sched_dep_min_midnight = (sched_dep_time %/% 100)*60+sched_dep_time %% 100)
View(my_flights)


?transmute
#mutate() adds new variables and preserves existing ones;
#transmute() adds new variables and drops existing ones.
#New variables overwrite existing variables of the same name.
speedData <- transmute(flights_small, gain=dep_delay-arr_delay, speed=distance/air_time*60)
speedData
summarize(speedData, speadmean=mean(speed,na.rm=TRUE))

by_month <- group_by(flights, month)
summarize(by_month, meanMonthlyDelay=mean(dep_delay,na.rm=TRUE))

by_destination <- group_by(flights, dest)
View(by_destination)
delay <-
  summarize(by_destination, count=n(), dist=mean(distance,na.rm=TRUE), delay=mean(arr_delay, na.rm=TRUE))
View(delay)

delays<- flights %>%
  group_by(dest) %>% 
  summarize(count=n(),
            dist=mean(distance,na.rm=TRUE),
            delay=mean(arr_delay,na.rm=TRUE)
  )
View(delays)

opoznione <-
  flights %>%
  group_by(tailnum) %>%
  summarize(opoznienie=mean(arr_delay,na.rm=TRUE), n=n())
View(opoznione)

ggplot(data=opoznione, mapping=aes(x=n,y=opoznienie))+geom_point(alpha=1/8)+xlim(0,800)

flights %>%
  group_by(dest) %>%
  summarise(distance_sd=sd(distance,na.rm=TRUE)) %>%
  arrange(desc(distance_sd))

flights %>%
  group_by(year,month,day) %>%
  summarize(first=min(dep_time,na.rm=TRUE),last=max(dep_time,na.rm=TRUE))

flights %>%
  group_by(dest) %>%
  summarize(carriers = n_distinct(carrier,na.rm=TRUE)) %>%
  arrange(desc(carriers))

#Funkcje używane przy summarize():
# n() - zwraca rozmiar bieżącej grupy,
# sum(!is.na(x)) - obliczyzanie liczby niebrakujących wartości
# n_distinct(x) - sprawdzanie liczby unikatowych wartości

?count
#count() lets you quickly count the unique values of one or more variables
#wt:
#- If NULL (the default), counts the number of rows in each group.
#- If a variable, computes sum(wt) for each group.

#Suma mil, którą przeleciał każdy samolot:
flights %>% count(tailnum, wt=distance)

#Ile samolotów wyleciało przed 5 rano?
flights %>% count(dep_time<500)
flights %>%
  filter(dep_time<500) %>%
  summarize(poranneLoty = n())

#Jaka jest proporcja lotów opóźnionych o ponad jedną godzinę?
flights %>%
  mutate(flights, opozniony=(arr_delay>60)) %>%
  group_by(opozniony) %>%
  summarize(opoznienie=sum(opozniony,na.rm=TRUE), n=n()) %>%
  mutate(prop = opoznienie/sum(n)) %>%
  filter(opozniony==TRUE) %>%
  select(prop)

flights %>%
  mutate(flights, opozniony=(arr_delay>60)) %>%
  group_by(opozniony) %>%
  summarize(opoznienie=sum(opozniony,na.rm=TRUE), n=n()) %>%
  transmute(prop = opoznienie/sum(n)) %>%
  filter(prop>0)



#Ćwiczenia 5

#1. Rozważ następujące scenariusze i znajdź loty które:
#Lot jest o 15 minut za wcześnie przez 50% czasu, i o 15 minut za późno przez 50% czasu.

#Lot jest zawsze opóźniony o 10 minut.
?flights

#Lot jest zawsze opóźniony
flights %>%
  mutate(flights, opozniony=(arr_delay>0)) %>%
  group_by(origin, dest, opozniony) %>%
  summarize(loty_opoznione=sum(opozniony,na.rm=TRUE), n=n()) %>%
  group_by(origin, dest) %>%
  mutate(proc_opozn=loty_opoznione/sum(n)) %>%
  filter(proc_opozn==1) %>%
  select(origin, dest, loty_opoznione)
#Lot z JFK do JAC zawsze był opóźniony (było 2 takie loty).
#Sprawdzenie:
flights %>%
  filter(origin=="JFK" & dest=="JAC")
airports %>% filter(faa %in% c("JFK","JAC"))

#Lot jest zawsze opóźniony o 10 minut
flights %>%
  mutate(flights, opozniony=(arr_delay==10)) %>%
  group_by(origin, dest, opozniony) %>%
  summarize(loty_opoznione=sum(opozniony,na.rm=TRUE), n=n()) %>%
  group_by(origin, dest) %>%
  mutate(proc_opozn=loty_opoznione/sum(n)) %>%
  filter(proc_opozn==1) %>%
  select(origin, dest, loty_opoznione)
#Nie ma takich lotów, które zawsze byłyby opóźnione o 10 minut.

#A może chodzi o tailnum - plane tail number?
flights %>%
  mutate(flights, opozniony=(arr_delay==10)) %>%
  group_by(tailnum, opozniony) %>%
  summarize(loty_opoznione=sum(opozniony,na.rm=TRUE), n=n()) %>%
  group_by(tailnum) %>%
  mutate(proc_opozn=loty_opoznione/sum(n)) %>%
  filter(proc_opozn==1) %>%
  select(tailnum, loty_opoznione)

#Sprawdzenie:
flights %>% filter(tailnum=="N801AW")

#Lot jest o 30 minut za wcześnie przez 50% czasu i jest opóźniony o 30 minut przez 50% czasu.

#Przez 99% czasu lot jest zgodny z harmonogramem. Przez 1% czasu jest opóźniony o 2 godziny.

#Co jest ważniejsze: opóźnienie przylotu czy odlotu?
#Opóźnienie odlotu. Czy to pytanie podchwytliwe?

#Dla ramki bez anulowanych lotów:
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled

#2. Dla każdego samolotu oblicz liczbę lotów przed pierwszym opóźnieniem większym niż jedna godzina.
loty <- flights %>%
  mutate(flights, opozniony=(arr_delay>60)) %>%
  arrange(tailnum, dep_time)
View(loty)

#3. Do czego służy argument sort funkcji count()?
?count
#If TRUE, will show the largest groups at the top.
flights %>% count(dest, sort=TRUE)
#Kiedy można z niego skorzystać?
#Myślę, że zawsze. A kiedy nie można?
  
#4.Ile było lotów każdego dnia?
flights %>%
  group_by(year, month, day) %>%
  summarize(n=n())
  
#5.Ile było lotów każdego miesiąca?
flights %>%
  group_by(year, month) %>%
  summarize(n=n())
