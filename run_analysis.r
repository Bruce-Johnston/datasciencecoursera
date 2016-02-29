function run_analysis 

##Set the working directory, get the library set up,##
##and read in the data##

setwd("C:/Users/Admin/Desktop/UCI HAR Dataset/")
library(dplyr, tidyr)
## Data sets for Train and Test data ##
XTest = data.frame()
XTrain = data.frame()
wd = character()

wd <- getwd()
XTest <- read.table(paste(wd, "/test/X_test.txt", sep =""), header = FALSE, sep = "")
XTrain <- read.table(paste(wd, "/train/X_train.txt", sep = ""), header = FALSE, sep = "")

##Subjects and Test column vectors to be appended##
## to data frames##
  
TestSubjectVect <- read.table("test/subject_test.txt", sep = "")
TrainSubjectVect <- read.table("train/subject_train.txt", sep = "")

TestActivityVect <- read.table("test/y_test.txt", sep = "")
TrainActivityVect <- read.table("train/y_train.txt", sep = "")

##Merge these to make a new data frame which will be given##
##correct labels in a minute##

XTest <- cbind(TestSubjectVect, TestActivityVect, XTest)
XTrain <- cbind(TrainSubjectVect, TrainActivityVect, XTrain)

##Now load up the list of features and combine it with##
##what we just did to get a dataset with more resemblance to##
##what we want##

Featurelist = data.frame()
Featurelist <- read.table(paste(wd, "/features.txt", sep = ""), header = FALSE, sep = "")
ColNames = list()
ColNames <- as.character(Featurelist$V2)
colnames(XTest) <- c("Subject", "Activity", ColNames)
colnames(XTrain) <- c("Subject", "Activity", ColNames)

##Now let's combine these two data frames##
TidyData1 = data.frame()
TidyData1 <- rbind(XTest, XTrain)

##And get some more column specificity##
Count_Vector = list()
Activity_Describe = list()
j = integer()

Count_Vector <- as.character(1:6)
Activity_Describe <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                      "SITTING", "STANDING", "LAYING")

for (j in 1:6){
  TidyData1$Activity <- sub(Count_Vector[j], Activity_Describe[j], TidyData1$Activity)
}

##Finally, let's get the means and stddev's out of there##
ImportantList = list()
ImportantList <- c(1,2,3,grep("-mean()[^F]|std", colnames(TidyData1)))
TidyData1 <- TidyData1[,ImportantList]
##And that's what we wanted for part 4.##


##Now let's try to arrange things like in part V##
##We'll first get things sorted by subject and activity

TidyData2 = data.frame()
InterMediate_Frame = data.frame()
Intermediate_List = list()
j = integer()
k = integer()
Column_Names = list() 
Column_Names <- colnames(TidyData1)


##Use a double for() loop to loop through all possible##
##combinations of Activity and Subject##
##Then get the means of variables using colMeans()##
for (j in 1:6){
  for (k in 1:30){
    InterMediate_Frame <- filter(
      TidyData1, Activity == Activity_Describe[j] & Subject == k)
    Intermediate_List <- c(k, Activity_Describe[j], as.numeric(colMeans(InterMediate_Frame[3:length(Column_Names)])))
  if(j == 1 & k == 1)
    TidyData2 <- Intermediate_List
  else
    TidyData2 <- rbind(TidyData2, Intermediate_List)
    }
}

colnames(TidyData2) <- c("Subject", "Activity", paste("AVERAGE", Column_Names[3:length(Column_Names)], sep = " "))
row.names(TidyData2) <- 1:180

##That should do it##

return(TidyData2)




