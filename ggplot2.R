#Wizualizacja danych za pomocą ggplot2

#install.packages(”tidyverse”)
library(tidyverse)

#Skorzystamy z ramki mpg danych zawartych w pakiecie ggplot:

?mpg

#A data frame with 234 rows and 11 variables:
#manufacturer - manufacturer name
#model - model name
#displ - engine displacement, in litres (pojemnosc silnika)
#year - year of manufacture
#cyl - number of cylinders
#trans - type of transmission
#drv - the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd (typ napedu)
#cty - city miles per gallon (mile przejechane w miescie na gilon paliwa)
#hwy - highway miles per gallon (mile przejechane na autostradzie na gilon paliwa)
#fl - fuel type
#class -"type" of car

#Spróbujmy odpowiedzieć na pytanie jaka jest zależność pomiędzy pojemnością silnika a wykorzystaniem paliwa?
#Czy silniki z dużą pojemnością silnika wykorzystują więcej paliwa niż te z małą?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#Co stanie się jeżeli użyjemy tylko samej funkcji ggplot(data = mpg)?

ggplot(data = mpg)
#Widzimy pusty wykres, na który możemy nakładać warstwy.

ggplot(data = mpg) + geom_point()
#Utworzyla nam się warstwa z wykresem punktowym.



#Ćwiczenia 1

#1. Co widzimy po wywołaniu polecenia ggplot(data = mpg)
#Widzimy pusty wykres, na który możemy nakładać warstwy.

#2. Ile wierszy i kolumn znajduje się w zbiorze danych mtcars?
?mtcars
#A data frame with 32 observations on 11 (numeric) variables..
#W data frame mtcars znajduje sie 32 wiersze i 11 kolumn.

#3. Czym jest zmienna drv z ramki danych mpg?
?mpg
#drv - the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
#Zmienna drv w df mpg ozna99
#4. Wykonaj wykresy zależności pomiędzy zmiennymi cty i cyl oraz hwy i cyl
ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))

#5. Wykonaj wykres punktowy zależności pomiędzy class i drv. Co widzimy?
ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = drv))
#Na podstawie tego wykresu widzimy jakie klasy pojazdu wystepuja w df z jakim rodzajem napedu.



ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))

#Przeskaluj zmienną class na estetykę alpha, rozmiar (size) oraz kształt (shape)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#Co ciekawego widzimy?
#Powyzsze estetyki decyduja o tym w jaki sposob na wykresie beda wyroznione poszczegolne wartosci kolumny class.

#Czy x i y też są estetyką? Jeżeli tak to gdzie jest legenda?
?aes
#The names for x and y aesthetics are typically omitted because they are so common; all other aesthetics must be named.
#Tak, x i y to rowniez estetyki. Ich nazwy i wartosci sa na osiach x i y wykresu.

#Co stanie się jeżeli umieścimy którąś z poznanych estetyk poza funkcją aes?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = class)
#Jesli statystyke umiescimy poza funkcja aes, pojawi sie blad.

#A co jeżeli zamiast nazwy klasy użyjemy np. nazwy koloru?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = "red"))

#Poza funkcją aes można też uzyć rozmiaru punktów w milimetrach oraz kształtu punktu jako liczba.
?geom_point
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 3)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 1.5)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 1.5, shape = 1)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 1.5, shape = 2)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class), size = 1.5, shape = 10)



#Ćwiczenia 2

#1.W którym miejscu tego kodu znajduje się błąd? Dlaczego punkty nie są zielone?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty, color="green"))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty, color="blue"))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty, color="abc"))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty, color=1))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty, color=3))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty, color=0))

ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty), color="green")
ggplot(data = mpg) + geom_point(mapping = aes(x = displ,y=cty), color="violet")
#Kolor wykresu powinien byc ustawiony poza funkcja aes.

#2.Które zmienne ze zbioru mpg są kategorialne? Które zmienne są ciągłe?
#(Wskazówka: wpisz ?mpg, aby przeczytać dokumentację tego zbioru danych).
?mpg
#Zmienne kategorialne: manufacturer, model, year, cyl, trans, drv, fl, class
#Zmienne ciagle: displ, cty, hwy
class(mpg$manufacturer)
mpg$manufacturer
mpg$displ
mpg$cty

