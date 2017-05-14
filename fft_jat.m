function [Y,om] = fft_jat(y,ts)
% [Y,om] = fft_jat(y,ts)
% Computes the one sided Fourier Transform F and corresponding freqency axix

M = length(y);
w0 = 1/(M*ts);          % fundamental
wn = 1/(2*ts);          % Nyquist
om = 0:w0:wn;           % (one sided) frequency axis

Y = fft(y);
Y = Y(1:length(om));