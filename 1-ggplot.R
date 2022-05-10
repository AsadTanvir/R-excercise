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

## ggplots: facets
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_wrap(~class)                        # facet by one var.


ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_grid(drv~class)                     # facet by multiple var. combination

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_grid(.~class)                      # all in same row for a single var

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)                    # facet in a column by drv


## ggplots: geom_smooth
ggplot(data = mpg) +
  geom_smooth(mapping= aes(x=displ, y=hwy, group= drv))

ggplot(data = mpg) +
  geom_smooth(mapping= aes(x=displ, y=hwy, color= drv))
