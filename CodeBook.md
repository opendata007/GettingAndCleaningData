description of the variables used in run_analysis.R

activity_labels: data read from activity activity_lables.txt file

features: data read from features.txt file

test: test data
train: training data

testActivity: activities in y_test.txt file
trainActivity: activities in y_train.txt file

testSubject: subjects in Subject_test.txt file
trainSubject: subjects in Subject_train.txt file

relFeatures: features which are relevant for mesurements ( meand ans tandrad deviation mesurements)
This is an index variable with the index of the relevant variables.

relFeatures.Names: names of the relevant variables

all_data: merged data from test an dtrain data sets

all_data.melted: dataset with melted columns with ID subject and activity

all_data.mean: mean if the dataset by subject and activity

