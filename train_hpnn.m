function W = train_hpnn(A)


% A where number of columns = no. of users
% and no of rows = no. of pattern per user
% Total pattern
Npattern = size(A,2);

% Crop the pattern
A = A(1:10,:);

% No of samples in pattern
Ns = size(A,1);

% intialise weight matrix
W = zeros(Ns);


% Calculate weight matrix
for ii = 1:size(A,2)
    
    % Get iith pattern
    P = A(:,ii);
    P = P';
    
    % Multiply with transpose
    temp = P'*P;
    
    % Generate idenitiy matrix
    Im = eye(length(temp));
    
    % Substract and contribution matrix
    CM = temp-Im;
    
    % Add with weight matrix
    W = W+CM;
end
