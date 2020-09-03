%{
Jacquelyn Jung 861107968
4/30/17
CS171 PS2
%}
function runq1(fname)
%importing data from file passed in
data = load(fname);

y = data(:,30);
x = data(:, 1:29);

%find the best feature using linear values
w = 0;
lambda = 10;
cnt = 0;
while lambda > 1
    temp = learnlogreg(x, y, lambda);
    if temp >= w
        w = temp;
    end
    lambda = lambda/2;
end
disp(w);

%add the quadratic values by multiplying linear values

