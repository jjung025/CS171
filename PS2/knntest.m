%{
Jacquelyn Jung 861107968
4/28/17
CS171 PS2
%}
function [err,C] = knntest(TrainX, TrainY, TestX, TestY, k, lnorm)
%
% a stub
% your solution should report the total number of errors on the Test
% set using k-nearest neighbors with the supplied k and lnorm
% (lnorm=1 for Manhattan and 2 for Euclidean)
% It should also report C, the confusion matrix.  The i-j element of
% C is the fraction of the total examples who were labeled as class i
% and the true label was class j

%sets C to matrix of 0s
C = zeros(3);

%Go find k nearest neighbor for all points
for x = 1:size(TestX)
    %use the bsxfun function to do the subtraction 
    if lnorm == 2
        distance = sqrt(sum(bsxfun(@minus, TrainX, TestX(x,:)).^2, 2));
    else
        distance = sum(abs(bsxfun(@minus,TrainX, TestX(x,:))), 2);
    end
    
    %order values from least to greatest using the sortrows function
    distance = [distance, TrainY];
    distance = sortrows(distance);
    
    %see if the point is correct 
    c1 = 0;
    c2 = 0;
    c3 = 0;
    for x = 1:k
        if distance(x, end) == 0
            c1 = c1 + 1;
        elseif distance(x, end) == 1
            c2 = c2 + 1;
        elseif distance(x, end) == 2
            c3 = c3 + 1;
        end  
    end
    
    correct = [c1, c2, c3];
    [z curr] = max(correct);
    C(curr, TestY(x) + 1) = C(curr, TestY(x) + 1) + 1;
end

%set values for C and err 
C = C ./ size(TestY,1);
err = 1 - C(1, 1) - C(2, 2) - C(3, 3);
end

