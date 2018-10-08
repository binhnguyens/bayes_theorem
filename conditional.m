function [output] = conditional(x,class)

s = std(class);
avg = mean (class);

first = 1./ (sqrt(2*pi)*s);
third = -0.5*(((x-avg)/s)^2);
second =exp (third);

output = first * second;




end

