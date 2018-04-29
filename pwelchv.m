function [px,w] = pwelchv(X,window,noverlap,nfft,fs)
% [px,w] = pwelchv(X,window,noverlap,nfft,fs)
% Computes a PSD via pwelch for each column of X.

px = [];
for k=1:size(X,2)
    [p,w] = pwelch(X(:,k),window,noverlap,nfft,fs);
    px = [px, p];
end



