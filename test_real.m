clear all;
close all;

%%
load handel;

d = daq('directsound');
dev = daqlist; % provide list of inputs and outputs in device
audio_input = "Audio1";
ch1 = addinput(d,audio_input,"1","Audio");
ch2 = addinput(d,audio_input,"2","Audio");
ch3 = addinput(d,audio_input,"3","Audio");
ch4 = addinput(d,audio_input,"4","Audio");
ch5 = addinput(d,audio_input,"5","Audio");
ch6 = addinput(d,audio_input,"6","Audio");
ch7 = addinput(d,audio_input,"7","Audio");
ch8 = addinput(d,audio_input,"8","Audio");

d.Channels;

[data,t] = read(d, seconds(0.01), "OutputFormat","Matrix");

%%
% file_load = "12370_srodek_faza.mat";

% load(file_load);
% fc = 12370;
% fc = 7560;
fc = 0;
micnumber = 7;

data(:,6) = [];

bufor = zeros(size(data));
for i = 1:micnumber
   bufor(:,i) = data(:,i)/max(data(:,i));
end

delta_psi = zeros(size(data));

for i=1:micnumber
    delta_psi(:,i) = (hilbert(data(:,i),length(data(:,i))));
end

result = delta_psi';
figure(2)
% X = 20*log10(abs(fftshift(fft(result(:,1000),1000))));
X = 20*log10(abs(fftshift(fft(result(:,1),1000))));
deltaf = 1/length(X);
f = (-0.5*pi/2 : deltaf*pi/2 : (0.5-deltaf)*pi/2);
plot(f,X,'-')


vsound = 340.3;
number = 300; % arbitralna wartość
nsig = 1; %liczba sygnałów
% d = 1.71*1e-2; %odleglosc miedzy mikrofonowami
d = 21*1e-2;
lambda = vsound/fc;
h = 1000; %nr wykresu
my_music(data',number, nsig,d,lambda,h);

h10 = multi_audio_plot(30, data);
h = multi_channel_plotspect(40, data, 44100);

%% Czyszczenie sygnału

f_bandpass = [fc-1e3 fc+1e3];
fs = 44100;

data_clean = clean_all(data, f_bandpass, fs);

h10prim = multi_audio_plot(31, data_clean);
hprim = multi_channel_plotspect(41, data_clean, 44100);

%%
% load(file_load);


bufor = zeros(size(data_clean));
for i = 1:micnumber
   bufor(:,i) = data_clean(:,i)/max(data_clean(:,i));
end

delta_psi = zeros(size(data_clean));

for i=1:micnumber
    delta_psi(:,i) = (hilbert(data_clean(:,i),length(data_clean(:,i))));
end

result = delta_psi';
figure(3)
% X = 20*log10(abs(fftshift(fft(result(:,1000),1000))));
X = 20*log10(abs(fftshift(fft(result(:,1),1000))));
deltaf = 1/length(X);
f = (-0.5*pi/2 : deltaf*pi/2 : (0.5-deltaf)*pi/2);
plot(f,X,'-')

vsound = 340.3;
number = 300; % arbitralna wartość
nsig = 1; %liczba sygnałów
lambda = vsound/fc;
h = 1001; %nr wykresu
my_music(data_clean',number, nsig,d,lambda, h);

% theta1 = myAngle(coortrans,coormic);
% delta_psi1 = 2*pi*fc*coormic(:,2).*sin(theta1)/vsound;%
% result1 = exp(1j*(delta_psi1));
% % figure()
% X = 20*log10(abs(fftshift(fft(result1, 1000))));
% deltaf = 1/length(X);
% f = (-0.5*pi/2 : deltaf*pi/2 : (0.5-deltaf)*pi/2);
% plot(f,X,'--')
% hold off