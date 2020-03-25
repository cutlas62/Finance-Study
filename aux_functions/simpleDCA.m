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
plotPeriod(data, startDate, endDate);
hold on


% 2 - Generate all the purchasing dates
purchasingDates = startDate:calmonths(6):endDate;
l_purchasingDates = length(purchasingDates);
%fprintf('There are %d items in purchasingDates\n', l_purchasingDates);


count = 0;
j = 1;


for i = 1 : length(data.Date)
    dDay = data.Date(i);
    pDay = purchasingDates(j);
    
    if dDay >= pDay
        % 3 - Acquire shares those dates
        tInvested = tInvested + perAmount;
        nShares = nShares + perAmount/data.Open(i);
        %fprintf('Bought %.4f shares on %s for %.2f per share\n', perAmount/data.Open(i), dDay, data.Open(i));
        %fprintf('nShares = %.2f\ttInvested = %d\tAssets = %.2f\n', nShares, tInvested, nShares * data.Open(i));
        plot(data.Date(i), data.Open(i), 'go', 'MarkerSize', 5, 'MarkerEdgeColor', [0,0.9,0], 'MarkerFaceColor', [0,0.75,0]);
        
        j = j + 1;
        count = count + 1;
        if j > l_purchasingDates
            break;
        end
    end 
end
legend('\^GSPC','Purchasing Dates')
title('Investment simulation with DCA')
xlabel('Time')
ylabel('Price')
ytickformat('usd')
hold off

% 4 - Calculate the final price of those shares
tAssets = nShares * data.Open(i);
nYears = datenum(endDate-startDate) / 365;
aagr = (tAssets - tInvested)/ tInvested / nYears * 100;

end

