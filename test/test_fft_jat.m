%% Tests fft_jat.m and idea of identifying aliases with multiple sample rates

tstop = 5;

% Create some frequency content
fs0 = 10000;        % native sampling rate (Hz)
w1 = 145*2*pi;       % low frequency signal (rad/sec)
w2 = 800*2*pi;     % high frequency signal (rad/sec)

a1 = 10;
a2 = 8;
sig = 0.1;

t0 = 0:1/fs0:tstop;
y = @(x) a1*sin(w1*x) + a2*cos(w2*x) + sig*randn(size(x));
y0 = y(t0);
[Y0,om0] = fft_jat(y0,1/fs0);

% Sample data at some frequency

fs1 = 1000;
tsamp1 = 0:1/fs1:tstop;
ysamp1 = y(tsamp1);
[Ysamp1,om1] = fft_jat(ysamp1,1/fs1);

% Sample data at another frequency

fs2 = 1200;
tsamp2 = 0:1/fs2:tstop;
ysamp2 = y(tsamp2);
[Ysamp2,om2] = fft_jat(ysamp2,1/fs2);


% Plot results. Aliased peak should move.

figure;
loglog(om0,abs(Y0)); hold on;
loglog(om1,abs(Ysamp1),'r');
loglog(om2,abs(Ysamp2),'g');
xlabel('Frequency [Hz]'); ylabel('DFT');
legend('Native','fs1','fs2');

