function [difference] = difference_phase_v2(data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here,
[a,b] = size(data);

% data = data.*blackman(a);
X = 20*log10(fftshift(abs(fft(data(:,1)))));
[mag_x, idx] = max(X);
X = fft(data(:,1));
theta_x = angle(X(idx));


difference = zeros(1,b);
for i = 1:b
    
%     Y = 20*log10(fftshift(abs(fft(data(:,i)))));
%     [mag_y, idx_y] = max(Y);
    Y = fft(data(:,i));

    theta_y = angle(Y(idx));
    
    phase_lag = theta_y - theta_x;
    difference(i) = phase_lag;
end     
end

