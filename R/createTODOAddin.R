#' Create a Todo markdown based on @TODO tags in file 
#' 
#' Call this as an addin to create TODO list for a given script.
#' 
#' @export
createTODO <- function() {
  
}

#@TODO:
    #@TODO:
find_TODO_tags <- function(){
  current_document <- rstudioapi::getActiveDocumentContext()
  document_content <- trimws(current_document$content)
  
  lines_with_tag <- which(stringr::str_detect(document_content, "^#@TODO:"))
}
  
