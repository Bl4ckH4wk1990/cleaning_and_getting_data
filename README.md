#Cleaning and Getting Data Week 4 Project

The participants had to read in the Samsung dataset from [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
They then had to perform an analysis on the data set and output a tidy data set.


## Here are the steps that must be performed before running the R script:

1. Download the zip file from this URL.
2. Unzip the file.
3. Move ALL of the following files to the SAME DIRECTORY as the R script:
	* features.txt
        * subject_train.txt
        * subject_test.txt
        * X_train.txt
        * X_test.txt
        * y_train.txt
        * y_test.txt

Now run the run_analysis.R script via source("run_analysis.R").
Be aware that the reshape2 package is necessary for it to work properly.
If not installed download it from CRAN via install.packages("reshape2").

The output of the R script is a tidy data set, tidy.csv.

Please also colsult the Code Book for more information.
