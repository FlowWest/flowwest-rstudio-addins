#' @import miniUI shiny magrittr

#' @export
createTODOAddin <- function() {
  ui <- miniPage(
    gadgetTitleBar("Todo Builder"),
    miniContentPanel(
      tableOutput(outputId = "todo_output"),
      actionButton("download_todo", "Download Todo")
    )
  )
  
  server <- function(input, output, session) {
    current_document <- rstudioapi::getActiveDocumentContext()
    document_content <- trimws(current_document$contents)
    
    todo_tags <- find_TODO_tags(document_content)
    lines_with_tag <- document_content[todo_tags]
    todo_topics <- purrr::map(lines_with_tag, function(x) {
      get_topic_from_tag(x)
    }) %>% 
      purrr::flatten_chr()
    
    todo_messages <- purrr::map(lines_with_tag, function(x) {
      get_message_from_tag(x)
    }) %>% 
      purrr::flatten_chr()
    
    output$todo_output <- renderTable({
      tibble::tibble(`Line Number` = todo_tags,
                 `TODO Topic` = todo_topics,
                 `Message` = todo_messages)
    })
    
    observeEvent(input$done, {
      invisible(stopApp())
    })
  }
  
  viewer <- dialogViewer("TODO Builder", width = 1000, height = 800)
  runGadget(ui, server, viewer = viewer)
}

find_TODO_tags <- function(doc_content){
  doc_content <- trimws(doc_content)
  lines_with_tag <- which(stringr::str_detect(doc_content, "^#@TODO:"))

  return(lines_with_tag)  
}

get_topic_from_tag <- function(todo_line) {
  stringr::str_extract(todo_line, "TODO:[A-Za-z]+ ") %>% 
    stringr::str_replace("TODO:", "")
}

get_message_from_tag <- function(todo_line) {
  stringr::str_extract(todo_line, "---(.)+") %>% 
    stringr::str_replace("---", "") %>% 
    trimws()
}

  
