clear all;
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
%%%%%%%%

figure(5)
[bufor, theta1, sampledelay] = make_bufor(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc);
% h = multi_audio_plot(5, bufor');

sampledelay_to_first = zeros(1,micnumber);

for i = 1:micnumber
    sampledelay_to_first(i) = sampledelay(i) - sampledelay(1);
end

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

%% Liczenie kroskorelacji

Mic1 = 2;
Mic2 = 5;

x = data(:,Mic1);
y = data(:,Mic2);
[c,lags] = xcorr(x,y,300);
figure(1)
stem(lags,c)

%% liczenie w pętli

temp = data;
bufor = zeros(size(data));
for i = 1:micnumber
   bufor(:,i) = data(:,i)/max(data(:,i));
end
data = bufor;

N = 20;
micnumber = 8;

result_c = zeros(N,micnumber,length(c));
result_lags = zeros(N,micnumber,length(lags));
max_cor_mag = zeros(N,micnumber);
max_cor_sample = zeros(N,micnumber);
for i = 1:N
    [data,t] = read(device, seconds(1), "OutputFormat","Matrix");
%     data = clean_all(data, [0, 10e3], 44100);% konieczne bo mikrofony mają zakres do 10kHz
    for j = 2:micnumber
        x = data(:,Mic1);
        y = data(:,j);
        [c,lags] = xcorr(x,y,300);
        [max_cor_mag(i,j), temp] = max(c);
        max_cor_sample(i,j) = 44100 - temp;
        result_c(i,j,:) = c;
    end
end
% 
% for i = 1:N
    for j = 2:micnumber
        figure(10*i+j)
        title_str = append("Dla pomiaru ",string(i)," sygnal 1 i ", string(j));
        temp_c = zeros(1,length(result_c(i,j,:)));
        temp_c(1,:) = result_c(i,j,:);
        stem(lags,temp_c);
        title(title_str);
    end
% end
%     
for i = 1:micnumber
mean_value(i) = mean(max_cor_sample(:,i));
median_value(i) = median(max_cor_sample(:,i));
end

%% Debugging

[data,t] = read(device, seconds(3), "OutputFormat","Matrix");
% data = clean_all(data, [0, 10e3], 44100);% konieczne bo mikrofony mają zakres do 10kHz

h10prim = multi_audio_plot(31, data);
hprim = multi_channel_plotspect(41, data, 44100);
% 
x = data(:,1);
soundsc(x,44100)
% 
% micnumber = 8;
% for i = 1:micnumber
%     y_highpass(:,i) = highpass(data(:,i),80,44100);
% end
% 
% h10prim = multi_audio_plot(32, y_highpass);
% x = y_highpass(:,3);
% 
% Mic1 = 1;
% Mic2 = 3;
% 
% x = y_highpass(:,Mic1);
% y = y_highpass(:,Mic2);
% [c,lags] = xcorr(x,y);
% figure(2)
% stem(lags,c)
