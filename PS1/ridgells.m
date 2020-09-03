%{
Jacquelyn Jung 861107968
4/13/17
CS171 PS1
%}
function [w,b] = ridgells(X, Y, lambda)
%get the size for the almost identity matrix and create it
[m,n] = size(X);
if((m>n) == 1)
    I = eye(n);
    I(1,1) = 0;
else
    I = eye(m);
    I(1,1) = 0;
end

%use the formula given to find w and b
P1 = transpose(X) * X;
P2 = transpose(X) * Y;
P1 = P1 + (lambda * I);
P1 = inv(P1);
w = P1 * P2;
b = w(1);

