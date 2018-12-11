function ix = recognise_hpnn(pattern,A,W)

BP1 = pattern;

% Multiply pattern by weight
Pm = pattern(1:10);


% Multiply
R = W*Pm;

% Make bipolar
BP = double(R>0);
BP = 2*BP-1;

% Get minimum distance
m1 = repmat(BP1,[1 size(A,2)]);

% Find zero difference
op = sum(A-m1);

ix = find(op==0);