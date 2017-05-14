function C = circ(N,R)
% out = circ(N,R)
% Creates a circle of radius R embedded in a NxN matrix.

C = zeros(N);

[X,Y] = meshgrid(-N/2:N/2-1,-N/2:N/2-1);
X = X+0.5; Y = Y+0.5;

Z = sqrt(X.^2 + Y.^2);

C(Z<R) = 1;