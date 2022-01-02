close all;
clear all;
N = 1e3;
fs = 44100;
fc = 5e2;
nsig = 1;
vsound = 340.3;
lambda = vsound/fc;

% coortrans = [-1e3 -1e3*1.5]; 


micnumber = 8;%number of mics
coorfirstmic = [0 0];
d = lambda/2;%distance between mics
% d = 2.5e-2;

coortrans = [3e0 3+d*micnumber/2];

%%%%%%%%
figure(1)
[bufor, theta1] = make_bufor(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc);
%makes simulation of samples that mic array collects 

%%
% figure()
X = bufor(:,100); %takes sampling from one period of time
S = (X*X');
% plot(X')
[Veig,Deig] = eig(S);

Q_N = Veig(:,1:end-nsig);

theta = (-pi/2):pi/180:(pi/2);
Beta = zeros(micnumber,length(theta));
for i = 1:micnumber
    Beta(i,:) = exp(-1i*2*pi*d*(i-1)*sin(theta)/lambda);
end

P_music_temp = zeros(length(Beta),1);
for i = 1:length(Beta)
    P_music_temp(i) = 1/norm((Beta(:,i)'*Q_N).^2);
end

% figure(1000)
% plot(theta,P_music_temp)

figure(123)
plot((theta*180/pi),10*log10(P_music_temp))
hold all;
grid on;
title('d = lambda/2')
legend('rzeczywisty sygnał')
ylabel('poziom mocy [dB]');
xlabel('kąt padania fali');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d = 2.5 cm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


micnumber = 8;%number of mics
coorfirstmic = [0 0];
% d = lambda/2;%distance between mics
d = 2.5e-2;

coortrans = [3e0 3+d*micnumber/2];

%%%%%%%%
figure(2)
[bufor, theta1] = make_bufor(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc);

%%%%
%makes simulation of samples that mic array collects 
% figure()
X = bufor(:,100); %takes sampling from one period of time
S = (X*X');
% plot(X')
[Veig,Deig] = eig(S);

Q_N = Veig(:,1:end-nsig);

theta = (-pi/2):pi/180:(pi/2);
Beta = zeros(micnumber,length(theta));
for i = 1:micnumber
    Beta(i,:) = exp(-1i*2*pi*d*(i-1)*sin(theta)/lambda);
end

P_music_temp = zeros(length(Beta),1);
for i = 1:length(Beta)
    P_music_temp(i) = 1/norm((Beta(:,i)'*Q_N).^2);
end

% figure(1000)
% plot(theta,P_music_temp)

figure(124)
plot((theta*180/pi),10*log10(P_music_temp))
hold all;
grid on;
title('d = 2.5 cm')
legend('rzeczywisty sygnał')
ylabel('poziom mocy [dB]');
xlabel('kąt padania fali');

%%