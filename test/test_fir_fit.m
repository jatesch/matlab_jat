% Vector MA example
clear

s = 4000;    % number of samples
M = 4;          % Model order
p = 3;          % Output vector dimension
q = 3;          % Input vector dimension

B = rand(p,q*M);
u = rand(q,s);
y = zeros(p,s);


% Construct data matrix
for k=M:s
    H(:,k) = vec(u(:,k:-1:k-M+1));
end

% Implement filter
y = B*H;

% Estimate B from output 
H = H(:,M:end);
Y = y(:,M:end);

B_est = fir_fit(y,u,M);

error = norm(B-B_est)/norm(B)
