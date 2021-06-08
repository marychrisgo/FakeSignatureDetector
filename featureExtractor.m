function f = featureExtractor(x,y,p)

    f = [];
    f = [f, Ttotal(x)];
    f = [f, Npenups(p)];
    f = [f, Tpendown(p)];
    f = [f, Ppendown(p)];
    f = [f, Npeaks(y)];
    f = [f, Npeaks(x)];
    f = [f, SigSize(y)];
    f = [f, SigSize(x)];
    f = [f, AvgSpeed(x, y)];

end

function totalTime =  Ttotal(x)
    totalTime = double(numel(x))/ 200.0; % assume that the frequency of the device is 200Hz
end

function  Npu = Npenups(p)
    Npu = 0;
    pen_up = false;
    for i = 1:numel(p)
        if p(i) == 0
           if ~pen_up
               Npu = Npu + 1;
               pen_up = true;
           end
        else
            pen_up = false;
        end
    end
end

function  Tpd = Tpendown(p)
    Tpd = double(sum(p ~= 0)) / double(numel(p));
end

function  Ppd = Ppendown(p)
    Ppd = sum(p ~= 0);
end

function [out] = Npeaks(y)
    n = 20; % Length of running average filter
    running_avg = 1/n * ones(n,1);
    y = filter(running_avg, 1, y);

    out = length(findpeaks(y));
end

function [out] = SigSize(y)
    out = std(y);
end

function [out] = AvgSpeed(x, y)
    % Before taking the derivative, the signal is smoothed with a running
    % average filter

    n = 5; % Length of running average filter
    running_avg = 1/n * ones(n,1);
    y = filter(running_avg, 1, y);
    x = filter(running_avg, 1, x);

    dy = diff(y);
    dx = diff(x);

    out = mean(dy.^2 + dx.^2);
end
