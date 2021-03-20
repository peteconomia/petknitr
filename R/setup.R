#' @title knitr setup
#' @import knitr
#' @export 

setup <- function(echo = FALSE, 
                  eval = TRUE, 
                  message = FALSE, 
                  warning = FALSE, 
                  dev = "cairo_pdf", 
                  cache = FALSE, 
                  cache.rebuild = FALSE, 
                  cache.path = "_cache/") {

  knitr::opts_chunk$set(
    echo = echo,
    eval = eval,
    message = message,
    warning = warning,
    dev = dev,
    cache = cache,
    cache.path = cache.path,
    cache.rebuild = cache.rebuild
  )

  knitr::knit_hooks$set(
    plot = function(x, options) {
      paste0(
        if ((options$wrap == "open" && !is.null(options$wrap)) || !is.null(options$wrap) && options$wrap == T) "\\Begin{wrapfig}\n",
        "\\Begin{fig}\n",
        "\\caption{", options$fig.cap, "}",
        "\\label{fig:", options$label, "}\n",
        "\\subcap{", options$fig.subcap, "}",
        "\\includegraphics{", x, "}",
        if (!is.null(options$fig.source)) {
          paste0("\n\\source{", options$fig.source, "}")
        },
        if (!is.null(options$fig.notes)) {
          paste0("\\notes{", options$fig.notes, "}")
        },
        "\\End{fig}",
        if ((options$wrap == "close" && !is.null(options$wrap)) || !is.null(options$wrap) && options$wrap == T) "\\End{wrapfig}"
      )
    }
  )

}