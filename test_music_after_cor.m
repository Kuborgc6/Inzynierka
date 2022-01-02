clear all
close all

load('data_00_test_after_cor.mat')
% load('data_30_test_after_cor.mat')

%%

fc = 500;
fs = 44100;
d = 2*1e-2;
vsound = 340.3;
number = 3050; % arbitralna wartość
nsig = 1; %liczba sygnałów
lambda = vsound/fc;
h = 1001; %nr wykresu
data(:,:) = data_result_loop(26,:,1:6);

%%

for i = 1:fs
    data(:,:) = data_result_loop(26,:,1:6);
    my_music(data',i, nsig,d,lambda, h);
end

% pmusic
%%

[PP, ff] = pmusic(data(1:300,:), 2,[],fs);
figure(11);
plot(ff,20*log10(abs(PP)))
xlabel 'Frequency (Hz)', ylabel 'Power (dB)'
title 'Pseudospectrum Estimate via MUSIC', grid on

