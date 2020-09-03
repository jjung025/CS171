%Jacquelyn Jung
%861107968
%5/28/17
%CS 171 PS4

function [Y, dt] = runq1()
A = load('banktestX.data');
btestX = A;

A = load('banktrain.data');
btrainX = A(:, 1:end-1);
btrainY = A(:, end);

ftypes = [0,12,4,8,3,3,3,2,0,0,0,0,0,3,0,0,0,0,0];

%last 35% of data set for prunning
pX = btrainX(.65 * size(btrainX):end, :);
pY = btrainY(.65 * size(btrainY):end, :);
%first 65% of data set for training 
tX = btrainX(1: .65 * size(btrainX), :);
tY = btrainY(1: .65 * size(btrainY), :);

temp = learndt(tX, tY, ftypes, @scorefn);
dt = prunedt(temp, pX, pY);
drawdt(dt)
Y = predictdt(dt, btestX);
end

