function [endWealth, difference, aagr] = simpleGrowth(data, startDate, endDate, startWealth, verbose)
%[endWealth, difference, aagr] = simpleGrowth(data, startDate, endDate, startWealth, verbose)
%Calculate the final value and AAGR of a single-time investment
%
%   Parameters:
%   -----------
%   data = historical data to analyze
%   startDate = initial date in the format "yyyy-MM-dd"
%   endDate = final date in the format "yyyy-MM-dd"
%   startWealth = initial contribution
%   verbose = enable verbose logging
%
%   Return:
%   -------
%   endWealth = value at the final date
%   difference = gross returns
%   aagr = Average Annual Growth Rate
%
%   Example:
%   --------
%   [endWealth, diff, aagr] = simpleGrowth(gspc,"2008-1-4","2018-1-2", 1000, 0);

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
    elseif (isempty(endSharePrice))
        j = j + 1;
    end
    
    if(i > 7 || j > 7)
       fprintf('Wrong dates\n')
       fprintf('\tstartDate: %s\n\tendDate: %s\n', startDate, endDate);
       fprintf('\ti: %d\n\tj: %d\n', i, j);
       return
    end
    
end

if ((i ~= 0) && verbose)
   fprintf('There was no value for %s so the startDate was changed to %s\n', startDate, startDate + i) 
end

if ((j ~= 0) && verbose)
   fprintf('There was no value for %s so the endDate was changed to %s\n', endDate, endDate + j) 
end


nShares = startWealth / startSharePrice;
endWealth = nShares * endSharePrice;
difference = endWealth - startWealth;
nYears = datenum(endDate-startDate) / 365;
aagr = difference / startWealth / nYears * 100;
end

