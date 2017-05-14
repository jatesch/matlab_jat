function [modeimages,S,modal_seq] = KLmodes_filt_images(images,ifilt,bf2)

%  Compute Karhunen-Loeve Modes for a sequence of images.
%
%  The array images(m,n,T) contains T images.  Each image is m x n.
%  Each row of modal_seq is obtained by projecting he original sequence
%  onto one of the K-L modes.
%
%  S contains the square roots of the eigenvalues of the covariance
%  matrix Q of the original images.
%
%
%  Normally, this function will be called with only the one input argument
%  images.  In this case, the original sequence is low-pass filtered
%  before the K-L modes are computed.  If ifilt = 0, the sequence is not
%  filtered, so it can be interesting to compare the two sets of modes.
%
%
%  The low-pass filter is bf2, but the default bf2 should be good.


if nargin < 3,
%    bf1 = fir1(8,.5);   bf2 = ftrans2(bf1); 
    bf1 = [1 2 1]/4;  bf2 = ftrans2(bf1);
end

if nargin == 1,  ifilt = 1;  end

[m n T] = size(images);

maxim = max(max(max(abs(images)))); mineps = maxim * 1e-12;
testcount = 0;
imgindex = zeros(m*n,1);

for i = 1:m,
    for j = 1:n;
        if max(abs(images(i,j,:))) > mineps,
              testcount = testcount + 1;  imgindex(testcount) = (j-1)*m + i;
        end
    end
end
p = testcount;    imgindex = imgindex(1:p);

images2vec = zeros(p,T);  image1 = zeros(m,n);
for t = 1:T,    
    image1 = images(:,:,t); images2vec(:,t) = image1(imgindex);
end

Q = images2vec*images2vec';

if ifilt == 1,
    Ffilt = build_Ffiltmn1(m,n,imgindex,bf2);   Q = Ffilt*Q*Ffilt';
end

[U S V] = svd(Q);
S = diag(S);
S = sqrt(S);

modal_seq = U'*images2vec;

modeimages = zeros(m,n,p);
for j = 1:p,
    image1 = zeros(m,n);    image1(imgindex) = U(:,j);
    modeimages(:,:,j) = image1;
end

%figure;plot(S);grid;    title('S Values');  xlabel('Mode Number');


function Ffilt = build_Ffiltmn1(m,n,imgindex,bf2);

ni = max(size(imgindex));
Iimage = zeros(m,n);    fimage = Iimage;

Ffilt = zeros(ni,ni);
for j = 1:ni,
    Iimage = zeros(m,n);    Iimage(imgindex(j)) = 1;
    fimage = filter2(bf2,Iimage);
    x = fimage(imgindex);   
    Ffilt(:,j) = x;
end
