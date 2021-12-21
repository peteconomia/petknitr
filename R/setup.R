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

  scape_backslash <- function(s) gsub("\\$", "\\\\$", s)

  knitr::knit_hooks$set(
    plot = function(x, options) {
      cap <- scape_backslash(options$fig.cap)
      subcap <- scape_backslash(options$fig.subcap)
      notes <- scape_backslash(options$fig.notes)

      knitr::raw_latex(
        paste0(
          if ((options$wrap == "open" && !is.null(options$wrap)) || !is.null(options$wrap) && options$wrap == TRUE) {
            "\\begin{figure}[!h]\n"
          },
          sprintf("\\begin{subfigure}{\\linewidth}\n\\caption{%s\\label{fig:%s}}\n\\subcap{%s}\n\\includegraphics{%s}\n\\source{%s}\n", cap, options$label, subcap, x, options$fig.source),
          if (!is.null(options$fig.notes)) {
            sprintf("\\notes{%s}\n", notes)
          },
          "\\end{subfigure}\n",
          if ((options$wrap == "close" && !is.null(options$wrap)) || !is.null(options$wrap) && options$wrap == TRUE) {
            "\\end{figure}"
          }
        )
      )
    }
  )
}
