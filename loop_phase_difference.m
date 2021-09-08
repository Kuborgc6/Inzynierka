function [difference_loop] = loop_phase_difference(data_loop)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[M, samples, micnumber] = size(data_loop);
difference_loop = zeros(M,micnumber);
data = zeros(samples, micnumber);

for i = 1:M
data(:,:) = data_loop(i,:,:);
data = clean_all(data, [3e2 44100], 44100);
[difference] = difference_phase_v2(data);
difference_loop(i,:) = difference;
end

end

