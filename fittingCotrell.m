T = readtable('pt4_initial.csv');       % this is the current data collected at very small time intervals
T.Properties.VariableNames = {'time' 'current'};


HER = .30;   % ratio of total current that is HER
CO2RR = 1 - HER;    % fraction of current that is CO2 reduction current

T.current = T.current .* CO2RR; % converting total current to current that is due to CO2 reduction

data = T{:,:};  % converting table to array

figure
plot(data(:,1),data(:,2))
xlabel('time sec')
ylabel('CO2 current mA')

%% Getting Cathodic Current from CA data
cathodic_current = zeros(100,25);
cathodic_time = zeros(100,25);


s = size(data); % finding size of matrix rowsxcolumns
m = s(1);   % number of rows
n = s(2);   % number of columns
k = 1;  % starting counter off at first column
j = 1;  % starting counter off at first row
previous = 1;
for i = 1:m  % iterating through all of the rows
        
        if data(i,2) < 0   % if the value of the current is negative
            cathodic_current(j,k) = data(i,2);   % add the current value to the cathodic current matrix
            cathodic_time(j,k) = data(i,1);      % add the time of that current value to the cathodic time matrix
            previous = data(i,2);  % reset the previous value
            k = k + 1;  % increase the column counter
        end
        if data(i,2) > 0   % if the current value is positive
            if data(i,2) * previous < 0 % and if the current value is switching from negative to positive
                j = j + 1;  % increase the row counter
                k = 1;  % reset the column counter
                previous = data(i,2); % reset the previous value
            else % if it's still another positive value
                previous = data(i,2);  % reset the previous value
            end
        end
            
end

% setting criteria so that random negative current values don't create
% their own row full of zeros
% may have to modify the criteria since it's case by case
TF1 = cathodic_current(:,7) ==0;
TF2 = cathodic_current(:,3) ==0;
TF3 = cathodic_current(:,4) ==0;
TF4 = cathodic_current(:,5) ==0;
TF5 = cathodic_current(:,6) ==0;
TFail = TF1 & TF2 & TF3 & TF4 & TF5;
cathodic_current(TFail,:) = [];
cathodic_current = cathodic_current(:,1:26);
cathodic_time(TFail,:) = [];
cathodic_time = cathodic_time(:,1:26);

%% Getting Faradaic Current from Cathodic Current

z = [0:0.05/25:0.05];   % each pulse is 50 ms
faradaic_time = z(7:length(z)); % may have to modify when to start counting it as Faradaic. play around with this and see what works best
% Faradaic time, z, cathodic current are all linked so you have to make
% sure that vectors are the same size (lines 63,64,70)

q = size(cathodic_current); % finding size of matrix rowsxcolumns
r = q(2);   % number of columns
faradaic_current = cathodic_current(:,7:r);

figure
plot(z,cathodic_current(5,:))
hold on
plot(z,cathodic_current(10,:))
plot(z,cathodic_current(20,:))
plot(z,cathodic_current(30,:))
plot(z,cathodic_current(40,:))
plot(z,cathodic_current(50,:))
plot(z,cathodic_current(60,:))
plot(z,cathodic_current(70,:))
plot(z,cathodic_current(80,:))
plot(z,cathodic_current(90,:))
plot(z,cathodic_current(100,:))
legend('5th pulse','10th pulse', '20th pulse','30th pulse','40th pulse', '50th pulse','60th pulse', '70th pulse', '80th pulse','90th pulse','100th pulse')
xlabel('time seconds')
ylabel('cathodic current mA')

figure
plot(faradaic_time,faradaic_current(5,:))
hold on
plot(faradaic_time,faradaic_current(10,:))
plot(faradaic_time,faradaic_current(20,:))
plot(faradaic_time,faradaic_current(30,:))
plot(faradaic_time,faradaic_current(40,:))
plot(faradaic_time,faradaic_current(50,:))
plot(faradaic_time,faradaic_current(60,:))
plot(faradaic_time,faradaic_current(70,:))
plot(faradaic_time,faradaic_current(80,:))
plot(faradaic_time,faradaic_current(90,:))
plot(faradaic_time,faradaic_current(100,:))
legend('5th pulse','10th pulse', '20th pulse','30th pulse','40th pulse', '50th pulse','60th pulse', '70th pulse', '80th pulse','90th pulse','100th pulse')
xlabel('time (seconds)')
ylabel('Faradaic current (mA)')

%% Fitting Faradaic Current to Cottrell Equation to Solve for K
% i = K/sqrt(t) where K = nFAc*sqrt(D)

% % Cottrell Equation Fit
time_fit = faradaic_time .* 1000; %time for fit converted to ms
K = -.3; %initial guess for the constand of cottrell i = K/sqrt(t)
c = -.3;
% c = pulse(end,2); %const to shift down


rmse = 100;
for i = 1:100000
    Ktest = -3*rand(1); % may have to modify these values to get a better fit
    ctest = -2*rand(1); % may have to modify these values to get a better fit
    current_fit = Ktest.*time_fit.^(-1/2)+ctest;
    rms_t = sqrt(sum((current_fit - faradaic_current(100,:)).^ 2)); 
    if rms_t <= rmse
        K = Ktest;
        c = ctest;
        rmse = rms_t;
    else
    end
end
current_fit = K.*time_fit.^(-1/2)+c;

a = num2str(K);
b = num2str(rmse);

figure
hold on
plot(time_fit,faradaic_current(100,:),'Linewidth',2)
plot(time_fit,current_fit,'Linewidth',2)
xlabel('time (ms)')
ylabel('current (mA)')

figure
plot(1./sqrt(time_fit),(faradaic_current(100,:)))
xlabel('1/sqrt(t) (ms^-0.5)')
ylabel('current (mA)')

%% Calculating D from K
% i = K/sqrt(t) where K = nFAc*sqrt(D)

n = 1;      % number of electrons transferred
F = 96485 * 1000;  % Faraday's constant C/mol where 1 C = 1 amp-second multiplied by 1000 to get it into mA sec/mol
A = 0.165;  % area of electrode in cm2
C = 0.0342; % concentration of CO2 in moles/L
C_CO2 = C * 0.001;  % concentration of CO1 in moles/cm3

D_CO2 = (K/(n*F*A*C_CO2))^2;    % finding diffusivity of CO2 in cm2/sec