#3.Zmapuj zmienną ciągłą na estetykę color, size i shape. Na czym polega różnica w zachowaniu
#tych estetyk w przypadku zmiennych kategorialnych i ciągłych?
ggplot(data = mpg) + geom_point(mapping = aes(x = manufacturer, y=displ, color=cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = manufacturer, y=displ, size=cty))
ggplot(data = mpg) + geom_point(mapping = aes(x = manufacturer, y=displ, shape=cty))
#W przypadku zmiennych kategorialnych, liczba roznych wartosci estetyk dppasowuje sie do liczby roznych wartosci zmiennych.
#W przypadku zmiennych ciaglych, estetyka przyjmuje wartosci ze skali.
#Zmiennej ciagles nie da sie ustawic na estetyke shape.

#4.Co się stanie, jeśli zmapujesz tę samą zmienną na wiele estetyk?
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class, size = class, shape = class))
#Kazda wartosc zmiennej otrzyma inna ceche kazdej estetyki.

#5.Do czego służy estetyka stroke? Z jakimi kształtami można jej użyć?
#(Wskazówka: skorzystaj z polecenia ?geom_point).
?geom_point
# For shapes that have a border (like 21), you can colour the inside and
# outside separately. Use the stroke aesthetic to modify the width of the
# border
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color=class), shape=21, fill="white", size=2, stroke=2)
#Estetyka stroke sluzy do modyfikowania grubosci granicy ksztaltu znacznikow na wykresie.
#Mozna jej uzywac z ksztaltami, ktore mają granice.

#6.Co się stanie, jeśli zmapujesz estetykę na coś innego niż nazwa zmiennej,
#jak na przykład aes(color = displ < 4)?
ggplot(data=mpg) + geom_point(mapping = aes(x=displ, y=hwy, color=displ < 4))
#disp<4 potraktuje jak warunek logiczny i podzieli na 2 grupy (FALSE/TRUE), każdej nada inny kolor.



#Tworzenie paneli na wykresie:
#Dla jednej zmiennej
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty)) +
  facet_wrap(~ class, nrow=3)

#Dla dwóch zmiennych
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

#Zmienną możemy zastąpić kropką
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#To samo otrzymamy w ten sposób:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cyl, nrow=1)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cyl)



#Ćwiczenia 3

#1. Co się stanie jeżeli podzielimy wykres na panele używając zmiennej ciągłej?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty)) +
  facet_wrap(~ class)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty)) +
  facet_wrap(~ cty)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty)) +
  facet_wrap(~ displ)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty)) +
  facet_wrap(~ hwy)
#W przypadku podziału na panele przy użyciu zmiennej ciągłej, powstanie tyle wykresów, ile różnych watości przyjmie ta zmienna.

#2. Co oznaczają puste komórki na wykresie:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
#Puste komórki na wykresie oznaczają, że w zbiorze nie ma obserwacji dla danego przeciecia zmiennych,
#np. w df mpg nie ma pojazdów z napędem na 4 kola i 5 cylindrami ani z napędem na tylne kola i 4-5 cylindrami.
#Jaka jest zależność wględem tego wykresu:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))
#Na tym wykresie rownież możemy to zaobserwować.
#Tutaj widać też na osi y liczbę 7, chociaż nie ma żadnej obserwacji z taką liczbą cylindrów.
#Nie widać tu za to ile jest obserwacji na każdym przecięciu zmiennych drv~cyl, co było widoczne na poprzednim wykresie.

#3. Jakie wykresy powstaną po uruchomieniu polecenia poniżej? Do czego służy znak „.”?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
#Po uruchomieniu powyższego kodu powstaną 3 wykresy zależności displ~hwy, dla każdej z trzech wartości zmiennej drv.
#Wykresy będą horyzontalnie (poziomo).
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ drv)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ drv)
#Gdy chcemy wykresy wertykalnie (pionowo), należy lekko zmodyfikować argumenty funkcji facet_grid lub użyć funkcji facet_wrap.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#Po uruchomieniu powyższego kodu powstaną 4 wykresy zależności displ~hwy, dla każdej z czterech wartości zmiennej cyl.
#Wykresy będą wertykalnie (pionowo).

