close all
clear all
clc

%BiosecurIDlocalparameters matrix with: 50 (users) x 16 (signatures/user) x 4 (params)
BiosecurIDlocalparameters=cell(50,16); % We will assume number of samples equal 500


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
                normX = BiosecurID.x - min(BiosecurID.x(:));
                normX = normX ./ max(normX(:));
                normY = BiosecurID.y - min(BiosecurID.y(:));
                normY = normY ./ max(normY(:));
                normP = BiosecurID.p - min(BiosecurID.p(:));
                normP = normP ./ max(normP(:));
                BiosecurIDlocalparameters{i,4*(j-1)+z}.x = normX;
                BiosecurIDlocalparameters{i,4*(j-1)+z}.y = normY;
                BiosecurIDlocalparameters{i,4*(j-1)+z}.p = normP;
                BiosecurIDlocalparameters{i,4*(j-1)+z}.x1 = diff(normX);
                BiosecurIDlocalparameters{i,4*(j-1)+z}.y1 = diff(normY);
                BiosecurIDlocalparameters{i,4*(j-1)+z}.p1 = diff(normP);
                BiosecurIDlocalparameters{i,4*(j-1)+z}.x2 = diff(BiosecurIDlocalparameters{i,4*(j-1)+z}.x1);
                BiosecurIDlocalparameters{i,4*(j-1)+z}.y2 = diff(BiosecurIDlocalparameters{i,4*(j-1)+z}.y1);
                BiosecurIDlocalparameters{i,4*(j-1)+z}.p2 = diff(BiosecurIDlocalparameters{i,4*(j-1)+z}.p1);
                z = z + 1;
        end
    end
end
tot_samples = 50*16;
BiosecurIDparameters_flat = reshape(BiosecurIDlocalparameters,[tot_samples, 1 ]);

save('BiosecurIDlocalparameters','BiosecurIDlocalparameters');
