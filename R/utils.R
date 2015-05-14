#' Gallery of RStudio Plots
#'
#' rstudio_gallery() is a convenience function to grab all the plots from your
#' RStudio history and return the images as a \code{list} of \code{base64}
#' encoded images.
#'
#' @param img numeric vector containing indices for which plots to suggest.
#'   Defaults to NULL, in which case all plots will be used.
#' @import base64enc
#'
#' @export

rstudio_gallery <- function(img = NULL){
  if(!(is.null(img) | is.numeric(img))) stop("img must be a numeric vector")

  images <- Filter(Negate(is.null),lapply(
    list.files(tempdir(),"png",recursive=T,full.names=T)
    ,function(p){
      if(grepl(x=p,pattern="rs-graphics") && !(grepl(x=p,pattern="empty"))){
        return(p)
      } else return(NULL)
    }
  ))

  # sort images by modified time
  images <- images[order(
                    sapply(images,function(i){file.info(i)[["mtime"]]})
                  )]

  # base64 encode images all if img == NULL or selected
  lapply(
    if(is.null(img)){
      images
    } else {
      images[img]
    }
    ,function(p){ base64enc::dataURI(file=p, mime="image/png") }
  )
}
