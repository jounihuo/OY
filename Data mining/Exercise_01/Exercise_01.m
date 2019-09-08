clear all;
close all;

%% 1. GETTING YOUR DATA INTO Matlab

% Overwrite commas to points
comma2point_overwrite('concretedata.csv');

% Read CSV-data
mydata = readtable('concretedata.csv','Format','%u%f%s%s%f%f%f%f%f%f%u%f');

% Read CSV-data with selected delimeter and column names
mydata2 = readtable('concretedata.csv','Delimiter', ';' , 'ReadVariableNames', false);

% Read CSV-data, treat NA as empty
mydata3 = readtable('concretedata.csv', 'TreatAsEmpty',{'.','NA','N/A'});

% Clearing variable
clear mydata2;

% Saving the workspace
save('workspace.mat');

% Saving a variable
save('testfile.mat', 'mydata3');

% Loading workspace
load('workspace.mat');

% Writing data to file
writetable(mydata,'mydata.txt');

%% 2. SIMPLE DATA ANALYSIS

% Check if variable is a table
istable(mydata)

% Check table size
size(mydata)

% Show the head of the table
head(mydata)
% Show the head of the table, first 10 rows
head(mydata, 10)

% Show the end of the file
tail(mydata)

% Show summary of the data
summary(mydata)

% Get column names
mydata.Properties.VariableNames

% Let's make an empty array
mymatrix = zeros([10 12])
% Turn it into a table
mymatrix = array2table(mymatrix)
% And assing names
mymatrix.Properties.VariableNames = mydata.Properties.VariableNames

% Data can be referenced by name
mydata.water

%% 3. BASIC STATISTICS

% Calculating the correlations between 2 variables in data set
corr(mydata.cement, mydata.coarse_aggregate)

% Calculating mean with out NAs
mean(mydata.cement, 'omitnan')

% You can calculate means or medians for the data table, and 
% by selecttion
median(mydata{:,[1:2,5:12]},1)
median(mydata{:,[1:2,5:12]},2)

% Getting help
help median

%% 4. SELECTING DATA

% Selecting columns
mydata(:,2:4)

% Selecting specific columns
mydata(:, [ 2,4])

% Select all observations with value >20 for variable age?
mydata.age > 20 % logical

% Compare the result to this one:
mydata.age(mydata.age>20) % values

% Selecting both rows and columns
mydata(mydata.age>20,[2:4])

% or refer to columns by their names
mydata(mydata.age>20,{'age', 'cement'})

% Other way
age20 = mydata.age>20;
cols = {'age', 'cement'}
mydata(age20, cols)

% Observations that have the maximum value of variable age
mydata(mydata.age==max(mydata.age),:)

%% 5. DATA VISUALIZATION

catdata = mydata.grade; % a categorical variable
tabulate(catdata)

plot(mydata.water)

% Plot to report
scatter(mydata.water, mydata.age)
title('Water vs. age')
xlabel('water') % x-axis label
ylabel('age') % y-axis label

% Saving the plot
saveas(gcf,'water_vs_age.png')

close all