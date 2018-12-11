clc;
clear all;
close all;
%%
A = round(rand(10,10));
A(A==0) = -1;

% net = newhop(A);
x = A(:,52);
% % test={A(:,50)};
% % x = round(rand(100,1));
% % x = 2*x-1;
% test = {x};
% [Y,Pf,Af] = sim(net,{1 10},{},test);
% op = Y{1};
% 
tic
op = repmat(x,[1 size(A,2)]);

op = A-op;
find(sum(abs(op))==0)
toc
tic

for ii = 1:size(A,2)
    
    
    for jj = 1:size(A,1)
        b(jj) = abs(A(jj,ii)-x(jj));
    end
    d(ii) = sum(b);
end
[v ix] = min(d);

ix
toc
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