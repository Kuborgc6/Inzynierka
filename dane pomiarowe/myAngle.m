function [phi] = myAngle(coortrans,coormicarray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[mic1, ~] = size(coormicarray);

if mod(mic1,2) == 1 % wybiera lokalizacje srodka szyku
    coormic = coormicarray(ceil(mic1/2),:);
else
    coormic = (coormicarray(floor(mic1/2),:)+coormicarray(floor(mic1/2)+1,:))/2;
end

a1 = (coortrans(2)-coormic(2))/(coortrans(1)-coormic(1));

if (coormicarray(1,1)-coormicarray(end,1)) == 0
    phi = atan(a1);
elseif  (coormicarray(2,1)-coormicarray(2,end)) == 0
    phi = pi/2 - atan(a1);
else
    a2 = (coormicarray(1,2)-coormicarray(end,2))/(coormicarray(1,1)-coormicarray(end,1));
    tgphi = abs((a1 - a2)/(1+a1*a2));%abs
    phi = abs(pi/2 - atan(tgphi));
end

if ((coortrans(2)<coormic(1,2))&&(coortrans(1)>coormic(1,1)))||...
     (coortrans(2)>coormic(1,2))&&(coortrans(1)>coormic(1,1))
    phi = -phi;
end

end

