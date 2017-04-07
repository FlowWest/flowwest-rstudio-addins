# FlowWest RStudio Addins 

*Note: most addins are currently under development*

A set of addins that make working within RStudio easier and more fun :)

## Create Todo List 

This addin uses the current script and populates a list of todo tags 

**Creating a todo tag**

Todo tags must exist in a special format for addin to work: 

```r
#@TODO:topic --- message 
```
The populated output will show line number, todo topic and a message.
