%Jacquelyn Jung
%861107968
%5/28/17
%CS 171 PS4

%Calculate the giniscore of values passed in
function s = scorefn(val)
s = 0;
    for i = 1:size(val)
        s = s + (val(i) * (1 - val(i)));
    end
end

