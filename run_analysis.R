# Looks like a simple read.table will do the job - satisfies defaults
# I think it will recognise standard form as numeric
# Read the first one in and check
# y.train in notepad in gobbledegook. In ++ one number per row, many the same
# will be using dplyr so open it now
library(dplyr)
xtrain <- read.table("UCI HAR DATASET/train/X_train.txt")
xtest <- read.table("UCI HAR DATASET/test/X_test.txt")
ytrain <- read.table("UCI HAR DATASET/train/Y_train.txt")
ytest <- read.table("UCI HAR DATASET/test/Y_test.txt")
subjecttrain <- read.table("UCI HAR DATASET/train/subject_train.txt")
subjecttest <- read.table("UCI HAR DATASET/test/subject_test.txt")
features <- read.table("UCI HAR DATASET/features.txt")
#rbind each element (train then test), reduce the x with grep then cbind
#I think the y are the activities (categorical). I think I need to use the features as
#guidance on names for the dataset (after subject and activity) 
#select columns containing mean () or std () before c binding
#Rename properly later
# I can see that features will be the x column names - want names() <- features[2]
ffeat <- grep("mean\\(|std\\(",features$V2)# way of selecting relevant columns of x
# had to escape the (
feat2 <- features[ffeat,2]# in case I want to use these for names to start with
#May be appropriate to make new names in a txt, or maybe use gsub
# First use rbind to create the "master" datasets
subject <- rbind(subjecttrain,subjecttest)
names(subject) <- ("subject") # had to go back and name these 2 before cbinding
# if I don't I get 3 columns called V1
activity <- rbind(ytrain,ytest)
names(activity) <- ("activity")
xall <- rbind(xtrain,xtest)
# now reduce the x df to only include mean/std
xnew <- select(xall,grep("mean\\(|std\\(",features$V2))
# at this stage I think I will set up a comparison df to compare new "names" with variables
feat2 <- as.character(feat2)
newfeat <- cbind(names(xnew),feat2)
#now to join all the cols/dfs together
mydata1 <- cbind(subject, activity, xnew)
# now I have done that I can get rid of some objects  
# I could use rm(c(objects)) but easier in RStudio to use the broom
#rename the activities
mydata1 <- mydata1 %>% transform(activity = ifelse(activity==1,"walking",ifelse(activity==2,"walkingup",ifelse(activity==3,"walkingdown",ifelse(activity==4,"sitting",ifelse(activity==5,"standing","laying"))))))
# there may be an easier way but that came to mind, as I have done something similar at work
# rename variables - I have used the original names for ease of use and I can't do any better
names(mydata1) <- c("subject", "activity", feat2)
# create the new independent dataset with means of all variables by subject and activity
mydata2 <- mydata1 %>% group_by(subject, activity) %>% summarise_all(mean)
# Checked file and it looks right
# now I just need to save it using write.table.
write.table(mydata2, file = "gacdassign.txt", row.names = F)