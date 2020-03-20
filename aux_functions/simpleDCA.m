function [tInvested, tAssets, aagr] = simpleDCA(data, startDate, endDate, perAmount)
%[tInvested, tAssets, aagr] = simpleDCA(data, startDate, endDate, perAmount)
%Simulation of an investement with DCA
%
%   Parameters:
%   -----------
%   data = historical data to plot
%   startDate = initial date
%   endDate = final date
%   perAmount = periodic amount to invest every month
%
%   Returns:
%   --------
%   tInvested = total money invested
%   tAssets = final assets
%   aagr = Average Annual Growth Rate
%
%   Example:
%   --------
%   simpleDCA(gspc, datetime(2010, 1, 2), datetime(2015, 10, 20), 1000)


tInvested = 0;
nShares = 0;

% 1 - Get range of data between start and end dates
% 2 - Generate all the purchasing dates
% 3 - Acquire shares those dates
% 4 - Calculate the final price of those shares


% 1 - Get range of data between start and end dates
data = data(data.Date >= startDate & data.Date <= endDate, :);


% 2 - Generate all the purchasing dates
purchasingDates = startDate:calmonths(1):endDate;
l_purchasingDates = length(purchasingDates);
fprintf('There are %d items in purchasingDates\n', l_purchasingDates);

count = 0;
j = 1;


for i = 1 : length(data.Date)
    dDay = data.Date(i);
    pDay = purchasingDates(j);
    
    if dDay >= pDay
        % 3 - Acquire shares those dates
        tInvested = tInvested + perAmount;
        nShares = nShares + perAmount/data.Open(i);
        %fprintf('Bought %.4f shares on %s\n', perAmount/data.Open(i), dDay);
        
        
        j = j + 1;
        count = count + 1;
        if j > l_purchasingDates
            break;
        end
    end 
end

% 4 - Calculate the final price of those shares
tAssets = tInvested + nShares * data.Open(end);

nYears = datenum(endDate-startDate) / 365;
aagr = (tAssets - tInvested)/ tInvested / nYears * 100;

fprintf('We have bought %d times\n', count);
fprintf('nShares = %.4f\n', nShares);
fprintf('tInvested = %d\n', tInvested);
fprintf('tAssets = %.2f\n', tAssets);
fprintf('AAGR = %.2f%%\n', aagr);

end

