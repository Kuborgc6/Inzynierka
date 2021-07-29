function [h] = multi_audio_plot(h, data)
[a, b] = size(data);
h = figure(h);

for i = 1:b
    subplot(ceil(b/2),2,i)
    x = data(:,i);
    title_str = append('Channel ', string(i));
    plot(x);
    title(title_str);
end

