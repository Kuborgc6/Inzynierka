function [data_clean_loop] = clean_data_loop(data_loop, f_bandpass, fs)
[a1, a2, a3] = size(data_loop);
data = zeros(a2,a3);
data_loop_temp = zeros(a1,a2,a3);
for i = 1:a1
data(:,:) = data_loop(i,:,:);
data_loop_temp(i,:,:) = clean_all(data, f_bandpass, fs);
end
data_clean_loop = data_loop_temp;
end

