function [theta,P_music_temp] = my_music(data,number, nsig,d,lambda)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[micnumber, a] = size(data);
X = data(:,number); %takes sampling from one period of time
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

% figure(h)
% plot((theta*180/pi),P_music_temp)
end

