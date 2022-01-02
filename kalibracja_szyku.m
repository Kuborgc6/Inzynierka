clear
close all

%% Ustalanie zbierania danych z mikrofonów

load handel;

device = daq('directsound');
dev = daqlist; % provide list of inputs and outputs in device
audio_input = "Audio1"; %Audio1
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
close all

time = 1; %seconds of collection 
M = 15; %how many iteration
micnumber = 8;%number of mics
fs = 44100;
data_loop = zeros(M, time*fs, micnumber);

for i = 1:M
[data,t] = read(device, seconds(time), "OutputFormat","Matrix");
data_loop(i,:,:) = data;
end


%%%%%%%%%%%%

fc = 500; %2000 7000

[a1, a2, a3] = size(data_loop);
data = zeros(a2,a3);

fs = 44100;
f_bandpass = [fc-3e2 fc+3e2];

data_loop = clean_data_loop(data_loop, f_bandpass, fs);

% data(:,:) = data_loop(3,:,:);
% h10prim = multi_audio_plot(31, data);
% hprim = multi_channel_plotspect(41, data, 44100);


%
N = 300;
h = 100;
% [result_c, max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h*10);
% [result_c_loop,max_cor_mag_loop, max_cor_sample_loop, correlation_channel_1] = loop_correlation(data_loop, N, h);
[difference_loop, difference_loop_hil] = loop_phase_difference(data_loop);

% %%
figure(1)
data(:,:) = data_loop(4,:,:);
plot(data(1:1000,:))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")

figure(2)
plot(difference_loop(:,1:8))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")%)%
ylim([-180 180])

figure(3)
plot(difference_loop_hil(:,1:8))
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")%)%
ylim([-180 180])

%%
standard_devation = zeros(1,micnumber);
for i = 1:micnumber
    standard_devation(i) = std(difference_loop(:,i));
end



