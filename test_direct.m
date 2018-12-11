function ix = test_direct(x,A)


for ii = 1:size(A,2)
    
    
    for jj = 1:size(A,1)
        b(jj) = abs(A(jj,ii)-x(jj));
    end
    d(ii) = sum(b);
end
[v ix] = min(d);
