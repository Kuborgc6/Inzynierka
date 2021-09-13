function [difference_loop, difference_hil_loop] = loop_phase_difference(data_loop)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[M, samples, micnumber] = size(data_loop);
difference_loop = zeros(M,micnumber);
difference_hil_loop = zeros(M,micnumber);
data = zeros(samples, micnumber);

for i = 1:M
data(:,:) = data_loop(i,:,:);
[difference,difference_hil] = difference_phase_v2(data);
difference_loop(i,:) = difference;
difference_hil_loop(i,:) = difference_hil;
end

end

