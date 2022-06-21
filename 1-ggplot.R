library(tidyverse)
mpg <- dput(mpg)


## ggplots: engine displacement vs highway
ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y = hwy), color = "red") # scatter-point color is red

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y= hwy, color= class)) # 3rd var. "class" shown by colors

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size=class)) # 3rd var. "class" shown by sizes

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=class)) # 3rd var. "class" shown by shapes

## ggplots: facets  (particularly useful for categorical variables)
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_wrap(~class)                        # facet by one var. "class"


ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_grid(drv~cyl)                   # facet by multiple var. combination(row~colm)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_grid(.~cyl)                      # all in same row by single var. columns

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)                    # all in same col for single var. rows


## ggplots: geom_smooth
ggplot(data = mpg) +
  geom_smooth(mapping= aes(x=displ, y=hwy))

ggplot(data = mpg) +
  geom_smooth(mapping= aes(x=displ, y=hwy, group= drv)) #multiple lines in a plot by 'group' var

ggplot(data = mpg) +
  geom_smooth(mapping= aes(x=displ, y=hwy, color= drv)) #multiple lines by 'group'(diff color)

ggplot(data = mpg)+
  geom_smooth(mapping=aes(x=displ, y=hwy, linetype=drv)) #multiple lines by 'group'(diff line-types)

# points and lines together
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy, color=drv))+
  geom_smooth(mapping = aes(x=displ, y=hwy, color=drv))

#or, above can be done in different way
ggplot(data=mpg, mapping = aes(x=displ, y=hwy, color=drv))+
  geom_point()+
  geom_smooth(se=F)  # this format is more effective and concise
                     # se= confidence interval (default=TRUE)

# 'filter' is used to subset the data (ie. only drv "4" line)
ggplot(data=mpg, mapping = aes(x=displ, y=hwy, color=drv))+
  geom_point()+
  geom_smooth(data = filter(mpg, drv=="4"), color="red") 

# Excercise 3.6.1(6):-
ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(se=F)

ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point()+
  geom_smooth(mapping = aes(group=drv), se=F)

ggplot(data=mpg, mapping = aes(x=displ, y=hwy, color=drv))+
  geom_point()+
  geom_smooth(se=F)

ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(mapping=aes(color=drv))+
  geom_smooth(se=F)

ggplot(data=mpg, mapping = aes(x=displ, y=hwy))+
  geom_point(mapping = aes(color=drv))+
  geom_smooth(mapping = aes(linetype=drv), se=F)

## ggplots: bar chart, histogram, box plots
diamonds
diamonds <- dput(diamonds)

#bar plot
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut)) 

#stat summary (max, min, median)
ggplot(data=diamonds)+
  stat_summary(mapping = aes(x=cut, y=depth),
               fun.min = min,
               fun.max = max,
               fun = median)

# bar plot by proportion rather than frequency
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group=1))

# by 'cut' color
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# by 'clarity' color
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# position="fill" works like stacking,
# makes it easier to compare proportions across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# boxplot
ggplot(data = diamonds, mapping = aes(x = cut, y = depth)) + 
  geom_boxplot() +
  coord_flip() # only used if x-axis can't accomodate the categories
