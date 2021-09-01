function [outputArg1,outputArg2] = multi_channel_correlation(inputArg1,inputArg2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;

figure(h)
subplot(ceil(b/2),2,i)
x = data(:,Mic1);
y = data(:,Mic2);
[c,lags] = xcorr(x,y,300);
figure(1)
stem(lags,c)



end

