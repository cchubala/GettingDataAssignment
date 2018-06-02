# Coursera Course: Getting and Cleaning Data
## Final Assignment
### README.md

The R script run_analysis.R is used to collect and clean data from an experiment by Reyes-Oritz, Anguita, Ghio, and Oneto (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), which examined human activity via the accelerometer and gyroscope of a smartphone affixed to participants’ waists. The original data can be accessed as a zip file at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The script performs five steps, or series of transformations, to render the data from its original format to a tidy data set summarizing the mean of a number of variables for each of thirty subject performing each of six different activities. Below is a summary of the steps performed by *run_analysis.R*  

###1. Step 1  
Raw training and test data are merged into a single data frame, with columns denoting the subject, the activity being performed, and a host of measurement variables from the smartphone data. This involves reading and merging *subject_test.txt*, *X_test.txt*, *y_test.txt*, *subject_train.txt*, *X_train.txt*, and *y_train.txt*. Intertrial Signal data were excluded at this point, because these data so not include either of our measures of interest (mean and standard deviation), and so would later be culled from the dataset anyhow.

###2. Step 2  
*Note: in run_analysis.R, this step occurs within Step 1 for efficiency.*  
The data frame is pared down to the subject and activity variables as well as those measurement variables that measure some mean or standard deviation. At this point, *MeanFreq()* measures were excluded because they represent weighted averages of the frequency component of the data, and thus do not reflect the arithmetic means we are interested in. Likewise, additional measures obtained by averaging the signals in the sample window (*gravityMean*, *tBodyAccMean*, etc) were excluded at this point, because they are not representative of the arithmetic means we are interested in.

###3. Step 3  
Descriptive names are given as character strings to the activity variable.

###4. Step 4  
The column labels are tidied up for maximal descriptiveness. When the data was read in during Step 1, the original variable names were imported from features.txt. The original labels were deemed to be sufficiently descriptive, but were tidied to remove non-alphanumeric characters and fix a typographical error in the original data.

###5. Step 5  
The dataset is grouped by subject and activity, and the mean for each measurement variable (per subject and activity) is calculated. The tidied data are then output as *tidydata.txt*.