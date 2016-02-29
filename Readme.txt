run_analysis.r
Author: Bruce Johnston
Date: 2/28/2016

This script, entitled run_analysis, reads through the UCI HAR dataset to produce a tidy dataset extracting the mean and standard deviation of all gyroscope measurements and then grouping both the test and the training data by subject and activity, eventually taking the average of said means and standard deviations.

The script itself is heavily commented and, I think, fairly self-explanatory. Both the test and training data are uploaded (please refer to the UCI codebook excerpts included in this repo), bound to the subject and activity columns using cbind() (the activity column is remade in the process to give more descriptive names to the activities), and the columns are named from the features.txt file in the UCI dataset. Several intermediate variables are used to represent these lists. The test and traning datasets are then merged using cbind() again. 

From here, grep() is used to extract the column names which correspond to means and standard deviations; these columns are then subsetted out to create the dataset TidyData1. TidyData1 is further transformed by using a double for() loop coupled with the filter() command to extract the measurements associated with a given activity and subject, compute their means using colMeans(), then re-assemble them into a data.frame. The data.frame in question is then tidied up (appropriate column names, row names) to give TidyData2, which can be summarized as being in the form (SUBJECT, ACTIVITY, AVERAGE_DATA).  

Again, the code is heavily commented and fairly straightforward. The only confusing, inelegant parts are those involving re-naming the columns when necessary.

-Bruce Johnston
