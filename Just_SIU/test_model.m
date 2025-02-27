clc
clear all
close all
%%
load('trainedModelSVM_Medium.mat');
data = load("data_v3.mat").data;

for k = 1:998
    data_to_test(k,:) = num2cell((data{k,4}),1);
end

training_data = cell2table(data_to_test,'VariableNames',{'RMS' 'REAL_STFT' 'IMAG_STFT'});


for k = 1:998
    training_data.RMS{k} = cell2mat(training_data.RMS{k,1}.');
    training_data.REAL_STFT{k} = cell2mat(training_data.REAL_STFT{k,1}.');
    training_data.IMAG_STFT{k} = cell2mat(training_data.IMAG_STFT{k,1}.');
end

for m = 1:998
    mean_vector_acc(m,:) = mean(training_data.RMS{m,1});
    std_vector_acc(m,:) = std(training_data.RMS{m,1});
    labels(m,1) = data{m,3};

end

test_data = [labels mean_vector_acc std_vector_acc];
random_test_data_all = test_data(randperm(size(test_data, 1)), :);
random_test_data_label = random_test_data_all(:,1);
random_test_data= random_test_data_all(:,2:end);

for x = 1:998
    result(x) = trainedModelSVM_Medium.predictFcn(random_test_data(x,:));
end

final_result = result.';
get_my_score(random_test_data_label, final_result);
compare_array = [labels final_result];