#4. Jakie korzyści daje używanie paneli zamiast estetyk?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class, size = drv))
#W przypadku użycia paneli możemy patrzeć jednocześnie na 4 kolumny. KAżde z przecięć widzimy na osobnym wykresie.
#W przypadku użycia statystyk możemy próbować patrzeć na kilka zmiennych jednocześnie, jednak wykres jest tylko 2D,
#więc trzecia i czwarta zmienna mogą wyróżniać się tylko jakąś cechą na wykresie, np. kolorem, kształtem, wielkością znacznika.
#Jeśli liczba obserwacji z 2 zmiennych użytych do określenia cech (inne niz x i y) będą miały taką samą liczbę obs. w zbiorze,
#to jedna zakryje drugą i ich nie zobaczymy.

#5. Do czego służy argument nrow i ncol ? Jakie inne opcje kontrolują układ poszczególnych paneli?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, ncol = 3)
#Argumenty nrow i ncol służą do określenia w ilu rzędach i kolumnach wyświetlić wykresy.




ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, alpha = drv))
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, size = drv))
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, shape = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes (x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth()

ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv, shape=drv, linetype=drv)) +
  geom_point() +
  geom_smooth()

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(mapping=aes(color=drv))

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(color=class))+
  geom_smooth(data=filter(mpg,class=="suv"), color="deeppink", se=FALSE)
#demo("colors")



#Ćwiczenia 4

#1. Jakiej geometrii użyjesz, aby narysować wykres liniowy? Wykres pudełkowy? Histogram? Wykres warstwowy?
ggplot(data = mpg) + geom_line(mapping = aes (x = displ, y = hwy))
ggplot(data = mpg) + geom_line(mapping = aes (x = displ, y = hwy, color = class))
ggplot(data = mpg) + geom_boxplot(mapping = aes (x = displ, y = hwy, group = class))
ggplot(data = mpg) + geom_boxplot(mapping = aes (x = displ, y = hwy, group = class, color = class))
ggplot(data = mpg) + geom_histogram(mapping = aes (x = displ), binwidth = .5)
ggplot(data = mpg) + geom_histogram(mapping = aes (x = displ, color = class), binwidth = .5)
ggplot(data = mpg, aes (x = hwy)) +
  geom_area(mapping = aes (y=..density.., fill=class), stat = "bin", alpha=0.6)

#2. Spróbuj przewidzieć działanie polecenia poniżej. Następnie sprawdź czy miałeś rację uruchamiajac je.
ggplot(data = mpg, mapping = aes( x = displ, y = hwy, color = drv))+
  geom_point()+
  geom_smooth(se = FALSE)
#Na osi X - displ, na osi Y - hwy, dla każdej wartości drv (3 rodzaje napędu) - inne kolory na obydwu wykresach.
#Dwa wykresy - punktowy i linia wygładzana (bez przedziału ufności dookoła niej).

#3. Do czego służy kod show.legend = FALSE?
ggplot(data = mpg, mapping = aes( x = displ, y = hwy, color = drv)) +
  geom_point(show.legend = FALSE) +
  geom_smooth(se = FALSE, show.legend = FALSE)
#Używa się go, aby nie pokazywać legendy na wykresie.

#4. Do czego służy argument se w funkcji geom_smooth()?
?geom_smooth()
#Argument se służy do wyświetlania przedziału ufności dookoła lini.

#5. Czy te dwa wykresy są inne? Dlaczego?
ggplot(data = mpg , mapping = aes( x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
#Które dwa wykresy? Punktowy i linia wygładzająca z przedziałem ufności?
#Są inne. Punkty pokazują dokładne dane, a linia próbuje jak najlepiej się do nich dopasować.

#6. Odtwórz kod R potrzebny do wygenerowania następujących wykresów:
ggplot(data=mpg, mapping=aes(x=displ,y=hwy)) +
  geom_point() +
  geom_smooth(se=FALSE)
ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth(aes(shape=drv), se=FALSE)
ggplot(data=mpg, mapping=aes(x=displ, y=hwy, color=drv)) +
  geom_point() +
  geom_smooth(se=FALSE)
ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point(aes(color=drv)) +
  geom_smooth(se=FALSE)
ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point(aes(color=drv)) +
  geom_smooth(aes(linetype = drv), se=FALSE)
?geom_point
ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point(color="white", size=5) +
  geom_point(aes(color=drv), size=2)



?diamonds
#A data frame with 53940 rows and 10 variables:
#price - price in US dollars (\$326–\$18,823)
#carat - weight of the diamond (0.2–5.01)
#cut - quality of the cut (Fair, Good, Very Good, Premium, Ideal)
#color - diamond colour, from D (best) to J (worst)
#clarity - a measurement of how clear the diamond is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best))
#x - length in mm (0–10.74)
#y - width in mm (0–58.9)
#z - depth in mm (0–31.8)
#depth - total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)
#table - width of top of diamond relative to widest point (43–95)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

?geom_bar
#geom_bar() uses stat_count() by default: it counts the number of cases at each x position.
#geom_col() uses stat_identity(): it leaves the data as is.

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

dane <- tribble(~a,~b, "b1",66, "b2", 33, "b3", 11, "b4", 6)
ggplot(data = dane) +
  geom_bar(
    mapping = aes(x = a, y = b),
    stat = "identity"
  )

ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop.., group = 0))
?geom_bar

