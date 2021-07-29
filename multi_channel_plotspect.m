function [h] = multi_channel_plotspect(h, data, fs)
[a, b] = size(data);
h = figure(h);

for i = 1:b
    subplot(ceil(b/2),2,i)
    x = data(:,i);
    deltaf = 1/length(x);
    X = 20*log10(fftshift((abs(fft(x)))));
    f = -0.5 : deltaf : 0.5-deltaf;
    xlbl_str = 'f_n'; 
    
    if(nargin == 3)
        f = f*fs;
        xlbl_str = 'f [Hz]'; 
    end
    title_str = append('Channel ', string(i));
    plot(f, X)
    xlabel(xlbl_str); ylabel('[dB]');
    title(title_str);
end

