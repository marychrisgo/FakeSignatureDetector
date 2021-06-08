

close all
clear all
clc

n_features = 9;

%BiosecurIDparameters matrix with: 50 (users) x 16 (signatures/user) x n_features (params)
BiosecurIDparameters=ones(50,16,n_features);


%YOUR CODE

user = 1:50;
session = 1:4;
sign_genuine = 1:7;
sign_genuine = sign_genuine(sign_genuine ~= 3 & sign_genuine ~= 4 & sign_genuine ~= 5);
%You could use this inside your code

%This is how to load the signatures:  
for i = user
    for j = session
        z = 1;
        for k = sign_genuine
            if i<10
                BiosecurID=load(['./DB/u100', num2str(i),'s000', num2str(j), '_sg000', num2str(k), '.mat']);
            else
                BiosecurID=load(['./DB/u10', num2str(i),'s000', num2str(j), '_sg000', num2str(k), '.mat']);
            end

                x=BiosecurID.x;
                y=BiosecurID.y;
                p=BiosecurID.p;
                FeatVect = featureExtractor(x,y,p);
                BiosecurIDparameters(i,4*(j-1)+z,:) = FeatVect;
                z = z + 1;
        end
    end
end

tot_samples = 50*16;
BiosecurIDparameters_flat = reshape(BiosecurIDparameters,[tot_samples, n_features]);
%YOUR CODE         
% Plot for the total duration
figure(1);
[counts, centers] = hist(BiosecurIDparameters_flat(:,1));
bar(centers,counts/(tot_samples));
title("Total Time");
xlabel("time (sec)");
% Plot for the Number of Pen-ups
figure(2);
[counts, centers] = hist(BiosecurIDparameters_flat(:,2));

bar(centers,counts/(tot_samples));
title("Number of Pen-ups");
% Plot for Time of Pen-Downs
figure(3);
[counts, centers] = hist(BiosecurIDparameters_flat(:,3));
bar(centers,counts/(tot_samples));
title("Time for Pen-Downs");
% Plot for the Number of Pen-Downs
figure(4);
[counts, centers] = hist(BiosecurIDparameters_flat(:,4));
bar(centers,counts/(tot_samples));
title("Pressure of Pen-Downs");


% Normalize features

for f = 1:n_features
    BiosecurIDparameters(:, :, f) = BiosecurIDparameters(:, :, f) ./ std(BiosecurIDparameters(:, :, f), 1,  'all');

end

save('BiosecurIDparameters','BiosecurIDparameters');
