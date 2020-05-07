library(purrr)
library(knitr)
dir.create("slides")
slides_rmd = "index.Rmd"

# extracts code -----------------------------------------------------------
purl(slides_rmd, 
     output = "slides/slides_code.R",
     documentation = 0)

# creates pdf -------------------------------------------------------------
pagedown::chrome_print("index.html",
                       output = "slides/slides.pdf",
                       wait = 10)

# creates a workshop zip --------------------------------------------------
exercises = dir("exercises", full.names = TRUE)
data = dir("data", full.names = TRUE)

file.remove("ialena-2020.zip")
zip("ialena-2020.zip",
    files = c("ialena-2020.Rproj",
              "slides/slides_code.R",
              "slides/slides.pdf",
              exercises,
              data),
    extras = "")
