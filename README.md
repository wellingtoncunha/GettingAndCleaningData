ReadingAndCleaningDataProject
=============================

This repo contains the script and code book files for the Reading and Cleaning data couse project.

We were assigned to a project that gets data that was collected by a smartphone (Samsung Galaxy S II) related to a study about wearable devices. In this study, 30 volunteers were asked to perform some activities wearing the device on the waist. The data collected by embedded accelerometer and gyroscope inside the device was compiled and result in a dataset containing 561 different measures.

In the project, we were asked to merge all the files that was available for that study, select some of the measures (average and standard deviation) and generate a two new datasets, one of the, into a file.

Source Files needed:
- activity_labels.txt: contains the description of activity codes from files y_test.txt and y_train.txt
- features.txt: contains the labels of the columns, which indicate what data is presented in each column 
- subject_test.txt: contains the subject code of each observation present on X_test.txt 
- subject_train.txt: contains the subject code of each observation present on X_train.txt
- X_test.txt: contains the data that was collected by wearable device and was randomly defined as test
- X_train.txt: contains the data that was collected by wearable device and was randomly defined as train
- y_test.txt: contains the activity performed of each obeservation present on X_test.txt
- y_train.txt: contains the activity performed of each obeservation present on X_train.txt

Files available inside this repo:
- CodeBook.md: this file contains the explanation about the dataset itself
- run_analysis.R:
	* Contains the script to generate the two datasets and also the file requested in the assigment
	* All the source files should be available into just one folder and this folder should be set as the working directory
	* The script performs the following steps:
		1 - Sets the working directory where the source files should be and where the final file would be generated
		2 - Loads training subjects (subject_train.txt) and activities (y_train.txt), add the description for activities (inside activity_labes.txt file), set the column names and bind the two datasets
		3 - Loads the file that contains the variables names (features.txt), selects just the mean and std columns and change the column labels in order to better descript what data are on that column
		4 - Loads the measures file for training (X_train.txt), select the columns and add the column labels. After that, binds this dataset with the dataset that contains the train subjects and activities
		5 - Loads test subjects (subject_test.txt) and activities (y_test.txt), add the descriptive labels for the activities and bind the two datasets
		6 - Loads the measures files for tests (X_test.txt), select columns and add the column labels. After that, binds this dataset with the dataset that contains the test subjects and activities
		7 - Merges the two main datasets (Train and Test datasets)
		8 - Creates the second dataset with the mean of all measures and sort it by subject and activity
		9 - Generate the file that contains the main dataset (not the aggregated)
	* More details about the tasks performed are present as comments inside the script
		
