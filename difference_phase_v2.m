function [difference, difference_hil] = difference_phase_v2(data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here,
[a,b] = size(data);

data = data.*blackman(a);
x1 = hilbert(data(:,1));

X = 20*log10(fftshift(abs(fft(data(:,1)))));
[mag_x, idx] = max(X);
X = fftshift(fft(data(:,1)));
tol = 1e-6;
X(abs(X) < tol) = 0;
theta_x = angle(X(idx));

difference = zeros(1,b);
difference_hil = zeros(1,b);
for i = 1:b
    Y = fftshift(fft(data(:,i)));
    Y(abs(Y) < tol) = 0;
    theta_y = angle(Y(idx));
    
    phase_lag = theta_y - theta_x;
%     phase_lag = mod((theta_y - theta_x),2*pi);
    difference(i) = rad2deg(phase_lag);
    
    x2 = hilbert(data(:,i));
    difference_hil(i) = rad2deg(angle(sum(x1.*conj(x2))));
    
end     
end

