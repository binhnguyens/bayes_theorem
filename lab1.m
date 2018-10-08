%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BME777: LAB 1: Bayesian Decision Theory.

% Acknowledgement: We thankfully acknowledge UCI Machine Learning Repository for the 
%dataset used in this lab exercise.The data for this lab is extracted from Pima Indians 
%Diabetes Data Set: https://archive.ics.uci.edu/ml/datasets/Pima+Indians+Diabetes
% The first two columns contain the 2nd and 3rd features of the original dataset. 


% 1st feature: Plasma glucose concentration.
% 2nd feature: Diastolic blood pressure (mm Hg).
% The third colum contatins the labels (1: positive, 2: negative) for diabetes.
% 268 samples were extracted for each class.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs:
% 1. FeatureX: Feature value to be tested (to identify which class it belongs to).
% 2. Data: Matrix containing the training feature samples and class labels.
% 3. FeatureForClassification: Select type of feature used for
% classification. (1 or 2)
% 4. LabelColumn: Specify the column containing the labels of the data.
% Outputs:
% 1. PosteriorProbabilities: Posterior probabilities of class 1 and 2 given FeatureX.
% 2. DiscriminantFunctionValue: Value of the discriminant function given FeatureX.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example of use:
% load Diabetes.mat;
% FeatureX = 5;
% LabelColumn = 3;
% FeatureForClassification = 1;
% [PosProb, G] = lab1(FeatureX, Diabetes,FeatureForClassification, LabelColumn);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






function [PosteriorProbabilities,DiscriminantFunctionValue]=lab1(FeatureX,Data,FeatureForClassification, LabelColumn)

% Get number of samples.
[ro,~] = size(Data);

% Select feature for classification (1 or 2).  
SelectedFeature=Data(:,FeatureForClassification);


% Get class labels.
Label=Data(:,LabelColumn); 


%Separating to class 1 and class 2
z=1;
w=1;
for i =1:ro
   if Label(i) ==1
       class1 (z) = SelectedFeature(i); %class 1 is positive
       z=z+1;
   elseif Label(i)==2
       class2 (w) = SelectedFeature(i); %class 2 is negative 
       w=w+1;
   end
end


%%%%%%%%Plot the histogram and box plot of features related to two classes%%%%%%%%%%
% 
% % Plot hist.
% figure;
% histogram (class1);
% hold on;
% histogram (class2);
% title ('Histogram of Class 1 and Class 2');
% xlabel ('Sample');
% ylabel ('Amplitude');
% legend ('class 1', 'class 2');
% 
% % Plot boxplot.
% figure;
% subplot (2,1,1);
% boxplot (class1);
% title ('Boxplot of class 1');
% xlabel ('All Samples');
% ylabel ('Amplitude');
% 
% subplot (2,1,2);
% boxplot (class2);
% title ('Boxplot of class 2');
% xlabel ('All Samples');
% ylabel ('Amplitude');

% 
% close all
    
%%%%%%%%%%%%%%%%%%%%%%%Compute Prior Probabilities%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate prior probability of class 1 and class 2.


Pr1=numel(class1)/ro; %Prior probability of saying yes
Pr2=numel(class2)/ro; %Prior probability of saying no 

%%%%%%%%%%%%%%%%%%%%Compute Class-conditional probabilities%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the mean and the standard deviation of the class conditional density p(x/w1).
m11=mean (class1);  
std11= std(class1); 

% Calculate the mean and the standard deviation of the class conditional density p(x/w2).
m12=mean(class2); 
std12=std(class2); 

% Calculate the class-conditional probability of class 1 and class 2.
% cp11=conditional (FeatureX, class1); 
% cp12=conditional (FeatureX, class2); 

x=FeatureX;
class = class1;
s = std11;
avg = m11;
first = 1./ (sqrt(2*pi)*s);
third = -0.5*(((x-avg)/s)^2);
second =exp (third);
cp11 = first * second;


class = class2;
s = std12;
avg = m12;
first = 1./ (sqrt(2*pi)*s);
third = -0.5*(((x-avg)/s)^2);
second =exp (third);
cp12 = first * second;

%%%%%%%%%%%%%%%%%%%%%%%Compute the posterior probabilities%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Posterior probabilities for the test feature');

% Calculate the posterior probability of class 1 and class 2.
px = cp11*Pr1 + cp12*Pr2;
pos11= (cp11 * Pr1) / px; 
pos12= (cp12 * Pr2) / px;

PosteriorProbabilities = ([pos11,pos12]);

disp ('Posterior 1     Posterior 2');
disp (PosteriorProbabilities);

%%%%%%%%%%%Compute Discriminant function Value for Min Error Rate Classifier%%%%%%%%



% Compute the g(x) for min err rate class.
disp('Discriminant function value for the test feature');
DiscriminantFunctionValue = pos11-pos12;
disp (DiscriminantFunctionValue);


end