# mid_bootcamp_project

We had to choose between a classification and a regression problem for the mid bootcamp project.
My group chose the regression problem. And we had been using the regression house price datas we have been provided by IronHack. It is stored under regression -> files_for_lab -> regression_data.csv and for the tableau part of the work we converted into .xls format (regression -> files_for_lab -> regression_data.xls).

### The to turn in work (tableau, sql, ipynb) ist stored in the folder regression -> turn_ins

It contains the sql sheet having been worked on as instructed in the sql.md provided by IronHack (these instructions are stored in the folder regression -> instructions) and 
the tableau worksheet (dashboard 1). Partly worked on it as instructed in the tableau.md (stored in the folder regression -> instructions).
And after exploring and wrangling the data in pandas notebook ('machine_learning_process.ipnb') having worked again with tableau (-> dashboard 2,3,4).

### the task given has been:

"**Background**: You are working as an analyst for a real estate company. Your company wants to build a machine learning model to predict the selling prices of houses based on a variety of features on which the value of the house is evaluated.

**Objective**: The task is to build a model that will predict the price of a house based on features provided in the dataset. The senior management also wants to explore the characteristics of the houses using some business intelligence tool. One of those parameters include understanding which factors are responsible for higher property value - \$650K and above.
The questions have been provided later in the document for which you can use tableau.

**Data**: The data set consists of information on some 22,000 properties.  The dataset consisted of historic data of houses sold between May 2014 to May 2015."

### Results and process of the work:

The highest correlation between price and the given house features has been found with the feature of 'square foot living' of the houses (correlation factor of 0.7) closely followed by the 'grade' given to the house (correlation factor 0.67). And also the zip code is correlated to the house prices.

The given data has been explored and features having changed from floats to categoricals and also from categoricals into float searching for the best results. 3 data fitting models have been used and compared to another. The fitting models were:
1. Linear Regression
2. KNN Neighbor Regressor
3. MLP Regressor

The Linear Regression gave the best results for the R^2 , MAE and MSE score.

Afterwards the feature of the best modified data has been normalized and from the target value 'price' the outliers had been removed (1.5*iqr).

These are the best results:
having put 'bedrooms','zipcode','condition','view','date_month' into categoricals
droping columns 'date' , 'lat' , 'long'
Using normalized data, having removed outliers from the 'price' values
Using Linear Regression gives best scores as follows:
R^2: 0.84 MAE: $61073 MSE: $82200

The house price is quiet solid to predict, but the range for uncertainty for the price is about $ 120000, which is not such a small range. But for higher priced houses, it is not that bad.
So maybe if a house is predicted given a price less then ($  650000-$ 61000) = $ 589000 it should maybe rather not been taken from the real estate company into their market, if they only want to get houses sold, reaching a price above $ 650000.

I also gave a filter tool an attempt to watch out for high priced houses (> $ 650000) relying on the parameter 'grade' and 'sqft_living'. But there were also many houses lost in the high price segment (loss of 13% of the high priced houses) after applying the filter.  At least the low priced houses could be reduced to a third of the number before.

But since the house prices depend also much on the local zip code, it would be an possibility for the real estate company to focus on the lucrative local zip code areas.

