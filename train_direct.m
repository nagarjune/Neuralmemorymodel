function op = train_direct(A)


% intialise weight matrix
op = zeros(size(A));


% Calculate weight matrix
for ii = 1:size(A,2)
    
    % Get iith pattern
    op(:,ii) = A(:,ii);
    
end
