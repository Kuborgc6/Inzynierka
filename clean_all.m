function data_clean = clean_all(data, f_bandpass, fs)

[a, b] = size(data);
data_clean = zeros(size(data));

for i = 1:b
    x = data(:,i);
    if f_bandpass(1) <= 0
        y_band = lowpass(x,f_bandpass(2), fs);
    else
        y_band = bandpass(x,f_bandpass, fs);
    end
    data_clean(:,i) = y_band;
end