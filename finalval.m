function fv = finalval(G,ts)
% F = FINALVAL(G,ts) computes the final value of the discrete-time transfer
% function object G in response to a unit step.

if nargin==1, ts = -1; end

Gfv = minreal(G*tf([1 -1],1,-1)*tf([1 0],[1 -1],ts));  
fv = evalfr(Gfv,1);

