function [result_c_loop,max_cor_mag_loop, max_cor_sample_loop] = loop_correlation(micnumber, N, h, M, device)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

result_c_loop = zeros(M,micnumber,micnumber,N*2+1);
max_cor_mag_loop = zeros(M,micnumber,micnumber);
max_cor_sample_loop = zeros(M,micnumber,micnumber);

for i = 1:M
[data,t] = read(device, seconds(1), "OutputFormat","Matrix");
[result_c, max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h);
result_c_loop(i,:,:,:) = result_c;
max_cor_mag_loop(i,:,:) = max_cor_mag;
max_cor_sample_loop(i,:,:) = max_cor_sample;
end

end

