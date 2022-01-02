function [data_result_loop] = loop_phase_shift(data_loop,difference_median)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[number_test, N, micnumber] = size(data_loop);
data_result_loop = zeros(number_test, N, micnumber);
data = zeros(N, micnumber);

for i = 1:number_test
    data(:,:) = data_loop(i,:,:);
    [data_result] = my_phase_shift(data,difference_median);
    data_result_loop(i,:,:) = data_result(:,:);
end
end

