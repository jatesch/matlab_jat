% Test script for ssreal.m


% Make a transfer function
ts = 1/5000;             % system sample time
tstop = 0.01;
xi = 0.5;
wn = 1500*2*pi;      % [rad/sec]
P = tf(wn^2,[1 2*xi*wn wn^2],tf);
P = c2d(P,ts,'zoh');

% Get step response
t = 0:ts:tstop;
r = step(P,t);

% Estimate system
Phat = ssreal(r,5,'step');
Phat.ts = ts;

bode(P); hold on;
bode(Phat,'r.');

fprintf('\nEstimation error: %d\n', norm(P-Phat)/norm(P));