ggplot(data = diamonds) +
  stat_summary

ggplot(data = diamonds) +
  stat_summary(mapping = aes(x = cut, y= depth),
               fun.ymin = min,
               fun.ymax = max,
               fun.y = median
  )

ggplot(data = diamonds) +
  stat_summary(mapping = aes(x = cut, y= depth),
               fun.min = min,
               fun.max = max,
               fun = median
  )



#Ćwiczenia 5

#1. Która domyślna funkcja geometryczna jest związana z funkcją stat_summary()? Jak można
#przepisać wcześniejszy wykres, aby skorzystać z funkcji geometrycznej zamiast z
#przekształcenia statystycznego?
?stat_summary
#stat_summary(..., geom = "pointrange",...)
?geom_pointrange
?geom_linerange

library(dplyr)
df <- diamonds
df <- df %>% group_by(cut) %>% mutate(cut_min_depth = as.numeric(min(depth, na.rm = TRUE))) %>%
  mutate(cut_max_depth = as.numeric(max(depth, na.rm = TRUE))) %>% 
  mutate(cut_med_depth = as.numeric(median(depth, na.rm = TRUE)))
df
         
ggplot(data = df) +
  geom_pointrange(mapping = aes(x=cut, y=cut_med_depth, ymin=cut_min_depth, ymax=cut_max_depth))

#2.Do czego służy funkcja geom_col()? Czym różni się od funkcji geom_bar()?
?geom_col
#There are two types of bar charts: geom_bar() and geom_col().
#geom_bar() makes the height of the bar proportional to the number of cases in each group...
#If you want the heights of the bars to represent values in the data, use geom_col() instead.
#geom_bar() uses stat_count() by default: it counts the number of cases at each x position.
#geom_col() uses stat_identity(): it leaves the data as is.
#Obydwie funkcje służą do tworzenia wykresów słupkowych.
#geom_bar na osi y pokazuje liczbę wystąpień zm. x, a geom_col sumuje wartości zmiennej y.

#3.Większość funkcji geometrycznych i przekształceń statystycznych tworzy pary, które niemal
#zawsze są używane wspólnie. Przeczytaj dokumentację i wykonaj listę tych par. Co mają ze
#sobą wspólnego?
?geom_smooth

#4.Jakie zmienne oblicza funkcja stat_smooth()? Jakie parametry sterują jej zachowaniem?
?stat_smooth
#Funkcja ta oblicza granice przedziału ufności dla funkcji wygładzającej dane.
#Sterują nią następujące parametry:
#n - liczba punktów na podstawie których robione jest wygładzenie (domyślnie 80), 
#span - poziom wygładzenia, im wyższa wartość, tym linia bardziej wygładzona (domyślnie 0.75),
#level - poziom przedziału ufności (domyślnie 0.95).

