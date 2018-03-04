function [Ghat,Yhat,s] = impulse2ss(Y,nu,n)
% [Ghat,Yhat,s] = impulse2ss(Y,nu,n)
% Computes a state space realization of order n using the inpuse response
% sequence Y. This is done using the Ho-Kalman realization algorithm based on
% the SVD of a Hankel matrix formed by g. 
%
% Inputs:
% -------
% Y : matrix
%   Impulse response sequence containing Markov parameters in the form
%       Y = [D C*B C*A*B C*A^2*B C*A^3*B ...]
%   For state space matrices (A,B,C,D).
%
% nu : integer
%   Number of inputs, i.e. the number of columns of D.
%
% n : integer (optional)
%   Number of states in the desired state space model. If n is not specified or
%   empty, the number of states is determined by the rank of the Hankel matrix.
%
% Outputs:
% -------
% Ghat : state space object
%   Identified state space system in unit sampling frequency.
%
% ghat : matrix
%   Impulse response sequence of Ghat
%
% s : vector
%   Hankel singular values.
%
% References:
% ----------
%   S. Gibson, MAE275 Class Notes, Spring 2007. Specifically Theorem 2.15
%   (Realization Algorithm).

% Jonathan A. Tesch, Jet Propulsion Lab, 2018

if n==2, n=[]; end

% Extract D matrix from first nu columns
D = Y(:,1:nu);
Y(:,1:nu) = [];

% Compute p and q such that max Markov term is C*A^(p+q-1)*B
[ny,ng] = size(Y);
nm = ng/nu;
p = floor(nm/2);
q = p-1;            

% Build Hankel matrices row by row
H0 = [];
H1 = [];
for i=1:p
    H0 = [H0; Y(:,1:q*nu)];
    Y(:,1:nu) = [];     % remove first Markov term
    H1 = [H1; Y(:,1:q*nu)];
end

% Compute realization
[U,S,V] = svd(H0);
s = diag(S);
if isempty(n)
    nx = rank(H0);
else
    nx = n;
end

S2 = sqrt(S(1:nx,1:nx));
Op = U(:,1:nx)*S2;      % Observability matrix
Cq = S2*V(:,1:nx)';     % Controllablity matrix

B = Cq(:,1:nu);
C = Op(1:ny,:);
A = inv(S2)*U(:,1:nx)'*H1*V(:,1:nx)*inv(S2);
Ghat = ss(A,B,C,D,-1);
Yhat = [];


