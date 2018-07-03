%% Test script for fir2ss.m

s = 4000;       % number of samples
m = 10;          % Model order
p = 2;          % Output vector dimension
q = 3;          % Input vector dimension

% Make coefficients
B = [];
for k=1:m
    B = [B, randn(p,q)];
end

% Make input sequence
u = rand(q,s);

% Construct data matrix and output
for k=m:size(u,2)
    H(:,k) = vec(u(:,k:-1:k-m+1));
end
y = B*H;

% Generate state space model
Bss = fir2ss(B,m,-1);
y1 = lsim(Bss,u')';

error = norm(y(:,m:end)-y1(:,m:end))/norm(y(:,m:end))





