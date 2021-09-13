function [bufor_loop] = make_loop_bufor(M,N,fs,fc,micnumber, step)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n = 1:N;
bufor_loop = zeros(M,N,micnumber);

a = -pi;
b = pi;
phase_shift = (b-a).*rand(M,1) + a;

for i = 1:M
    for j = 1:micnumber
        bufor_loop(i,:,j) = sin(2*pi*fc*n/fs + phase_shift(i)+deg2rad(step)*j) + randn(size(n))*0.05;
    end
end

end

