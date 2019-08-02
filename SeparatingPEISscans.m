T = readtable('pt4.csv');  % reading in PEIS data from Nyquist Plot
T.Properties.VariableNames = {'RealZ_Ohm', 'NegImZ_Ohm'};

PEIS = T{:,:};  % converting table to array

%plot(PEIS(:,1),PEIS(:,2))


%% Separating PEIS scans

r = 3;  % number of scan cycles
s = size(PEIS); % finding size of matrix rowsxcolumns
m = s(1);   % number of rows
n = s(2);   % number of columns
k = 1;  % starting counter off at first column
j = 1;  % starting counter off at first row
previous = 199; % this is about where the first point falls on the x axis

Real_Z = zeros(r,n/2);
Imag_Z = zeros(r,n/2);


for i = 1:m-1  % iterating through all of the rows
    
    Real_Z(j,k) = PEIS(i,1);
    Imag_Z(j,k) = PEIS(i,2);
    k = k + 1;

    futurediff = PEIS(i+1,1) - PEIS(i,1);
    if futurediff < -12000      % if the scan is at the end and starting all the way back near zero in a new scan cycle
        j = j + 1;
        k = 1;
    end
    
    previous = PEIS(i,1);
            
end

figure 
hold on
for q = 1:r
    plot(Real_Z(q,1:34),Imag_Z(q,1:34)) % the final column index will change based on data set
end

xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('first scan', 'second scan', 'third scan')

save('pt4_PEIS_ReZ.mat','Real_Z')
save('pt4_PEIS_ImagZ.mat','Imag_Z')
