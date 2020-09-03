%{
Jacquelyn Jung 861107968
4/28/17
CS171 PS2
%}
function [k,lnorm] = cvknn(Xtrain,Ytrain,Xvalid,Yvalid,maxk)
% 
% a starting shell
% your solution should find the best k (from 1 to maxk, skipping even values)
% and lnorm (1 = Manhattan distance, 2 = Euclidean distance) combination
% for k-nearest neighbor using the supplied training and validation sets
%
% In doing so, it should generate a plot (do *not* call "figure" -- the
% calling function will set up for the right figure window to be active).
% The plot should be as described and illustrated in the problem set.

%create blank arrays to store the infor 
M_Error = zeros(1, maxk);
E_Error = zeros(1, maxk);

%go through the different values 
for x = 1:2:maxk
    E_Val = 0;
    M_Val = 0;
    
    %find the k nearest neighbor for the values 
    for i = 1:size(Xvalid)
        %use bsxfun to do the subtraction 
        E_Dis = sqrt(sum(bsxfun(@minus, Xtrain, Xvalid(i,:)).^2, 2));
        M_Dis = sum(abs(bsxfun(@minus,Xtrain, Xvalid(i,:))), 2);
        
        %sort distances from least to greatest using sortrows 
        E_Dis = [E_Dis, Ytrain];
        E_Dis = sortrows(E_Dis);
        M_Dis = [M_Dis, Ytrain];
        M_Dis = sortrows(M_Dis); 
        
        %see if value is correct 
        E_Correct = 0;
        M_Correct = 0;
        for j = 1:x
             %if manhattan is correct 
            if M_Dis(j, end) == Yvalid(i)
                M_Correct = M_Correct + 1;
            end
            %if euclidean is correct 
            if E_Dis(j, end) == Yvalid(i)
                E_Correct = E_Correct + 1;
            end
        end 
        
        if M_Correct < x/2
            M_Val = M_Val + 1;
        end
        if E_Correct < x/2
            E_Val = E_Val + 1;
        end
    end
    
    M_Val = M_Val / size(Xvalid, 1);
    E_Val = E_Val / size(Xvalid, 1);
    M_Error(1, x) = M_Val;
    E_Error(1, x) = E_Val;
    
end

%set values for k and lnorm
val1 = min(E_Error(1:2:maxk));
val1 = min(val1);
val2 = min(M_Error(1:2:maxk));
val2 = min(val2);
k = 0;

if val1 <= val2
    for i = 1:2:maxk
    	if val1 == E_Error(i)
            k = i;
            break;
        end
    end
    lnorm = 2;
else
    for i = 1:2:maxk
    	if val2 == M_Error(i)
            k = i;
            break;
        end
    end
    lnorm = 1;
end

%plot the 2 graphs 
hold on;
M_Error = M_Error;
E_Error = E_Error;
plot((1:2:maxk), M_Error(1:2:maxk), 'bo-');
plot((1:2:maxk), E_Error(1:2:maxk), 'go-');
xlabel('k')
ylabel('Error Rate')
legend('Manhattan', 'Euclidean', 'Location', 'southeast')

hold off;
end
