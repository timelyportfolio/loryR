#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
loryR <- function(message, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    message = message
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
