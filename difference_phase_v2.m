function [difference] = difference_phase_v2(data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here,
[a,b] = size(data);

data_windowed = data.*blackman(a);
X = 20*log10(fftshift(abs(fft(data(:,1)))));
[mag_x, idx_x] = max(X);
X = fft(data(:,1));

difference = zeros(1,b);
for i = 1:b
    Y = 20*log10(fftshift(abs(fft(data(:,i)))));

    % determine the phase 
    % at the maximum point.
    
    [mag_y, idx_y] = max(Y);
    Y = fft(data(:,i));

    
    theta_x = angle(X(idx_x));
    theta_y = angle(Y(idx_y));
    
    phase_lag = theta_y - theta_x;
    difference(i) = phase_lag;
end     
end

