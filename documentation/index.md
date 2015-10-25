---
title       : Regression App
subtitle    : Documentation
author      : Brian Hudnall
job         : Analyst
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Idea

This [ShinyApp](https://bhudnall.shinyapps.io/RegressionShinyApp) was created for the Developing Data Products class offered through John Hopkins. The premise behind the app
is to give analysts the ability to run a regression model on a data set they upload. Analysts who use the app do not need to understand the code, but must have an understanding of regression models and how to interpret the results.

--- .class #id 

## Dependencies

1. You need to have a data set that structures the data in a [wide format](https://en.wikipedia.org/wiki/Wide_and_narrow_data).
2. The data must contain independent and dependent variables.
3. The variables can be either dummy variables, or actuals. If both independent and dependent are dummy, then you should use the Logistic Regression as the output can then account for [Heteroscedasticity](https://en.wikipedia.org/wiki/Heteroscedasticity).

--- .class #id

## Upload and Configure

1. First upload the data set by selecting Choose File. Be sure to select the right file type.
2. Select one dependent/response variable. For example, if I were to use the [mtcars data](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html) I might use mpg as the variable here.
3. Select independent variables. Using the same example, I might select carb, cyl, gear, vs, wt here. I would then be able to understand the relationship between these predictor variables and the response variable (mpg). 
    - The response variable will automatically be excluded as an option.
4. Of the independent variables selected, indicate if they are factor/categorical variables with the drop down menu. If this is not done, results will be uninterpretable.
    - Only independent variables will be included within this set.
5. After the data set is finalized, click either the linear or logistic regression tab and click the run button.

--- .class #id

## Results

1. It's important to note that if you selected a linear regression model, that this is a step-wise model. Meaning certain independent variables will be excluded to optimize the results.
2. The results will show a table. The key columns to pay attention to are the Estimate and Pr columns. 
3. Estimate is the coefficient for the corresponding predictor variable and Pr will inform you if the results are statistically significant.
4. There will be plots of the data model located on the plot tab. It's important here to look for systematic trends that reflect poorly on the model.

--- .class #id

## Next steps

I really enjoyed working on this project and hope you enjoyed reading the documentation. My next step with this project is to allow the user functionality to transform the data set they upload. Specifically, I would like to give users the ability to dcast variables in there data set and change the form from long to wide. This would allow more flexibility and is a common transformation with web data. Thank you!








