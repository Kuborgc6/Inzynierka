function [result_c,max_cor_sample, max_cor_mag] = multi_channel_correlation(data, micnumber, N, h)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

result_c = zeros(micnumber,micnumber,N*2+1);
max_cor_mag = zeros(micnumber,micnumber);
max_cor_sample = zeros(micnumber,micnumber);
for i = 1:micnumber
    for j = i:micnumber
        x = data(:,i);
        y = data(:,j);
        [c,lags] = xcorr(x,y,300);
        [max_cor_mag(i,j), temp] = max(c);
        [max_cor_mag(j,i), temp] = max(c);
        max_cor_sample(i,j) = N - temp;
        max_cor_sample(j,i) = N - temp;
        result_c(i,j,:) = c;
        result_c(j,i,:) = c;
    end
end


for i = 1:micnumber
    figure(h+i)
    for j = 1:micnumber
        subplot(ceil(micnumber/2),2,j)
        title_str = append("Korelacja między kanałem ",string(i)," i ", string(j));
        temp_c = zeros(1,length(result_c(i,j,:)));
        temp_c(1,:) = result_c(i,j,:);
        stem(lags,abs(temp_c));
        title(title_str);
    end
end

end

