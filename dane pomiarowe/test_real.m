clear;
close all;

%% Załadowanie danych

% load('9452_test_00_after.mat')
% load('9452_test_30_after.mat')

% load('9452_test_00_after_2.mat')
load('9452_test_30_after_2.mat')

fc = 9452; %500 2000 7000
fs = 44100;
f_bandpass = [fc-3e2 fc+3e2];

[number_test, N, micnumber] = size(data_result_loop);

%% Wyświetlenie danych
[difference_result_loop, difference_result_loop_hil] = loop_phase_difference(data_result_loop);

figure(51)
data_result(:,:) = data_result_loop(38,:,:);
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
%% Liczenie Music

number = 100;
data(:,:) = data_result_loop(13,:,:);
nsig = 1;
d = 1.8e-2;
vsound = 340.3;
lambda = vsound/fc;

[theta,P_music_temp] = my_music(data',number, nsig,d,lambda);

figure(11)
plot((theta*180/pi),10*log10(P_music_temp))
grid on;
% legend('rzeczywisty sygnał')
ylabel('poziom mocy [dB]');
xlabel('kąt padania fali');
