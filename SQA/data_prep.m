clearvars
close all
clc
%% Data-prep
data = load('data.mat').D;

data_lead2 = [];
counter = 1;
for i = 1:length(data(:,2))
    processed_data = data{i,2};
    processed_data = processed_data(:,2);
    data_lead2(:,counter) = processed_data(1:2500);
    counter = counter + 1;
    data_lead2(:,counter) = processed_data(2501:end);
    counter = counter + 1;
end

data_resampled = resample(data_lead2,1024,2500);
% Normalize
data_resampled = normalize(data_resampled);

feature1 = []; %Mean of the movstd
feature2 = []; %Std of the movstd
feature3 = []; %Sum of the first 30 samples
feature4 = []; 
for i = 1:length(data_resampled(1,:))
    processed_data = data_resampled(:,i);
    feature1(i,1) = mean(movstd(processed_data,102));
    feature2(i,1) = std(movstd(processed_data,102));
    fft1 = abs(fftshift(fft(processed_data)));
    feature3(i,1) = sum(fft1(512:542));
    feature4(i,1) = sum(fft1(end-30:end));
end
feature = [feature1 feature2 feature3 feature4];

idx = kmeans(feature,2);

figure,
plot(feature(idx==1,1),feature(idx==1,2),'r.','MarkerSize',12)
hold on
plot(feature(idx==2,1),feature(idx==2,2),'b.','MarkerSize',12)


%plot(feature(:,3),feature(:,4),'k*','MarkerSize',5);