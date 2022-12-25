%% Load Data
clear all;
load DT_TrainData&TestData;
%% the same AmBe data as other methods for training
X=p_train_data_norm2000;
% X is the training data, which has been normalized

Y=p_train_data_norm2000_target;
% Y is the label of the training data
% neutrons are marked as '1' and gamma-rays are marked as '0

Tree = fitctree(X,Y);
% ClassificationTree represents a decision tree with binary splits for classification

%% the same Na and Cs data as other methods for testing
Na_NUM=size(p_test_Na_ori_1000M_norm,1);%Na Test samples
Cs_NUM=size(p_test_Cs_ori_1000M_norm,1);%Cs Test samples 
% Number of Na and Cs source data cases collected by electronics boards

Cs_Test_prediction = predict(Tree,p_test_Cs_ori_1000M_norm);
Na_Test_prediction = predict(Tree,p_test_Na_ori_1000M_norm);
% Classification Prediction on Test Data Using the Decision Tree

Na_Test_Error_Num = sum(Na_Test_prediction=='1');
Cs_Test_Error_Num = sum(Cs_Test_prediction=='1');
% Number of events misidentified as neutrons in gamma sources Na and Cs

FAR_of_Na  = (Na_Test_Error_Num./Na_NUM).*100;
FAR_of_Cs  = (Cs_Test_Error_Num./Cs_NUM).*100;
% the false alarm rates(FAR) of Na and Cs source

%% print the false alarm rates 
fprintf('the FAR of Na is: %.3f%%\n',FAR_of_Na);
fprintf('the FAR of Cs is: %.3f%%\n',FAR_of_Cs);

