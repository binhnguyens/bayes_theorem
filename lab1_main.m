%Lab 1 Main function

%Setting up preliminary crap
load ('Diabetes.mat');
FeatureForClassification = 1; %First column which is glucose crap
Data = Diabetes; %Getting the data set 
LabelColumn = 3; %getting the true or negative results of the data 
FeatureX=70;


%Getting the results from the posterior function
[posterior, discriminant_fct] = lab1(FeatureX,Data,FeatureForClassification, LabelColumn);


%Threshold 1
z=1;
i=1;
while i<=numel(Data(:,1))

[posterior, discriminant_fct] = lab1(i,Data,FeatureForClassification, LabelColumn);

    if discriminant_fct>=-0.01 & discriminant_fct<=0.01
       threshold1(z)=i;
       z=z+1; 
    end
i=i+1;

end



%Threshold 2
cost11 = 0;
cost12 = 2; 
cost21 = 10;
cost22 = 0;
L = [0 2 ; 10 0];

i=1;
while i<100;

    [posterior, discriminant_fct] = lab1(i,Data,FeatureForClassification, LabelColumn);
    
    R1 = posterior (1) * L(1,1) + posterior (2) * L(1,2);
    R2 = posterior (1) * L(2,1) + posterior (2) * L(2,2);
    
    
    if (R1-R2)<0
        
        threshold2=i;
        break;
        
    end
    
    i=i+1;

end



%Class labels for
%x1 = [180; 130; 50; 80; 100]
x1 = [180; 130; 50; 80; 100];

for i =1:numel(x1)

[posterior, discriminant_fct] = lab1(x1(i),Data,FeatureForClassification, LabelColumn);
 
    if posterior (1)>posterior (2)
       disp('Class label: positive for diabetes (1)');
    else
       disp('Class label: negative for diabetes (2)');

    end
end


