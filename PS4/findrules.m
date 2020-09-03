%Jacquelyn Jung
%861107968
%5/28/17
%CS 171 PS4

function findrules(D, smin, amin)
numTrans = numexamples(D);

itemList = items(D);

test{1} = cell(1,prod(size(itemList)));
count{1} = zeros(size(test{1}));
for ruleTest = 1:prod(size(itemList))
    count{1}(ruleTest) = getcount(itemList(ruleTest), D);
    test{1}{ruleTest} = itemList(ruleTest);
end
 
inc = 1;
pattern{1} = test{1}(count{1} / numTrans >= smin);

while (isempty(pattern{inc}) == 0)
    iter = [];
    for i = 1:prod(size(pattern{inc}))
        iter = union(iter, pattern{inc}{i});
    end
    iter = iter(:)';
    test{inc+1} = {};
    
    for i = 1:prod(size(pattern{inc}))
        inc_2 = pattern{inc}{i};
        for j = 1:prod(size(iter))
            if (ismember(iter(j), inc_2) == 0)
                ifFound = false;
                n = [inc_2 iter(j)];
                for ruleTest = 1:prod(size(test{inc+1}))
                    if(prod(size(n)) ==prod(size(test{inc+1}{ruleTest})) && all(sort(n) == sort(test{inc+1}{ruleTest})))
                        ifFound = true;
                        break;
                    end
                end
                if (ifFound == false)
                    test{inc+1} = [test{inc+1} {n}];
                end
            end
        end
    end
        
    count{inc+1} = zeros(size(test{2})); 
    for patternCnt = 1:prod(size(test{inc+1}))
        count{inc+1}(patternCnt) = getcount(test{inc+1}{patternCnt}, D);
    end
        
    pattern{inc+1} = test{inc+1}(count{inc+1} / numTrans >= smin); 
    inc = inc+1;
end

pattern = pattern(1:end-1);
rules={};
support=[];
lift=[];
confidence=[];

for j = 2:prod(size(pattern))
    for i = 1:prod(size(pattern{j}))
        lcnt = getcount(pattern{j}{i}, D);  
        S = getSub(pattern{j}{i});
        Q = S(end:-1:1);
        for ruleTest = 1:prod(size(S))
            rules = [rules; {S{ruleTest} Q{ruleTest}}];
            ccnt = getcount(Q{ruleTest}, D);
            scnt = getcount(S{ruleTest}, D);
            confidence = [confidence; lcnt / scnt];
            support = [support; lcnt / numTrans];                
            lift = [lift; lcnt / (scnt * ccnt / numTrans)];                       
        end
    end
end
    

[confidence, sortOrder] = sort(confidence,'ascend');
support = support(sortOrder);
lift = lift(sortOrder);
rules = rules(sortOrder,:);
for i = 1:size(rules)
    rules{i, 3} = support(i);
    rules{i, 4} = confidence(i);
    rules{i, 5} = lift(i);
end

finish = rules(confidence >= amin & lift >= 1,:);
for i = 1:size(finish, 1)
    dispS = num2str(finish{i, 3});
    dispC = num2str(finish{i, 4});
    printVals = [dispC, ', ', dispS, ' : ', rule2str(finish{i,1}, finish{i,2}, D)];
    disp(printVals)
end
end

function sub = getSub(val)
    x=prod(size(val));
    
    sub=cell(2^x-2,1);
    for i=1:prod(size(sub))
        s=de2bi(i);
        s=[s zeros(1,x-prod(size(s)))]; 
        sub{i}=val(logical(s));
    end
end