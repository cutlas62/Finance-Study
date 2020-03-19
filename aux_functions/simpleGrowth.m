function [endWealth] = simpleGrowth(data,startWealth,startDate, endDate)
%SIMPLEGROWTH Summary of this function goes here
%   Detailed explanation goes here

startDate = datetime(startDate, 'Inputformat', 'yyyy-MM-dd');
endDate = datetime(endDate, 'InputFormat', 'yyyy-MM-dd');

i = 0;
j = 0;
while 1
    startSharePrice = data.Open(data.Date == startDate + i);
    endSharePrice = data.Open(data.Date == endDate + j);
    if (~isempty(startSharePrice) && ~isempty(endSharePrice))
        break;
    elseif (isempty(startSharePrice))
        i = i + 1;
    else
        j = j + 1;
    end
    
end

if (i ~= 0)
   fprintf('There was no value for %s so the startDate was changed to %s\n', startDate, startDate + i) 
end

if (j ~= 0)
   fprintf('There was no value for %s so the endDate was changed to %s\n', endDate, endDate + i) 
end


nShares = startWealth / startSharePrice;
endWealth = nShares * endSharePrice;
end

