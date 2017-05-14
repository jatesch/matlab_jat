function gmesh(img,mk)
% Grayscale image of img or img reshaped



if nargin==2
    
    [nrows,ncols] = size(mk);
    
    if nrows==1 || ncols==1
        n = sqrt(length(mk));
        mk(mk~=0) = img;
        img = reshape(mk,n,n);
    end
    
    
    
else
    [nrows,ncols] = size(img);
    
    if nrows==1 || ncols ==1
        n = sqrt(length(img));
        img = reshape(img,n,n);
    end
    
end
mesh(img);
