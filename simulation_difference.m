close all;
clear all;
N = 1e3;
fs = 1e4;
fc = 5e2;
nsig = 1;
vsound = 340.3;
lambda = vsound/fc;
M = 40;


micnumber = 8;%number of mics
coorfirstmic = [0 0];
d = 0.025;% lambda/2;%distance between mics


coortrans = [-1 d*3.5];%[-1e3 -1e3*1.5]; 
data_loop = zeros(M,N,micnumber);
%%%%%%%%
for i = 1:M
[bufor, theta1] = make_bufor_noise(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc);
data_loop(i,:,:) = bufor(:,:);
end 
%%%%%%%%

[difference_loop,difference_loop_hil] = loop_phase_difference(data_loop);

figure(201)
plot(difference_loop)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")
ylim([-90 90])

figure(301)
plot(difference_loop_hil)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")
ylim([-90 90])


