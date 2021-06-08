function Score=DTW_local_matcher(test,Model)

% N: Number of signatures in enrollment set
[~, N] = size(Model);

scores = zeros(1, N);

test_sig = cell2mat(test);
x_t = test_sig.x;
y_t = test_sig.y;
p_t = test_sig.p;
x1_t = test_sig.x1;
y1_t = test_sig.y1;
p1_t = test_sig.p1;
x2_t = test_sig.x2;
y2_t = test_sig.y2;
p2_t = test_sig.p2;
% Iterate over each signature
n_t_function = 9;
for n = 1:N
    scores_t = zeros(1, n_t_function);
    x_m = Model{n}.x;
    y_m = Model{n}.y;
    p_m = Model{n}.p;
    x1_m = Model{n}.x1;
    y1_m = Model{n}.y1;
    p1_m = Model{n}.p1;
    x2_m = Model{n}.x2;
    y2_m = Model{n}.y2;
    p2_m = Model{n}.p2;
%     x = [x_m; y_m; p_m; x1_m; y1_m; p1_m];
%     y = [x_t; y_t; p_t; x1_t; y1_t; p1_t];
    [D,ix,iy] = dtw(x_m,x_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(1) = exp(-D/K);
    [D,ix,iy] = dtw(y_m,y_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(2) = exp(-D/K);
    [D,ix,iy] = dtw(p_m,p_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(3) = exp(-D/K);
    [D,ix,iy] = dtw(x1_m,x1_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(4) = exp(-D/K);
    [D,ix,iy] = dtw(y1_m,y1_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(5) = exp(-D/K);
    [D,ix,iy] = dtw(p1_m,p1_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(6) = exp(-D/K);
    [D,ix,iy] = dtw(x2_m,x2_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(7) = exp(-D/K);
    [D,ix,iy] = dtw(y2_m,y2_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(8) = exp(-D/K);
    [D,ix,iy] = dtw(p2_m,p2_t);
    ix = unique(ix);
    iy = unique(iy);
    K = min(length(ix),length(iy));
    scores_t(9) = exp(-D/K);
    s = mean(scores_t);
    scores(n) = s;
end

Score=mean(scores);

end