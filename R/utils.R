#' Gallery of RStudio Plots
#'
#' rstudio_gallery() is a convenience function to grab all the plots from your RStudio history and
#' return the images as a \code{list} of \code{base64} encoded images.
#'
#' @import base64enc
#'
#' @export

rstudio_gallery <- function(){
  Filter(Negate(is.null),lapply(
    list.files(tempdir(),"png",recursive=T,full.names=T)
    ,function(p){
      if(grepl(x=p,pattern="rs-graphics") && !(grepl(x=p,pattern="empty"))){
        base64enc::dataURI(file=p, mime="image/png")
      }
    }
  ))
}
