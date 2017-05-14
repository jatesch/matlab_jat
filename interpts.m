function vq = interpts(x,v,xq,method)
% vq = interpts(x,v,xq)
%
% Interpolates a function v defined over domain x to points xq using interp1. 
% If xq lies outside the domain of x, the function v is assumed to be periodic.
% 
% Note each column of v is a channel to be interpolated (as in interp1).

% jtesch 5/2017

if nargin==3, method = 'pchip'; end

xmax = max(x);
[nx,nd] = size(v);

if nx~=length(x)
    error('Rows of v are not equal to the length of x!');
end

vq = zeros(length(xq),nd);
for k=1:length(xq)
    if xq(k)<=xmax
        vq(k,:) = interp1(x,v,xq(k),method);
    else
         vq(k,:) = interp1(x,v,rem(xq(k),xmax),method);
    end
end