function Score=Matcher(test,Model)

% N: Number of signatures in enrollment set
% M: Number of features
[N, M] = size(Model);

scores = zeros(1, N);

% Iterate over each signature
for n = 1:N
    s = sqrt(sum((test - Model(n, :)) .^ 2)); % Euclidean distance
    scores(n) = s;
end

Score=mean(scores);

end