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

micnumber = 6;%number of mics
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

data = clean_all(data, [0, 10e3], 44100);% konieczne bo mikrofony mają zakres do 10kHz

%% Liczenie SNR i ENOB
for i = 1:micnumber
    SNR_channel(i) = snr(data(:,i));
    ENOB(i) = (10*log10(SNR_channel(i))-1.76)/6.02;
end

%% Liczenie korelacji między każdym z mikrofonów



correlation_all = [micnumber,micnumber];

for i = 1: micnumber
    
end