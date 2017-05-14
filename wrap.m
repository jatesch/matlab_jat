function z = wrap(a)
% Wraps all the elements in the input matrix to [-pi,pi]

z = zeros(size(a));

x = cos(a);
y = sin(a);

idx = find(a<=pi & a>=-pi);
z(idx) = a(idx);

idx = find(y<0 & x<0);
z(idx) = asin(abs(y(idx))) - pi;

idx = find(y<0 & x>0);
z(idx) = asin(y(idx));

idx = find(y>0 & x<0);
z(idx) = pi-asin(y(idx));

idx = find(y>0 & x>0);
z(idx) = asin(y(idx));
