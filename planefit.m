function [n,v,mc] = planefit(c)
% [n,v,mc] = planefit(c)
% Estimate a normal vector that defines a plane fit to the point cloud c.
%
% Inputs:
%   c (matrix)
%       3xN matrix of N points
%
% Ouputs:
%   n (vector)
%       3x1 vector orthogonal to the plane that best fits c.
%
%   mc (vector
%       3x1 vector that defines the mean of the point cloud.
%
%   v (matrix)
%       3x2 matrix defining an orthogonal basis for the plane.

mc = mean(c,2);
[V,D] = eig(c*c');
n = V(:,1);
v = V(:,2:end);


