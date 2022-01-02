clear
close all;
%% ładowanie danych

load("data_tests\data_loop_500Hz_pomiar_1.mat","data_loop_temp");
data_loop_1 = data_loop_temp;
load("data_tests\data_loop_500Hz_pomiar_2.mat","data_loop_temp");
data_loop_2 = data_loop_temp;
load("data_tests\data_loop_500Hz_pomiar_3.mat","data_loop_temp");
data_loop_3 = data_loop_temp;
load("data_tests\data_loop_500Hz_pomiar_4.mat","data_loop_temp");
data_loop_4 = data_loop_temp;
load("data_tests\data_loop_500Hz_pomiar_5.mat","data_loop_temp");
data_loop_5 = data_loop_temp;
load("data_tests\data_loop_500Hz_pomiar_6.mat","data_loop_temp");
data_loop_6 = data_loop_temp;

data_loop = data_loop_temp;

%% praca na pobranych danych

[number_tests, N, micnumber] = size(data_loop);

difference_loop = zeros(6,number_tests, micnumber);
difference_loop_hil = zeros(6,number_tests, micnumber);
difference_loop_temp = zeros(number_tests, micnumber);
difference_loop_hil_temp = zeros(number_tests, micnumber);

[difference_loop(1,:,:), difference_loop_hil(1,:,:)] = loop_phase_difference(data_loop_1);
[difference_loop(2,:,:), difference_loop_hil(2,:,:)] = loop_phase_difference(data_loop_2);
[difference_loop(3,:,:), difference_loop_hil(3,:,:)] = loop_phase_difference(data_loop_3);
[difference_loop(4,:,:), difference_loop_hil(4,:,:)] = loop_phase_difference(data_loop_4);
[difference_loop(5,:,:), difference_loop_hil(5,:,:)] = loop_phase_difference(data_loop_5);
[difference_loop(6,:,:), difference_loop_hil(6,:,:)] = loop_phase_difference(data_loop_6);


for i = 1:6
figure(10+1)
subplot(2,3,i)
difference_loop_temp(:,:) = difference_loop(i,:,:);
plot(difference_loop_temp)
title_figure = "test " + int2str(i);
title(title_figure)

figure(10+2)
subplot(2,3,i)
difference_loop_hil_temp(:,:) = difference_loop_hil(i,:,:);
plot(difference_loop_hil_temp)
title_figure = "test " + int2str(i);
title(title_figure)
end
figure(10+1)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")
figure(10+2)
legend("Channel 1","Channel 2","Channel 3","Channel 4","Channel 5","Channel 6","Channel 7","Channel 8")

% n = 1:length(difference_loop_1(:,3));
% figure(3)
% plot(n,difference_loop_1(:,3),n,difference_loop_2(:,3),n,difference_loop_3(:,3),n,difference_loop_4(:,3),n,difference_loop_5(:,3),n,difference_loop_6(:,3))

figure(100)
for i = 1: micnumber
n = 1:length(difference_loop(1,:,i));
subplot(2,ceil(micnumber/2),i)
title_figure = "kanał " + int2str(i);
plot(n,difference_loop(1,:,i),n,difference_loop(2,:,i),n,difference_loop(3,:,i),n,difference_loop(4,:,i),n,difference_loop(5,:,i),n,difference_loop(6,:,i))
title(title_figure)
ylim([-90 90])
end
legend("Pomiar 1","Pomiar 2","Pomiar 3","Pomiar 4","Pomiar 5","Pomiar 6")

%% odchylenie standardowe
standard_devation = zeros(1, micnumber);
len_difference_loop= length(difference_loop(1,:,i));
temp = zeros(1, micnumber*len_difference_loop);
for i = 1:micnumber
    for j = 1 : 6
        temp((1+len_difference_loop*(j-1)) : (len_difference_loop*j)) = difference_loop(j,:,i);
    end
    standard_devation(i) = std(temp);
end
