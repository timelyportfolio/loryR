[lory.js](https://github.com/meandmax/lory) is a very nice dependency-free JavaScript slider library, so of course it needs to be wrapped in a `htmlwidget` for use in `R`.


### Install
```r
devtools::install_github("timelyportfolio/loryR")
```

### Example | RStudio Gallery
```r
library(loryR)

# make some sample plots
plot(1:10,col="red")
contour(volcano)
lattice::xyplot(x~0:90, data.frame(x=cos(0:90/90)))

images <- rstudio_gallery()

loryR(images, width = "90%", options = list(rewind=T))
```


### Example | Flickr

We can also provide a `url` as our image source, so using Flickr images could work like this.

```r
# examples with flickr images
#  don't expect this to be the primary use case
library(loryR)

flickr_images <- list(
  "https://farm4.staticflickr.com/3133/2288766662_c40c168b76_o.jpg"
  ,"https://farm6.staticflickr.com/5309/5607717791_b030229247_o.jpg"
)

loryR( flickr_images, width = "50%", images_per_page = 1, options = list(rewind=T) )
```

Just in case you are interested, here is how we would do it in `base64`.

```r
# examples with flickr images
#  don't expect this to be the primary use case
library(loryR)
library(curl)

flickr_images <- list(
  paste0(
    "data:image/jpg;base64,"
    ,base64enc::base64encode(
      curl("https://farm4.staticflickr.com/3133/2288766662_c40c168b76_o.jpg","rb")
    )
  )
  ,paste0(
    "data:image/jpg;base64,"
    ,base64enc::base64encode(
      curl("https://farm6.staticflickr.com/5309/5607717791_b030229247_o.jpg","rb")
    )
  )
)

loryR( flickr_images, width = "50%", images_per_page = 1, options = list(rewind=T) )
```
