#' Make a lory.js slider of images from R
#'
#' lory.js is a very nice dependency-free slider javascript library.  With \code{loryR}
#' we can incorporate our R plots easily into HTML and R markdown.
#'
#' @param images \code{list} of image urls or \code{base64} encoded src to include in the slider.
#' @param images_per_page \code{integer} number of images shown at one time in the slider.  This
#'    argument will try to intelligently apply a \code{CSS} width to each image so that it fits
#'    as expected in the slider.
#' @param options \code{list} of options for lory.js.  See
#'    \href{https://github.com/meandmax/lory#options}{lory documentation}.
#' @param width a valid \code{CSS} width
#' @param height a valid \code{CSS} height
#'
#' @examples
#' \dontrun{
#'
#' library(loryR)
#'
#' # make some sample plots
#' plot(1:10,col="red")
#' contour(volcano)
#' lattice::xyplot(x~0:90, data.frame(x=cos(0:90/90)))
#'
#' # if in RStudio we can get a gallery of our plots
#' images <- Filter(Negate(is.null),lapply(
#'   list.files(tempdir(),"png",recursive=T,full.names=T)
#'   ,function(p){
#'     if(grepl(x=p,pattern="rs-graphics") && !(grepl(x=p,pattern="empty"))){
#'       base64enc::dataURI(file=p, mime="image/png")
#'     }
#'   }
#' ))
#'
#' loryR(images, images_per_page = 2, width = "90%", options = list(rewind=T))
#' }
#'
#' @import htmlwidgets base64enc htmltools
#'
#' @export
loryR <- function(images = NULL, images_per_page = NULL, options = list(), width = NULL, height = NULL) {

  # forward options using x
  x = list(
    images = images
    ,images_per_page = images_per_page
    ,options = options
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'loryR',
    x,
    width = width,
    height = height,
    package = 'loryR'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
loryROutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'loryR', width, height, package = 'loryR')
}

#' Widget render function for use in Shiny
#'
#' @export
renderLoryR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, loryROutput, env, quoted = TRUE)
}


#' @export
loryR_html <- function(id, style, class, ...) {
  list(
    tags$div( id = id, class = class, class = "slider js_variablewidth variablewidth", style = style
      ,tags$div( class = "frame js_frame"
        ,tags$ul( class = "slides js_slides" )
      )
      ,tags$span( class="js_prev prev"
        ,HTML('<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 501.5 501.5"><g><path fill="#2E435A" d="M302.67 90.877l55.77 55.508L254.575 250.75 358.44 355.116l-55.77 55.506L143.56 250.75z"/></g></svg>')
      )
      ,tags$span( class="js_next next"
        ,HTML('<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" viewBox="0 0 501.5 501.5"><g><path fill="#2E435A" d="M199.33 410.622l-55.77-55.508L247.425 250.75 143.56 146.384l55.77-55.507L358.44 250.75z"/></g></svg>')
      )
    )
  )
}
