clear

tstop = 5;
ts = 1/100;

m = 3;          % Model order
p = 2;          % Output vector dimension
q = 3;          % Input vector dimension

B0 = randn(p,q);
B1 = randn(p,q);
B2 = randn(p,q);
B = [B0,B1,B2];

sim('fir.slx')
u = squeeze(u);
y = y';


% Construct data matrix
for k=m:size(u,2)
    H(:,k) = vec(u(:,k:-1:k-m+1));
end

% Implement filter
y2 = B*H;

% Generate state space model
Bss = fir2ss(B,m,ts);
y3 = lsim(Bss,u')';

