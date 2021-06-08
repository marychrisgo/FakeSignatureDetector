close all
clear all
clc

%load de signature parameters
mat=load('BiosecurIDlocalparameters.mat');
BiosecurIDlocalparameters=mat.BiosecurIDlocalparameters;

%obtain size of users and signatures/user
usuarios=size(BiosecurIDlocalparameters,1);
firmas=size(BiosecurIDlocalparameters,2);

%% GENUINE SCORES
i=1; n=1;

GenuineScores=cell(1,3);
for N=[2 4 12]
    for us=1:usuarios
            %Extract the user model
            modelo=BiosecurIDlocalparameters(us,1:N);
%             modelo=reshape(modelo,N,4);

            for n_test=N+1:firmas 
                %Test signatures: remaining signatures of the user
                test=BiosecurIDlocalparameters(us,n_test);
%                 test=reshape(test,1,4);
                Score = DTW_local_matcher(test, modelo);
                GenuineScores{n}(us,i)= Score;
                i=i+1;

            end
        i=1;
    end
    n=n+1;
end

GenuineScores_1=GenuineScores{1};
GenuineScores_4=GenuineScores{2};
GenuineScores_12=GenuineScores{3};

save('GenuineScores_1.mat', 'GenuineScores_1');
save('GenuineScores_4.mat', 'GenuineScores_4');
save('GenuineScores_12.mat', 'GenuineScores_12');


%% IMPOSTOR SCORES

i=1; n=1;

ImpostorScores=cell(1,3);
for N=[1 4 12]
    for us=1:usuarios
            %Extract the user model
            modelo=BiosecurIDlocalparameters(us,1:N);
%             modelo=reshape(modelo,N,4);

            for n_test=1:usuarios 
                if (n_test~=us) %the score is only computed using the other users
                    %First signature of the other user
                    test=BiosecurIDlocalparameters(n_test,1);%Always the first signature
%                     test=reshape(test,1,4);
                    Score = DTW_local_matcher(test, modelo);
                    ImpostorScores{n}(us,i)= Score; %50x49 for any N
                    i=i+1;
                end
            end
        i=1;
    end
    n=n+1;
end

ImpostorScores_1=ImpostorScores{1};
ImpostorScores_4=ImpostorScores{2};
ImpostorScores_12=ImpostorScores{3};

save('ImpostorScores_1.mat', 'ImpostorScores_1');
save('ImpostorScores_4.mat', 'ImpostorScores_4');
save('ImpostorScores_12.mat', 'ImpostorScores_12');

%So far, you have obtained the similarity distance between signatures (values close to
%0 for genuine comparisons and higher for impostor comparisons). However,
%we want to obtain the SCORE (higher for genuine comparisons than for
%impostor comparisons).

% YOUR CODE

addpath('./DetPlots');

figure;
[EER1,DCF_opt1,ThresEER1]=Eval_Det(GenuineScores_1(:)',ImpostorScores_1(:)','b')
figure;
[EER4,DCF_opt4,ThresEER4]=Eval_Det(GenuineScores_4(:)',ImpostorScores_4(:)','b')
figure;
[EER12,DCF_opt12,ThresEER12]=Eval_Det(GenuineScores_12(:)',ImpostorScores_12(:)','b')


