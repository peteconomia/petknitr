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
      knitr::raw_latex(
        paste0(
          if ((options$wrap == "open" && !is.null(options$wrap)) || !is.null(options$wrap) && options$wrap == T) {
            "\\begin{figure}[!h]\n"
          },
          sprintf("\\begin{subfigure}{\\linewidth}\n\\caption{%s\\label{fig:%s}}\n\\subcap{%s}\n\\includegraphics{%s}\n\\source{%s}\n", options$fig.cap, options$label, options$fig.subcap, x, options$fig.source),
          if (!is.null(options$fig.notes)) {
            sprintf("\\notes{%s}\n", options$fig.notes)
          },
          "\\end{subfigure}\n",
          if ((options$wrap == "close" && !is.null(options$wrap)) || !is.null(options$wrap) && options$wrap == T) {
            "\\end{figure}"
          }
        )
      )
    }
  )
}