#5.Na naszym wykresie słupkowym proporcji musieliśmy skorzystać z zapisu group = 1.
#Dlaczego? Innymi słowy, na czym polega problem z poniższymi wykresami?
ggplot( data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))
#W powyższym przypadku proporcje są liczone w grupach wyznaczonych przez wartości x, tzn. dla każdej z nich sumują się do 1.
ggplot( data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=cut))
ggplot( data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=0))
ggplot( data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

nrow(diamonds)
nrow(diamonds%>%filter(color=="D"))
nrow(diamonds%>%filter(color=="E"))
nrow(diamonds%>%filter(color=="F"))
nrow(diamonds%>%filter(color=="G"))
nrow(diamonds%>%filter(color=="H"))
nrow(diamonds%>%filter(color=="I"))
nrow(diamonds%>%filter(color=="J"))
nrow(diamonds%>%filter(color=="D")%>%filter(cut=="Fair"))
nrow(diamonds%>%filter(color=="E")%>%filter(cut=="Fair"))
nrow(diamonds%>%filter(color=="F")%>%filter(cut=="Fair"))
nrow(diamonds%>%filter(color=="D")%>%filter(cut=="Ideal"))
nrow(diamonds%>%filter(color=="E")%>%filter(cut=="Ideal"))
nrow(diamonds%>%filter(color=="F")%>%filter(cut=="Ideal"))
nrow(diamonds%>%filter(color=="G")%>%filter(cut=="Ideal"))
nrow(diamonds%>%filter(color=="H")%>%filter(cut=="Ideal"))
nrow(diamonds%>%filter(color=="I")%>%filter(cut=="Ideal"))
nrow(diamonds%>%filter(color=="J")%>%filter(cut=="Ideal"))

ggplot(data = diamonds) +
  geom_bar(mapping = aes ( x = cut, fill = color, y = ..prop..))
#W tym przypadku proporcje wyznaczone są na podstawie liczby różnych kolorów i dla każdej wartości cut sumują się do 7.
ggplot(data = diamonds) +
  geom_bar(mapping = aes ( x = cut, fill = color, y = ..prop.., group=cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes ( x = cut, fill = color, y = ..prop.., group=0))
ggplot(data = diamonds) +
  geom_bar(mapping = aes ( x = cut, fill = color, y = ..prop.., group=1))
ggplot(data = diamonds) +
  geom_bar(mapping = aes ( x = cut, fill = color, y = ..prop.., group=color))

?aes



ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

?geom_bar
#position = "stack"

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "stack")
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "identity")
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge2")
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar( position = "identity")
ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5 , position = "identity")

nrow(diamonds%>%filter(clarity=="IF")%>%filter(cut=="Ideal"))   #1212
nrow(diamonds%>%filter(clarity=="VVS1")%>%filter(cut=="Ideal"))  #2047
nrow(diamonds%>%filter(clarity=="VVS2")%>%filter(cut=="Ideal"))  #2606
nrow(diamonds%>%filter(clarity=="VS1")%>%filter(cut=="Ideal"))  #3589
nrow(diamonds%>%filter(clarity=="VS2")%>%filter(cut=="Ideal"))  #5071
nrow(diamonds%>%filter(clarity=="SI1")%>%filter(cut=="Ideal"))  #4282
nrow(diamonds%>%filter(clarity=="SI2")%>%filter(cut=="Ideal"))  #2598
nrow(diamonds%>%filter(clarity=="I1")%>%filter(cut=="Ideal"))  #146
nrow(diamonds%>%filter(cut=="Ideal"))  #21551
nrow(diamonds%>%filter(cut=="Premium"))  #13791

ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill=clarity), position="fill")

ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "stack")
#Co odróżnia parametr fill od skumulowanego wykresu słupkowego
#W skumulowanym wykresie słupkowym warstwy nie nakładają się na siebie.
#Skumulowany wykres słupkowy bardziej przypomina geom_bar z parametrem position = "stack".

ggplot(data = diamonds) +
  geom_bar( mapping = aes( x =cut, fill = clarity), position = "dodge")


ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class), position="jitter")



#Ćwiczenia 6

#1. Na czym polega problem z tym wykresem? Jak można go poprawić?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point()
#W przypadku tego wykresu wartości zmiennych są zaokrąglane i wyświetlane na siatce.
#Nakładają się na siebie i części z nich w ogóle nie widzimy.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = class)) + geom_point()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = class)) + geom_point(position="jitter")

#2. Jakie parametry funkcji geom_jitter() sterują poziomem fluktuacji?
?geom_jitter
p <- ggplot(mpg, aes(cyl, hwy))
p + geom_point()
p + geom_jitter()
#width - szum dodawany w poziomie
#height - szum dodawany w pionie

