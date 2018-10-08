%Lab 1 part 2 

%Setting up preliminary crap
load ('Diabetes.mat');
FeatureForClassification1 = 1; %First column which is glucose crap
FeatureForClassification2 = 2; %second column which is blood pressure
Data = Diabetes; %Getting the data set 
LabelColumn = 3; %getting the true or negative results of the data 
FeatureX1=70;
FeatureX2=70;

%getting partial conditional prob
[p11, p12] = lab1_pt2(FeatureX1,Data,FeatureForClassification1, LabelColumn)
[p21, p22] = lab1_pt2(FeatureX2,Data,FeatureForClassification2, LabelColumn)


%Conditional prob
P11 = p11 * p21; %positive of the multivariate collection 
P12 = p12 * p22; %negative of the multivariate collection 


z=1;
w=1;
[ro,~] = size(Data);
Label=Data(:,LabelColumn);
for i =1:ro
   if Label(i) ==1
       
       z=z+1;
   elseif Label(i)==2
       
       w=w+1;
   end
end


% Prior prob
pw1 = z /(z+w);
pw2 = w /(z+w);

%Evidence prob
px = pw1*P11 + pw2*P12;

%posterior probability
Pw1X = P11*pw1/px;
Pw2X = P12*pw2/px;
