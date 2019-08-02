
T = readtable('pt4_bulk.csv');      % this is the bulk current data collected
T.Properties.VariableNames = {'time' 'current'};

data = T{:,:};      % converting table to array

len = length(data);

figure
plot(data(:,1),data(:,2))
%%
GCsections = 6;     % number of GC samples collected during this current section

filtered = zeros(round(len/GCsections),2); %% rounds up, divides length by number of GC samples taken during part, makes a matrix of zeros with two columns
ct = 1; % initializing the counter

for i = 1:len
    % finding faradaic current
    if data(i,2) < 0 && data(i,2) > -1.3 %% taking current data that is negative but not huge negative charging spikes. this value will change based on case
        filtered(ct,:) = data(i,:); % adding cathodic Faradaic current data to new matrix
        ct = ct +1;
    else
    end
end


save('filtered_data.mat','filtered')

close all

%% Finding Average Faradaic Current from Previously Filtered Data

load('filtered_data.mat')

filtered(:,1) = filtered(:,1) - filtered(1,1);  % scaling the time to start at 0
CAavgI = zeros(GCsections,1);   % vector of average current for each GC section
ct = ones(GCsections,1);
filterlen = length(filtered);

time_section = (filtered(end,1) - filtered(1,1))/GCsections;    % like a dt
time_start = filtered(1,1);

for i =1:filterlen
    if filtered(i,1) <= time_start + time_section % first sixth
        CAavgI(1) = CAavgI(1) + filtered(i,2);
        ct(1) = ct(1) + 1;
    elseif filtered(i,1) > time_start + time_section && filtered(i,1) <= time_start + (2*time_section) % second sixth
        CAavgI(2) = CAavgI(2) + filtered(i,2);
        ct(2) = ct(2) + 1;
    elseif filtered(i,1) > time_start + (2*time_section) && filtered(i,1) <= time_start + (3*time_section) % third sixth
        CAavgI(3) = CAavgI(3) + filtered(i,2);
        ct(3) = ct(3) + 1;
    elseif filtered(i,1) > time_start + (2*time_section) && filtered(i,1) <= time_start + (4*time_section) % fourth sixth
        CAavgI(4) = CAavgI(4) + filtered(i,2);    
        ct(4) = ct(4) + 1;
    elseif filtered(i,1) > time_start + (2*time_section) && filtered(i,1) <= time_start + (5*time_section) % fifth sixth
        CAavgI(5) = CAavgI(5) + filtered(i,2);    
        ct(5) = ct(5) + 1;
    elseif filtered(i,1) > time_start + (5*time_section) % sixth sixth
        CAavgI(6) = CAavgI(6) + filtered(i,2);    
        ct(6) = ct(6) + 1;   
    end
end
 
% calculating the averages
CAavgI(1) = CAavgI(1)/ct(1);
CAavgI(2) = CAavgI(2)/ct(2);
CAavgI(3) = CAavgI(3)/ct(3);
CAavgI(4) = CAavgI(4)/ct(4);
CAavgI(5) = CAavgI(5)/ct(5);
CAavgI(6) = CAavgI(6)/ct(6);

figure
hold on
plot(filtered(:,1),filtered(:,2))
plot(time_start + (time_section),CAavgI(1),'o')
plot(time_start + (2*time_section), CAavgI(2),'o')
plot(time_start + (3*time_section), CAavgI(3),'o')
plot(time_start + (4*time_section), CAavgI(4),'o')
plot(time_start + (5*time_section), CAavgI(5),'o')
plot(time_start + (6*time_section), CAavgI(6),'o')

CAavgI