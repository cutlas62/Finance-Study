function plotPeriod(data, dStart, dEnd)
%plotPeriod(data, dStart, dEnd)
%
%   Plot a period between 'dStart' and 'dEnd'.
%   Both dates have to be in "yyyy-MM-dd" format.
%
%   plotPeriod(gspc,"2010-1-31","2015-12-10")

    if ~exist('data', 'var')
        fprintf('\tERROR: %s does not exist. Did you load it first?\n', data)
        fprintf('\ttype ''help plotPeriod'' for more information\n')
        return
    end
    
    startDate = datetime(dStart, 'Inputformat', 'yyyy-MM-dd');
    endDate = datetime(dEnd, 'InputFormat', 'yyyy-MM-dd');
    
    if startDate > endDate
       fprintf('\tERROR: Start date must be before End date\n')
       fprintf('\ttype ''help plotPeriod'' for more information\n')
       return
    end
    
    dateRange = (data.Date > startDate) & (data.Date < endDate);
    
    plot(data.Date(dateRange), data.Open(dateRange))
end