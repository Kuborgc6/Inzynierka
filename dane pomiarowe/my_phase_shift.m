function [data_result] = my_phase_shift(data,difference_median)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[N,micnumber] = size(data);
data_result = zeros(N,micnumber);
data_result(:,1) = data(:,1);

for i = 1:micnumber
    X = (fft(data(:,i)'));
    Y = zeros(size(X));
    Y(ceil(N/2):end) = X(ceil(N/2):end).*exp(-1i*deg2rad(difference_median(i)));
    Y(1:(ceil(N/2)-1)) = X(1:(ceil(N/2)-1)).*exp(1i*deg2rad(difference_median(i)));
    data_result(:,i) = real(ifft((Y')));
end

end

