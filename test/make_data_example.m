%% Example of making fake data with a particular PSD

ts = 0.001;         % sample time
n = 10000;

%% Make data with an interesting PSD

xi = 0.1;
wn = 2*pi*50;
G = c2d(tf(wn^2,[1 2*xi*wn wn^2]),ts);
e = lsim(G,randn(n,1));


%% Make a new sequence with a similar PSD

[~,F] = make_data(e,ts);
f = lsim(F,randn(n,1));     % make new data

[pe,om] = pwelch(e,512,[],[],1/ts);
[pf,~] = pwelch(f,512,[],[],1/ts);

figure;
loglog(om,pf); hold on;
loglog(om,pe);
xlabel('Frequency (Hz)'); ylabel('PSD');
legend('Realizatio','Original');
