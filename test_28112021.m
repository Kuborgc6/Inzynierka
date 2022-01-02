clear
close all;

% load('test_real_data.mat')
% data = test_real_data;

%%

% load('data_00_wzorzec.mat')
% load('data_00_test.mat')
load('2900_test_00_10.mat')


fc = 2900; %2000 7000
fs = 44100;
f_bandpass = [fc-3e2 fc+3e2];

data_loop = clean_data_loop(data_loop, f_bandpass, fs);
[number_test, N, micnumber] = size(data_loop);


%%

[difference_loop, difference_loop_hil] = loop_phase_difference(data_loop);

difference_median = median(difference_loop);
difference_median_hil = median(difference_loop_hil);

%%
figure(1)
data(:,:) = data_loop(26,:,:);
plot(data(1:1000,:))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")

figure(2)
plot(difference_loop(:,1:6))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
ylim([-180 180])

figure(3)
plot(difference_loop_hil(:,1:6))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
ylim([-180 180])

%%
standard_devation = zeros(1,micnumber);
for i = 1:micnumber
    standard_devation(i) = std(difference_loop(:,i));
end

%%

[data_result] = my_phase_shift(data,difference_median);
difference_median
[difference_result, difference_hil_result] = difference_phase_v2(data_result)
% [difference_result_2, difference_hil_result_2] = difference_phase_v2(data_result_2)

%%

[data_result_loop] = loop_phase_shift(data_loop,difference_median_hil);
[difference_result_loop, difference_result_loop_hil] = loop_phase_difference(data_result_loop);

difference_result_median = median(difference_result_loop);
difference_result_median_hil = median(difference_result_loop_hil);

figure(51)
data_result(:,:) = data_result_loop(26,:,:);
plot(data_result(1:1000,:))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")

figure(52)
plot(difference_result_loop(:,1:6))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
ylim([-180 180])

figure(53)
plot(difference_result_loop_hil(:,1:6))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
ylim([-180 180])

%%
[N, micnumber] = size(data(:,1:6));
data_temp = zeros(N, micnumber);
data_temp(:,:) = data(:,1:6);
fc = 500;
vsound = 340.3;
lambda = fc/vsound;
% for i = 1:N
    my_music(data_temp',300,1,2,lambda,1000);
% end