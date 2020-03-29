% Pending documentation

if exist('gspc', 'var')
   clearvars -except gspc 
else
    clear
    gspc = readtable('raw_data/^GSPC.csv');
end

clc

startDate = datetime(1970, 1, 1);
endDate = gspc.Date(end);
timeStep = caldays(30);
period = calmonths(12:6:120);

t = startDate:timeStep:endDate;

MaxDiff = 0;
MaxStartDate = 0;
MaxEndDate = 0;

minDiff = intmax;
minStartDate = 0;
minEndDate = 0;

for p = period
    disp(p);
    for day = t

       [endWealth, diff, aagr] = simpleGrowth(gspc, day, min([day + p endDate]) , 100, 0); 

       if diff > MaxDiff
           MaxDiff = diff;
           MaxStartDate = day;
           MaxEndDate = day + p;
       elseif diff < minDiff
           minDiff = diff;
           minStartDate = day;
           minEndDate = day + p;
       end
    end
end

fprintf('Maximum GR was %.2f%% from %s until %s\n', MaxDiff, MaxStartDate, MaxEndDate);
fprintf('Minimum GR was %.2f%% from %s until %s\n', minDiff, minStartDate, minEndDate);