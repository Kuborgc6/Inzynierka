function [ h ] = plotspect(h, x, fs)
deltaf = 1/length(x);
X = 20*log10(fftshift((abs(fft(x)))));
f = -0.5 : deltaf : 0.5-deltaf;
xlbl_str = 'f_n'; 

if(nargin == 3)
 f = f*fs;
 xlbl_str = 'f [Hz]'; 
end

h = figure(h);
plot(f, X)
xlabel(xlbl_str); ylabel('[dB]');

end
