clear;
close all;

%% Ustalanie zbierania danych z mikrofonów

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

%% data collection

time = 1; %seconds of collection 
M = 20; %how many iteration
micnumber = 8;%number of mics
fs = 44100;
data_loop = zeros(M, time*fs, micnumber);

for i = 1:M
[data,t] = read(device, seconds(time), "OutputFormat","Matrix");
data_loop(i,:,:) = data;
end