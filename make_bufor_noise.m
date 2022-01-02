function [bufor_out, theta1, sampledelay] = make_bufor_noise(micnumber,coorfirstmic,coortrans,d,N,vsound,fs,fc)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n = 1:N;
coormic = zeros(micnumber,2);
coormic(1:end,1) = coorfirstmic(1);
coormic(1,2) = coorfirstmic(2);
for i = 1:micnumber
    coormic(2:end,2) = coormic(1:end-1,2)+d;
end


plot(coormic(:,1),coormic(:,2),'xr');
hold on
plot(coortrans(:,1),coortrans(:,2),'ob');
hold off
theta1 = myAngle(coortrans,coormic);
fprintf("The angle is: %f\n", (theta1*180/pi))

distance(1:micnumber) = sqrt((coortrans(1,1)-coormic(1:end,1)).^2+(coortrans(1,2)-coormic(1:end,2)).^2);
bufor = zeros(micnumber,N);
timedelay = distance/vsound;
sampledelay = timedelay*fs;

for i = 1:micnumber
    bufor(i,:) = sin(2*pi*fc*n/fs + 2*pi*fc*timedelay(i))+rand;
end
bufor_out = bufor';
end

