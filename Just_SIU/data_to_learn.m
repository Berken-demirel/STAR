close all
clc 
clear
%%
data = load("data_v3.mat").data;

size_of_data = 25;

for k = 1:size_of_data
    data_to_learn_acce(k,:) = num2cell((data{k,4}),1);
    data_to_label_acce(k,1) = num2cell((data{k,3}),1);
end

for k = (998-size_of_data +1):998
    data_to_learn_un(k - (998-size_of_data),:) = num2cell((data{k,4}),1);
    data_to_label_un(k - (998-size_of_data),1) = num2cell((data{k,3}),1);
end

data_label = [data_to_label_acce ; data_to_label_un];
data_learn = [data_to_learn_acce ; data_to_learn_un];

training_data_cell = [data_label data_learn];

training_data = cell2table(training_data_cell,'VariableNames',{'Labels' 'RMS' 'REAL_STFT' 'IMAG_STFT'});

for k = 1:(2*size_of_data)
    training_data.RMS{k} = cell2mat(training_data.RMS{k,1}.');
    training_data.REAL_STFT{k} = cell2mat(training_data.REAL_STFT{k,1}.');
    training_data.IMAG_STFT{k} = cell2mat(training_data.IMAG_STFT{k,1}.');
end

labels = training_data.Labels;

for m = 1:(2*size_of_data)
    mean_vector_acc(m,:) = mean(training_data.RMS{m,1});
    std_vector_acc(m,:) = std(training_data.RMS{m,1});
end
training_data = [labels mean_vector_acc std_vector_acc];


