function Hss = fir2ss(H,h,ts)
% H = fir2ss(Hm,h,ts)
% Makes a state-space system from the FIR filter with coefficient matrices
% contained in H.
%
% If H = [H(1) H(2) ... H(h)], fir2ss assumes the following FIR filter:
%
%   y(t) = H(h)*w(t) + H(h-1)*w(t-1) + H(h-2)*w(t-2) + ... + H(1)*w(t-h+1)

if nargin==2, ts = -1; end

[l,n] = size(H);
m = n/h;    % dimension of each FIR coefficient

if rem(m,1)~=0
    error('H has an inconsistent number of columns');
end

Ah = [zeros(m*(h-2),m), eye(m*(h-2))];
Ah = [Ah; zeros(m,m*(h-1))];
Bh = [zeros(m*(h-2),m); eye(m)];

% There's probably a better way to do this...
Ch = [];
for k=1:h-1
    Ch = [Ch, H(:,end-m+1:end)];
    H(:,end-m+1:end) = [];
end
Dh = H;

Hss = ss(Ah,Bh,Ch,Dh,ts);




