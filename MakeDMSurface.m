
function [surf_map, x, y] = MakeDMSurface(u, dm, x, y)

   % ---------------------------------------------------------
   % Generate DM surface based on influence function sampling
   % ---------------------------------------------------------

   dx = (dm.x_inf(2)-dm.x_inf(1))./dm.act_dist;
   dy = (dm.y_inf(2)-dm.y_inf(1))./dm.act_dist;

   dx = round(dx*1000)/1000;
   dy = round(dy*1000)/1000;

   lx = length(dm.x_inf).*dx;
   ly = length(dm.y_inf).*dy;

   nx = size(u,2);
   ny = size(u,1);

   xs = [(1-lx/2):dx:(nx+lx/2)];
   ys = [(1-ly/2):dy:(ny+ly/2)];

   [xa ya] = meshgrid(xs,ys);

   xi = [];
   for m=1:nx;
      xi(m) = find(xs==m);
   end
     
   yi = [];
   for m=1:ny;
      yi(m) = find(ys==m);
   end

   g = 0*xa;

   for m=1:size(u,1)
      for n=1:size(u,2)
         g(yi(m),xi(n)) = u(m,n);
      end
   end
    
   G = fft2(g);
   A = fft2(pad(dm.act_inf,size(xa,1)));

   surf_map = real(fftshift(ifft2(G.*A)));

   % ---------------------------------------------------------

   if nargin == 2

      xs = (xs - mean(xs)).*dm.act_dist;
      ys = (ys - mean(ys)).*dm.act_dist;

      [x y] = meshgrid(xs,ys);
      return ;

   elseif nargin == 4

      xs = (xs - mean(xs)).*dm.act_dist;
      ys = (ys - mean(ys)).*dm.act_dist;

      [xa ya] = meshgrid(xs,ys);

      %wc = max(size(xa))/2;
      %opdFilter_Rect (surf_map, wc, 0);

      surf_map = interp2(xa, ya, surf_map, x, y, 'cubic');

      surf_map(find(isnan(surf_map)))=0;

      return;
   end


return;
