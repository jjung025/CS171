%{
Jacquelyn Jung 861107968
4/13/17
CS171 PS1 
%}
function plotdata(fname)
%importing data from file passed in
d = load(fname);

%set y axis points
y = d(:, 14);

%plot each feature
for loc = 1:13
    subplot(4,4,loc)
    x = d(:, loc);
    scatter(x,y)
    ylabel('y');
    xlabel(strcat('feature ', num2str(loc)));
end

