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

images <- Filter(Negate(is.null),lapply(
  list.files(tempdir(),"png",recursive=T,full.names=T)
  ,function(p){
    if(grepl(x=p,pattern="rs-graphics") && !(grepl(x=p,pattern="empty"))){
      base64enc::dataURI(file=p, mime="image/png")
    }
  }
))

loryR(images, width = "90%", options = list(rewind=T))
```


### Example | Flickr
```r
# examples with flickr images
#  don't expect this to be the primary use case
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
