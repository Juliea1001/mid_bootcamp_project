# mid_bootcamp_project

We had to choose between a classification and a regression problem for the mid bootcamp project.
We chose the regression problem. And had been using the regression house price dataas we have been provided by IronHack. It is stored under regression -> files_for_lab -> regression_data.csv and for the tableau part of the work we converted into .xls format (regression -> files_for_lab -> regression_data.xls).

### The to turn in work (tableau, sql, ipynb) ist stored in the folder regression -> turn_ins

It contains the sql sheet having been worked on as instructed in the sql.md provided by IronHack (these instructions are stored in the folder regression -> instructions) and 
the tableau worksheet (dashboard 1). Partly worked on it as instructed in the tableau.md (stored in the folder regression -> instructions).
And after exploring and wrangling the data in pandas notebook having worked again with tableau (-> dashboard 2).

### the task given has been:

"**Background**: You are working as an analyst for a real estate company. Your company wants to build a machine learning model to predict the selling prices of houses based on a variety of features on which the value of the house is evaluated.

**Objective**: The task is to build a model that will predict the price of a house based on features provided in the dataset. The senior management also wants to explore the characteristics of the houses using some business intelligence tool. One of those parameters include understanding which factors are responsible for higher property value - \$650K and above.
The questions have been provided later in the document for which you can use tableau.

**Data**: The data set consists of information on some 22,000 properties.  The dataset consisted of historic data of houses sold between May 2014 to May 2015."

### Results of the work:

The highest correlation between price and the given house features has been found with the feature of 'square foot living' of the houses (correlation factor of 0.7).

The given data has been explored and for one way normalized and for the other way outliers have been removed. Afterwards for both ways there have been 3 data fitting models used and compared to another. The fitting models were:
1. Linear Regression
2. KNN Neighbor Regressor
3. MLP Regressor

The best predictions on the trained data part to the other test data part has been reached - measured by the R^2 score of 76% - with the knn model on the normalized data. 
Measured by the Mean Average Error score the best outcome has been with the linear regression model using the data having removed outliers. 


## hier noch Bild von pred against trues vom besten R^2 einfügen.

