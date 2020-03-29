if exist('gspc', 'var')
   clearvars -except gspc 
else
    clear
    gspc = readtable('raw_data/^GSPC.csv');
end

startDate = datetime(2010, 1, 2);
endDate = datetime(2011, 4, 5);