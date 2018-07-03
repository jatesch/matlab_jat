function B = fir_fit(y,u,n)
% B = fir_fit(y,u)
% Finds FIR filter coefficients [B(0) B(1) B(2) ... B(n-1)]
%   y(t) = B(0)*u(t) + B(1)*u(t-1) + ... + B(n-1)*u(t-n)
%
% Inputs:
% ------
% y : matrix
%   Output time series where each column is a sample.
%
% u : matrix
%   Input time series where each column is a sample.
%
% n : scalar
%   Desired number of FIR coefficients.
%
% Outputs:
% --------
% B : matrix
%   Matrix of FIR coefficients.

[ny,ns] = size(y);
[nu,~] = size(u);

% Make data matrix
H = [];
for k=n:ns
    h = vec(u(:,k:-1:k-n+1));
    H = [H, h];
end

y = y(:,n:end);
%B = (H'\y')';
B = (pinv(H')*y')';
