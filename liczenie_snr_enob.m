clear;
close all;

%% Tworzenie danych teoretycznych
% d = 11/8*1e-2;
d_teor = 21*1e-2;
lambda_teor = d_teor*2;
vsound = 340.3;
fc_teor = vsound/lambda_teor;
D_zrodlo = 3;
fc = 810;

D_zrodlo_prawa = 0.3;

N = 1e3;
fs = 44100;
nsig = 1;
lambda = vsound/fc;

d = lambda/2;

coortrans = [2.5 d*2.5]; %-D_zrodlo_prawa

micnumber = 8;%number of mics
coorfirstmic = [0 0];

%% Pobieranie danych

load handel;

device = daq('directsound');
dev = daqlist; % provide list of inputs and outputs in device
audio_input = "Audio1";
ch1 = addinput(device,audio_input,"1","Audio");
ch2 = addinput(device,audio_input,"2","Audio");
ch3 = addinput(device,audio_input,"3","Audio");
ch4 = addinput(device,audio_input,"4","Audio");
ch5 = addinput(device,audio_input,"5","Audio");
ch6 = addinput(device,audio_input,"6","Audio");
ch7 = addinput(device,audio_input,"7","Audio");
ch8 = addinput(device,audio_input,"8","Audio");

device.Channels;

%% Dane rzeczywiste
[data,t] = read(device, seconds(1), "OutputFormat","Matrix");

data = clean_all(data, [3e2 5e2], 44100);% konieczne bo mikrofony mają zakres do 10kHz

h10prim = multi_audio_plot(31, data);
hprim = multi_channel_plotspect(41, data, 44100);

%% Liczenie SNR i ENOB
for i = 1:micnumber
    SNR_channel_cabel_7000(i) = snr(data_cabel_7000(:,i));
    ENOB_cabel_7000(i) = (sinad(data_cabel_7000(:,i))-1.76)/6.02;
    
    SNR_channel_cabel_wnoise(i) = snr(data_cabel_wnoise(:,i));
    ENOB_cabel_wnoise(i) = (sinad(data_cabel_wnoise(:,i))-1.76)/6.02;
    
    SNR_channel_mic_7000(i) = snr(data_mic_7000(:,i));
    ENOB_mic_7000(i) = (sinad(data_mic_7000(:,i))-1.76)/6.02;
    
    SNR_channel_mic_wnoise(i) = snr(data_mic_wnoise(:,i));
    ENOB_mic_wnoise(i) = (sinad(data_mic_wnoise(:,i))-1.76)/6.02;
end

for i = 1:micnumber
    SNR_channel_mic_3_4_to_7_8_sin7000(i) = snr(data_mic_3_4_to_7_8_sin7000(:,i));
    ENOB_mic_3_4_to_7_8_sin7000(i) = (sinad(data_mic_3_4_to_7_8_sin7000(:,i))-1.76)/6.02;
    
    SNR_channel_mic_3_4_to_7_8_wnoise(i) = snr(data_mic_3_4_to_7_8_wnoise(:,i));
    ENOB_mic_3_4_to_7_8_wnoise(i) = (sinad(data_mic_3_4_to_7_8_wnoise(:,i))-1.76)/6.02;
end

%% Liczenie korelacji między każdym z mikrofonów
N = 300;
h = 10;
M = 20;
micnumber = 8;%number of mics


[result_c, max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h*10);

h10prim = multi_audio_plot(31, data);
hprim = multi_channel_plotspect(41, data, 44100);

% 
x = data(:,1);
soundsc(x,44100)


[result_c_loop,max_cor_mag_loop, max_cor_sample_loop, correlation_channel_1] = loop_correlation(micnumber, N, h, M, device);

%% phase difference
M = 20;
micnumber = 8;%number of mics


[difference_loop] = loop_phase_difference(micnumber, M, device);



%% debugging phase difference

data = data_mic_3_4_to_7_8_sin7000;
fs = 44100;

[difference] = difference_phase_v2(data);

hprim = multi_channel_plotspect(41, data, 44100);

w = blackman(44100);

xh = data(:,1).*hamming(length(data(:,1)));
xb = data(:,1).*blackman(length(data(:,1)));


h = plotspect(12, data(:,1), fs);
hold on
h = plotspect(12, xh, fs);
h = plotspect(12, xb, fs);
hold off

% X=fft(data(:,1));
X=fft(x);
theta_x = angle(fftshift(X));
f = (-fs/2:fs/2-1);

figure(400)
plot(f,abs(fftshift(X)));
xlabel 'Frequency (Hz)'
ylabel '|y|'
grid

figure(401)
plot(f,theta_x/pi)
xlabel 'Frequency (Hz)'
ylabel 'Phase / \pi'
grid
%%
figure(1)
plot(data(1:1000,:))

