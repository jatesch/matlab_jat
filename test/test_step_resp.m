%% Script to compare methods for computing frequency response from step response data.
% Spoiler alert: both methods are about the same

% Make a system
ts = 1/5000;             % system sample time
tstop = 0.01;
xi = 0.5;
wn = 1500*2*pi;      % [rad/sec]
P = tf(wn^2,[1 2*xi*wn wn^2],tf);
P = c2d(P,ts,'zoh');

% Get step response
t = 0:ts:tstop;
r = step(P,t);



% Estimate frequency response 2 ways...
ntrials = 1000;
sig = 0.05;

Havg = 0;
Hpavg = 0;
for k=1:ntrials
    r = step(P,t) + sig*randn(length(r),1);
    [tmp,om] = step_resp(r,ts,1,1); 
    Havg = Havg + tmp;

    Phat = ssreal(r,[],'step');  
    Phat.ts = ts;
    tmp = squeeze(freqresp(Phat,om,'Hz'));
    Hpavg = Hpavg + tmp;
end
Havg = Havg/ntrials;
Hpavg = Hpavg/ntrials;


% Compute true frequency response
H0 = squeeze(freqresp(P,om,'Hz'));


figure;
loglog(om,abs(H0),'k');   
hold on;
loglog(om,abs(Hpavg),'g');
loglog(om,abs(Havg),'r');
title(sprintf('Avg frequency response from %d trials',ntrials));
legend('True response','Using ssreal.m','Using step\_resp.m');



