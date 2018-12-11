clc;
clear all;
close all;
%%
A = round(rand(10000,100));
A(A==0) = -1;

net = newhop(A);
x = A(:,52);
% test={A(:,50)};
% x = round(rand(100,1));
% x = 2*x-1;
test = {x};
[Y,Pf,Af] = sim(net,{1 10},{},test);
op = Y{1};

op = repmat(op,[1 size(A,2)]);

op = A-op;
find(sum(abs(op))==0)
% op = net(A(:,1));
% 
% op1 = op>0;
% op1 = double(op1);
% op1(op1==0) = -1;
% 
% % P = {rands(5,4)};
% % [Y,Pf,Af] = net({4 50},{},P);
% % Y{end}
% [A(:,1) op1]