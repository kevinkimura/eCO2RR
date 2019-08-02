T = readtable('pt4_CV_initial.csv');    % reading in CV csv file
T.Properties.VariableNames = {'potential' 'current'};

CV = T{:,:};    % converting table to array

% plot(CV(:,1),CV(:,2))


%% each scan starts at -0.2V and scans down to -1.65V and cycles back to -0.2V
% each row is a new scan cycle

r = 3; % this is the number of scans in file
s = size(CV); % finding size of matrix rowsxcolumns
m = s(1);   % number of rows
n = s(2);   % number of columns
k = 1;  % starting counter off at first column
j = 1;  % starting counter off at first row
previous = -0.2;

current = zeros(r,n/2);
potential = zeros(r,n/2);


for i = 1:m-1  % iterating through all of the rows
    difference = CV(i,1) - previous;
    
    current(j,k) = CV(i,2);
    potential(j,k) = CV(i,1);
    k = k + 1;

    futurediff = CV(i+1,1) - CV(i,1);
    if futurediff < 0 && difference > 0     % if the scan is switching from anodic scan to cathodic scan indicating cycle endpoint
        j = j + 1;
        k = 1;
    end
    
    previous = CV(i,1);
            
end

figure 
hold on
for q = 1:r
    plot(potential(q,:),current(q,:))
end

xlabel('potential (V)')
ylabel('current (mA)')
legend('first scan', 'second scan', 'third scan')

save('pt4_initialCV_current.mat','current')
save('pt4_initialCV_potential.mat','potential')

