clear all;
close all;

%% Tworzenie danych teoretycznych
% d = 11/8*1e-2;
d_teor = 16*1e-2;
lambda_teor = d_teor*2;
vsound = 340.3;
fc_teor = vsound/lambda_teor;
D_zrodlo = 3;
fc = 7000;

D_zrodlo_prawa = 0.3;

N = 1e3;
fs = 44100;
nsig = 1;
lambda = vsound/fc;

d = lambda/2;
d = 34*1e-2;

coortrans = [2.5 d*3.5]; %-D_zrodlo_prawa

micnumber = 8;%number of mics
coorfirstmic = [0 0];
%%%%%%%%

[bufor, theta1, sampledelay] = make_bufor(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc);
% h = multi_audio_plot(5, bufor');


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
[data,t] = read(device, seconds(5), "OutputFormat","Matrix");

% file_load = "12370_srodek_faza.mat";
% load(file_load);

f_bandpass = [fc-1e3 fc+1e3];

fs = 44100;

data_clean = clean_all(data, f_bandpass, fs);

hprim = multi_channel_plotspect(41, data_clean, 44100);
h10prim = multi_audio_plot(31, data_clean);


%% Liczenie róznicy w fazie

N1 = 20;
N2 = N1+floor(fs/fc);
bufor_test = bufor(:,N1:N2);
phase_teor_test = difference_phase(bufor_test');
phase_teor = difference_phase(bufor');
data_test = data(N1:N2,:)./max(data(N1:N2,:));
data_clean_test = data_clean(N1:N2,:)./max(data_clean(N1:N2,:));
% h12 = multi_audio_plot(32, data_clean_test);
phase_prac = difference_phase(data_test);
phase_prac_clean_test = difference_phase(data_clean_test);
phase_prac_clean = difference_phase(data_clean);
