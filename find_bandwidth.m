function bw = find_bandwidth(px,freq,m)
% bw = FIND_BANDWIDTH(px,freq,m) uses interpolation to compute the m dB crossover frequency
% of the power specrum contained in px. If unspecified, m = -3dB.
% Assumes px is NOT in dB.

if nargin==2
    m = -3;
end

px = 20*log10(px);


% Throw out 0Hz
if freq(1)==0
    freq = freq(2:end);
    px = px(2:end);
end

idx = find(px>=m, 1, 'first');

df = (freq(idx+1)-freq(idx))/100;       % interpolation size

if idx-2>0
    freq2 = freq(idx-2):df:freq(idx+2);
    px2 = interp1(freq(idx-2:idx+2),px(idx-2:idx+2),freq2);

elseif idx-1>0
    freq2 = freq(idx-1):df:freq(idx+2);
    px2 = interp1(freq(idx-1:idx+2),px(idx-1:idx+2),freq2);
    
else
    freq2 = freq(1):df:freq(idx+2);
    px2 = interp1(freq(1:idx+2),px(1:idx+2),freq2);
end


% find crossover frequency
idx = find(px2 > m,1,'first');
bw = freq2(idx);



