clear;
close all;

%%
[a1, a2, a3] = size(data_loop);
for i = 1:a1
data_loop(i,:,:) = clean_all(data_loop(i,:,:), [4e2 6e2], 44100);% konieczne bo mikrofony mają zakres do 10kHz
end

h10prim = multi_audio_plot(31, data);
hprim = multi_channel_plotspect(41, data, 44100);

% [result_c, max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h*10);
[result_c_loop,max_cor_mag_loop, max_cor_sample_loop, correlation_channel_1] = loop_correlation(data_loop, N, h);
[difference_loop] = loop_phase_difference(data_loop);


