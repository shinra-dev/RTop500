\name{alice}
\alias{alice}

\docType{data}

\title{Alice's Adventures in Wonderland}

\description{
  The complete text of Lewis Carroll's "Alice's Adventures in 
  Wonderland".
  
  "Begin at the beginning," the King said, very gravely, "and go on
  till you come to the end: then stop."
}
\format{
  A \code{pg.book} object.
}
\details{
\tabular{ll}{
  Title:    \tab Alice's Adventures in Wonderland \cr
  Author:   \tab Carroll, Lewis, 1832-1898 \cr
  Language: \tab English \cr
  URL:      \tab \url{http://www.gutenberg.org/ebooks/11.txt.utf-8}
}
  
  To access the full text unmodified from its Project Gutenberg
  source, call \code{text(alice)}.  To remove Project Gutenberg
  insertions (header information, the license, etc.), call
  \code{text(alice, with.license=FALSE)}.
}

