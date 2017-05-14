function [turb,F2] = make_data(q,ts,nstates,if_plot)
% [turb,F] = make_data(q,ts,nstates)
% Generates data with the same temporal statistics (and length) as q
%
% Inputs:
%   q           sample sequence with as many columns as channels
%   ts          sample time for q
%   nstates     number of states used in the spectral realization
%               (default nstates=15)
%
% Outputs:
%   turb        Matlab data structure with the same statistics as q
%   F           TF object that generates turb from a white noise input

% jtesch    5/2014


if nargin<3, nstates = 15; end

if nargin<4, if_plot = 0; end

h = iddata(q,[],ts);
F = n4sid(h,nstates);
F2 = ss(F.a,F.k,F.c,F.d,ts);

t = 0:ts:length(q)*ts;
e = randn(length(t),1);

q2 = lsim(F2,e,t);
P1 = pwelch(q,512);
P2 = pwelch(q2,512);

% adjust input covariance (why is this necessary?) and regenerate data
F2.b = F2.b*sqrt((P1(1)/P2(1)));            
q2 = lsim(F2,e,t);
P2 = pwelch(q2,512);

if if_plot
    loglog(pwelch(q,512)); hold on;
    loglog(pwelch(q2,512),'r'); grid on; hold off;
    legend('Original PSD','Realized PSD');
end

turb.time = ts:ts:length(q2)*ts;
turb.signals.values = q2;
