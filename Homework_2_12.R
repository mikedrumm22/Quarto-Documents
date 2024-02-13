Notes on the Paper

Generating Tidy Data

Each variable should be in a column.

Each observation should be in a row.

Each value should be in its cell.

Benefits

Tidy data simplifies data manipulation tasks

Makes reproducibility easier

Common issues

Variables in both rows and columns

Multiple variables stored in a single column

Multiple types of observational unit in the same table.

R functions

from the tidyr package, there are functions that can be used to reshape the data easily

This paper is a good reference for the functions available in tidyr

##Homework Pt. 2

library(tidyverse)
library(gapminder)
{r}
#gapminder %>% filter(country=="Australia") %>% head(n=12)
gapminder %>% dplyr::filter(country=="Australia") %>% head(n=12)


gapminder %>% 
  dplyr::filter(continent=="Oceania" & year==1997) %>% 
  head()

gapminder %>% 
  dplyr::filter(continent=="Oceania" | continent =="Americas") %>%
  dplyr::filter(year==1997) %>% 
  head()

#two filter statements roduce the same result

gapminder %>% 
  filter(country %in% c("Australia", "New Zealand","Argentina") & year==1997) %>% 
  head()

## != means omit == makes a logical check if the year is 1997
gapminder %>% 
  filter(continent!="Oceania" & year==1997) %>% 
  head()

#save a modified dataset as a new dataframe
gap97 <- gapminder %>% 
  filter(continent!="Oceania" & year==1997) 
#
dplyr::glimpse(gap97)


gapminder %>% filter(year==1997) %>%
  top_n(n = 10, wt = gdpPercap) %>%
  head(n=10)

## filter function controls the rows of the dataframe. Select select and renames variables 
gapminder %>% 
  dplyr::select(country, Year=year,LifeExp=lifeExp) %>% 
  head()
# to change the order of display, puts year first in the list of variables
gapminder %>% 
  select(year,everything()) %>% 
  head()


# Let's observe the contents of profiling_num:
funModeling::profiling_num(gapminder) %>% 
  dplyr::glimpse()

# now remove unwanted columns from summary display
funModeling::profiling_num(gapminder) %>%
  select(-c("variation_coef","skewness","kurtosis","range_98","range_80","p_01","p_99")) %>%
  knitr::kable()

## mutant or rename functions will change the name of a variable 
gapVers1 <- gapminder %>%
  dplyr::mutate(logpopulation = log(pop)) %>%
  dplyr::rename(logPop=logpopulation) 
#
dplyr::glimpse(gapVers1)

# This command will show the countries with highest life expectancy because 
# the data are arranged in descending order of life expectancy (larger to smaller)
gapminder %>% 
  dplyr::filter(year==1997) %>%   
  dplyr::select(country, continent, lifeExp) %>% 
  dplyr::arrange(desc(lifeExp)) %>% 
  head()

#count() is short hand for groupby() + tally()


gapminder %>% dplyr::filter(year==1997) %>%
  dplyr::filter(continent=="Americas") %>%
  dplyr::tally()


gapminder %>% dplyr::filter(year==1997) %>%
  dplyr::filter(continent=="Americas") %>%
  dplyr::count()

gapminder %>% dplyr::filter(year==1997) %>%
  dplyr::count(continent)



{r}
### if a variable is not complete, they will be denoted as NA

x <- c(1,2,NA,4)
y <- c(11,12,13,NA)
z <- c(7,8,9,10)
tempdf <- data.frame(x,y,z)
tempdf

# count missing values for variable x
tempdf %>%
  dplyr::summarise(count = sum(is.na(x)))

# count rows with missing y
tempdf %>%
  dplyr::tally(is.na(y))


#subset of rows with complete data for specified columns
tempdf %>%
  dplyr::select(y,z) %>%
  tidyr::drop_na() %>%
  head()

#   drop rows with missing values in all variables
tempdf %>%
  tidyr::drop_na() %>%
  head()

empdf %>%
  filter(!is.na(x),           # remove obs with missing x
         !is.na(y),  # remove obs with missing y
         !is.na(z))                # remove obs with missing z

#execute a filter that will permit only rows with entirely complete data
tempdf %>%
  filter(x %>% is.na() %>% magrittr::not()) %>%
  head()



