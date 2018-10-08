%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BME777: LAB 1: Bayesian Decision Theory.

function [output1,output2]=lab1(FeatureX,Data,FeatureForClassification, LabelColumn)

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




% output1=numel(find (class1 == FeatureX))/numel(class1);
% output2=numel(find (class2 == FeatureX))/numel(class2);
% This is the category 



    
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
output1 = first * second;


class = class2;
s = std12;
avg = m12;
first = 1./ (sqrt(2*pi)*s);
third = -0.5*(((x-avg)/s)^2);
second =exp (third);
output2 = first * second;


end