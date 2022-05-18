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
  facet_grid(drv~class)                   # facet by multiple var. combination(colm~row)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))+
  facet_grid(.~class)                      # all in same row for a single var

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)                    # all in same col for a single var


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
  geom_smooth()  #this format is more effective and concise
