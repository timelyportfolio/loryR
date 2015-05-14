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

### Example | Using SVG

With `SVG`, we can supply `UTF+8` instead of `base64`.  See this great [css-tricks article](https://css-tricks.com/probably-dont-base64-svg/) for more information on why we would want to do this.  Please note, this trick **does not work** for me in Firefox but **does work** in RStudio Viewer and Chrome.

```r
library(SVGAnnotation)
library(loryR)
library(pipeR)

#let's use lattice and tmap
library(lattice)
library(tmap)

lapply(
  list(
    svgPlot({plot(1:10)})
    ,svgPlot({print(xyplot(x~x,data.frame(x=1:10),type="l"))},addInfo=F)
    ,svgPlot({
        print(
          dotplot(variety ~ yield | site , data = barley, groups = year,
                  key = simpleKey(levels(barley$year), space = "right"),
                  xlab = "Barley Yield (bushels/acre) ",
                  aspect=0.5, layout = c(1,6), ylab=NULL)        
        )
      }
      ,addInfo=F
    )
    ,svgPlot({
      data(World)
      print(
        tm_shape(World) + tm_fill("pop_est_dens", style="kmeans", title="Population density") + 
            tm_layout_World("World Population", bg.color="lightblue")
      )
    })
  )
  ,function(sv){
    paste0(
      "data:image/svg+xml;utf8,"
      ,saveXML(sv,prefix='')
    )
  }
) %>>%
  loryR( images_per_page = 1, height = 300 )

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