#3. Porównaj ze sobą funkcje geom_jitter() i geom_count().
?geom_jitter
#The jitter geom is a convenient shortcut for geom_point(position = "jitter").
#It adds a small amount of random variation to the location of each point,
#and is a useful way of handling overplotting caused by discreteness in smaller datasets.
?geom_count
#This is a variant geom_point() that counts the number of observations at each location, then maps the count to point area.
#It useful when you have discrete data and overplotting.

p <- ggplot(mpg, aes(cyl, hwy))
p + geom_jitter()
p + geom_count()

#4.Jakie jest domyślne dopasowanie położenia dla geom_boxplot()? Utwórz odpowiednią wizualizację zestawu danych mpg.
?geom_boxplot
#position = "dodge2"
ggplot(diamonds, aes(depth, price, fill = color)) + geom_boxplot()
ggplot(diamonds, aes(carat, price, fill = color)) + geom_boxplot()
ggplot(diamonds, aes(table, price, fill = color)) + geom_boxplot()



ggplot(data = mpg, mapping = aes(x = class, y = hwy )) + geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy )) + geom_boxplot() + coord_flip()
ggplot(data = mpg, mapping = aes(x = class, y = hwy )) + geom_boxplot() + coord_polar()

bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut ),
           show.legend = FALSE,
           width = 1 ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
View(bar)
bar + coord_polar()



#Ćwiczenia 7

#1.Przekształć skumulowany wykres słupkowy w wykres kołowy za pomocą funkcji coord_polar().
ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) + geom_bar(position = "stack")
ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) + geom_bar(position = "stack") + coord_polar()

#2.Do czego służy funkcja labs()? Przeczytaj dokumentację.
?labs
#Funkcja lab służy do opisywania wykresów.

ggplot( data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(position = "stack") + coord_polar() +
  labs(title = "Wykres przezroczystości diamentów",
       subtitle = "dla różnych sposobów ich cięcia",
       caption = "Dane pochodzą ze zbioru DIAMONDS",
       tag = "polar")

#3.Patrząc na poniższy wykres, czego możesz się dowiedzieć o zależności między miastem (cty) a wydajnością zużycia paliwa na autostradzie (hwy)?
#Dlaczego ważne jest wywołanie coord_fixed()? Do czego służy funkcja geom_abline()?
ggplot( data = mpg, ) +
  geom_point(mapping = aes(x = cty, y = hwy)) +
  coord_fixed() +
  geom_abline()
#Są one wprost proporcjonalne, tzn. wraz ze wzrostem jednego, wzrasta drugie.
#Pojazdy, które na galonie paliwa pokonają większą ogległość w mieście, pokonają większą również na autostradzie i odwrotnie.
#coord_fixed() potrzebne jest, żeby lepiej zobaczyć jak jedna zmienna i druga są od siebie zależne.
#Bez tego duży wzrost na jednej osi może wyglądać jakby był związany z małym wzrostem na drugiej, a wcale tak nie będzie w rzeczywistości.
#geom_abline() służy do tego, aby pokazać, że wszystkie punkty są powyżej prostej y=x, tzn. na galonie paliwa zawsze przejedziemy większy dystans na autostradzie niż w mieście.

#4. Opisz, krótko wykres pudełkowy.
#Wykres pudełkowy przedstawia podstawowe statystyki:
#- Q1, Q3 - pierwszy i trzeci kwartyl otwierają i zamykają pudełko (25% obserwacji jest położonych poniżej/powyżej tych wartości)
#- mediana - linia w środku pudełka (wartość, która dzieli zbiór na połowę)
#- wąsy sięgają do wartości Q1 - 1.5 IQR (odstępu międzykwartylowego), Q3 + 1.5 IQR (IQR=Q3-Q1)
# - kropki na końcach to obserwacje odstające

#5. Pobierz historyczne dzienne dane wybranej spółki giełdowej ze strony: https://stooq.pl/
#( plik csv) a następnie wyświetl wykres pudełkowy (oś OX – rok, oś OY – cena akcji na
#zamknięciu) tak jak w przykładzie poniżej.

wig20 <- read.csv("wig20_d.csv")
wig20 <- wig20 %>% mutate(rok = substring(wig20$Data,1,4))
wig20
ggplot(data = wig20, mapping = aes(x = rok, y = Zamkniecie )) + geom_boxplot()