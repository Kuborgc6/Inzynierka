clear;
close all;

%%
name_file = "data_tests\data_loop_500Hz.mat";
load(name_file);

[a1, a2, a3] = size(data_loop);
data = zeros(a2,a3);

fs = 44100;
f_bandpass = [3e2 7e2];

data_loop = clean_data_loop(data_loop, f_bandpass, fs);

data(:,:) = data_loop(3,:,:);
h10prim = multi_audio_plot(31, data);
hprim = multi_channel_plotspect(41, data, 44100);


%
N = 300;
h = 100;
% [result_c, max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h*10);
% [result_c_loop,max_cor_mag_loop, max_cor_sample_loop, correlation_channel_1] = loop_correlation(data_loop, N, h);
[difference_loop, difference_loop_hil] = loop_phase_difference(data_loop);

%%
figure(1)
data(:,:) = data_loop(4,:,:);

plot(data(1:1000,:))

figure(2)
plot(difference_loop)
figure(3)
plot(difference_loop_hil)


%%
fc = 500;
fs = 44100;
M = 20;
N = 2000;
micnumber = 8;
step = 5;

[bufor_loop] = make_loop_bufor(M,N,fs,fc,micnumber,step);
bufor = zeros(N,micnumber);

bufor(:,:) = bufor_loop(3,:,:);
figure(10)
plot(bufor(1:1000,:))

figure(11)
for i = 1:5
    bufor(:,:) = bufor_loop(i,:,:);
    plot((bufor(1:1000,1)))
    hold on
end
hold off
legend("1","2","3","4","5")%,"6","7","8","9","10","11","12","13","14","15","16","17","18","19","20");

[difference_loop_test, difference_loop_hil_test] = loop_phase_difference(bufor_loop);
figure(20)
plot(difference_loop_test)
figure(21)
plot(difference_loop_hil_test)




