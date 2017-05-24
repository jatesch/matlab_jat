function [H,om] = step_resp(y,ts,poke,differ)
% [H,om] = STEP_RESP(y,ts,poke,differ)
% Differentiates the step response y to obtain an estimate of the 
% frequency response. Assumes step magnitude "poke" and sample time ts.
% differ=0 => no differentiation. om returned in Hz.

% 12/2013 jtesch

if nargin==3
    differ = 1;
end

if ~differ
    M = length(y);
    ydot = y;
else
    M = length(y)-1;
    y = y/poke;
    ydot = diff(y)/ts;
end

w0 = 1/(M*ts);          % fundamental
wn = 1/(2*ts);          % Nyquist
% w0 = (2*pi)/(M*ts);
% wn = (2*pi)/(2*ts);

om = 0:w0:wn;           % frequency axis



H = fft(ydot)*ts;
H = H(1:length(om));