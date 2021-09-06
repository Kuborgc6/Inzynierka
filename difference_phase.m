function [difference] = difference_phase(data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
X=(fft(data(:,1)));
[a,b] = size(data);
difference = zeros(1,b);
for i = 1:b
    Y=(fft(data(:,i)));
% Determine the max value and max point.
% This is where the sinusoidal
% is located. See Figure 2.
    [mag_x, idx_x] = max(abs(X));
    [mag_y, idx_y] = max(abs(Y));
% determine the phase 
% at the maximum point.
    px = angle(X(idx_x));
    py = angle(Y(idx_y));
    phase_lag = py - px;
    difference(i) = phase_lag;
end     
end

