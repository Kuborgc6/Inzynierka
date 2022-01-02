clear
close all

% load('9452_wzorzec_00_2.mat')
% load('9452_test_00_2.mat')
load('9452_test_30_2.mat')
load('9452_phase_correction_2.mat')

fc = 9452; %500 2000 7000
fs = 44100;
f_bandpass = [fc-3e2 fc+3e2];

data_loop = clean_data_loop(data_loop, f_bandpass, fs);
[number_test, N, micnumber] = size(data_loop);

%%

[difference_loop, difference_loop_hil] = loop_phase_difference(data_loop);
difference_median = median(difference_loop);
difference_median_hil = median(difference_loop_hil);

figure(1)
data(:,:) = data_loop(26,:,:);
plot(data(1:1000,:))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")

figure(2)
plot(difference_loop(:,1:6))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
ylim([-180 180])

figure(3)
plot(difference_loop_hil(:,1:6))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
ylim([-180 180])

%%

[data_result_loop] = loop_phase_shift(data_loop,difference_median);
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

