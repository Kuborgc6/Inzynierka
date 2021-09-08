function [result_c_loop,max_cor_mag_loop, max_cor_sample_loop, correlation_channel_1] = loop_correlation(data_loop, N, h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[M, samples, micnumber] = size(data_loop);
result_c_loop = zeros(M,micnumber,micnumber,N*2+1);
max_cor_mag_loop = zeros(M,micnumber,micnumber);
max_cor_sample_loop = zeros(M,micnumber,micnumber);
data = zeros(samples, micnumber);

for i = 1:M
data(:,:) = data_loop(i,:,:);
data = clean_all(data, [3e2 44100], 44100);
[result_c, max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h);
result_c_loop(i,:,:,:) = result_c;
max_cor_mag_loop(i,:,:) = max_cor_mag;
max_cor_sample_loop(i,:,:) = max_cor_sample;
end

temp = max_cor_sample_loop(:,1,:);
correlation_channel_1 = zeros(M,micnumber);
correlation_channel_1(:,:) = temp(:,1,:);


end

