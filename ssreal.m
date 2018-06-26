function [Ghat,ghat,s] = ssreal(g,N,type)
% [Ghat,ghat,s] = ssreal(g,n)
% Computes a state space realization Ghat of order N using the impulse
% response sequence g. If N is not specified, the model order is chosen
% automatically using the estimated Hankel singular values. 
%
% Inputs:
% -------
% g : vector
%   Impulse response sequence containing the Markov parameters for the system to be realized.
%
% n : integer (optional)
%   Number of states in the desired state space model. If n is not specified or empty, the number of states is determined from the rank of the Hankel matrix.
% 
% type : string (optional)
%   String indicating the type of data contained in g.
%   'impulse' == g is an impulse response sequence.
%   'step' == g is a step response sequence. The resulting estimate is multiplied by a differentiator to produce Ghat.
%
% Output:
% -------
% Ghat : state space object
%   Estimated plant model.
%
% ghat : vector
%   Impulse response sequence of Ghat.
%
% s : vector
%   Hankel singular values.

% jtesch 11/2014

if nargin<2, N = []; end
if nargin<3, type = 'impulse'; end
    

p = floor(length(g)/2);
q = p-1;

D = g(1);
g = g(2:end);


% Make Hankel matrices
H0 = zeros(p,q);
H1 = H0;
for i=1:p, 
    H0(i,:) = g(i:i+q-1); 
    H1(i,:) = g(i+1:i+q);
end

    
% Compute realization
[U,S,V] = svd(H0);
s = diag(S);
if isempty(N), N = rank(H0); end

S2 = sqrt(S(1:N,1:N));
Op = U(:,1:N)*S2;
Pq = S2*V(:,1:N)';

B = Pq(:,1);
C = Op(1,:);
A = inv(S2)*U(:,1:N)'*H1*V(:,1:N)*inv(S2);
Ghat = ss(A,B,C,D,-1);

if ~isempty(type)
    if strcmpi(type,'step')
        d = tf([1 -1],[1 0],-1);
        Ghat = minreal(Ghat*d);
    end
end

ghat = impulse(Ghat,length(g));
