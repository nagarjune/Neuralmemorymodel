clc;
clear all;
close all;
%%
A = round(rand(20,40));
A(A==0) = -1;
% No of pattern
Np = size(A,1);

% No of bits per pattern
Nb = size(A,2);

% Weight
W = A'*A;

for ii = 1:Np
    
    % Get pattern
    P = A(:,ii);
    
    temp = A'*P;
    
    Idmat = eye(length(temp));
    
    Cmat = Idmat*temp;
    
    W(ii,:) = Cmat;
    
    W*P
    
    
    
end