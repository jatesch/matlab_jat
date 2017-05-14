function N = tfnorm(G,typ)
% TFNORM(G,typ) computes the norm of each entry in the transfer matrix G.
% Optional argument typ specifices the norm computed (2 or 'inf').


if nargin==1, typ = 2; end

if strcmp(class(G),'ss'), G = tf(G); end

[ny,nu] = size(G);


for y=1:ny
    for u=1:nu
        
        g = tf(G.num{y,u},G.den{y,u},G.ts,'variable',G.variable);
        N(y,u) = norm(g,typ);
        
    end
end
        
