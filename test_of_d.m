clear;
close all; 
%%
parts = 25;
a = 5;
b = ceil(parts/a);
fc1 = 0.5e3;
fc2 = 12e3;
fc = linspace(fc1,fc2,parts);
title_name = string(fc);
M = 40;

N = 1e3;
fs = 44100;
nsig = 1;
vsound = 340.3;
lambda = vsound./fc;

micnumber = 6;%number of mics
coorfirstmic = [0 0];

% d_lin = linspace(1.8e-2, lambda/2, 8);
% for i = 1:length(d_lin)
% d = d_lin(i);
d = 4e-2;
coortrans = [3.6e0+d 3+d*micnumber/2];

bufor_loop = zeros(parts,M,N,micnumber);
difference_loop_parts = zeros(parts,M,micnumber);
difference_hil_loop_parts = zeros(parts,M,micnumber);
temp_bufor_loop = zeros(M,N,micnumber);

%%%%%%%%
for i = 1:length(fc)
    for j = 1:M
        figure(1)
        [bufor, theta1] = make_bufor_noise(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc(i));
        bufor_loop(i,j,:,:) = bufor;
        %makes simulation of samples that mic array collects 
        close 1;
    end
    number = 100;
    nsig = 1;
    
    [theta,P_music_temp] = my_music(bufor',number, nsig,d,lambda(i));

    figure(11)
    subplot(a,b,i);
    plot((theta*180/pi),10*log10(P_music_temp))
    hold on;
    grid on;
    title("fc = ", title_name(i));
    % legend('rzeczywisty sygnał')
    ylabel('poziom mocy [dB]');
    xlabel('kąt padania fali');
    hold off
    
    temp_bufor_loop(:,:,:) = bufor_loop(i,:,:,:);
    [difference_result_loop, difference_result_loop_hil] = loop_phase_difference(temp_bufor_loop);
    difference_loop_parts(i,:,:) = difference_result_loop;
    difference_hil_loop_parts(i,:,:) = difference_result_loop_hil;
    
    figure(51)
    subplot(a,b,i);
    bufor_result(:,:) = temp_bufor_loop(38,:,:);
    plot(bufor_result)
    title("fc = ", title_name(i));
%     legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")

    figure(52)
    subplot(a,b,i);
    plot(difference_result_loop(:,1:6))
%     legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
    ylim([-180 180])
    title("fc = ", title_name(i));


    figure(53)
    subplot(a,b,i);
    plot(difference_result_loop_hil(:,1:6))
%     legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")%)%
    ylim([-180 180])
    title("fc = ", title_name(i));
end

figure(51)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")
figure(52)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")
figure(53)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6")%,"Channel 7","Channel 8")