

% Make a point cloud

v = randn(3,1);
v = v/norm(v);

plane = @(r,v) v(1)*r(1,:) + v(2)*r(2,:) + v(3);

nc = 30;
c = randn(2,nc);
c = [c; plane(c,v)+0.1*randn(1,nc)];

% Estimate
[n,b,mc] = planefit(c);

figure;
plot3(c(1,:),c(2,:),c(3,:),'o');
hold on;
quiver3(mc(1),mc(2),mc(3),n(1),n(2),n(3)); 
quiver3(mc(1),mc(2),mc(3),b(1,1),b(2,1),b(3,1));
quiver3(mc(1),mc(2),mc(3),b(1,2),b(2,2),b(3,2));


