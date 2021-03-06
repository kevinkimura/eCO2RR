% electrode is on right side
% BCs must be of the form p(x,t,u) + q(x,t)*f(x,t,u,du/dx)= 0

function [pl,ql,pr,qr] = pdex5bc(xl,ul,xr,ur,t)

%setting up the left boundary conditions (flux=0 in bulk solution aka concentration = initial equilibrium concentration)
pl = [ul(1)-0.0342; ul(2)-0.499; ul(3)-7.6e-4; ul(4)-3.3e-7];
ql = [0; 0; 0; 0];
j = 100/1000;   % current density in A/m2
F = 96485;  % Faraday's constant

%constant (same for 5s pulse) -1V vs RHE FE values
% current efficiencies from Gupta et al.
cefHCOO = 0.1;
cefCO = 0.05;
cefC2H4 = 0.2;
cefCH4 = 0.25;

%50ms -1V vs RHE FE values
% cefHCOO = 0.04;
% cefCO = 0.32;
% cefC2H4 = 0.08;
% cefCH4 = 0.49;

%1s -1V vs RHE FE values
% cefHCOO = 0.04;
% cefCO = 0.32;
% cefC2H4 = 0.08;
% cefCH4 = 0.49;

%100ms -1V vs RHE FE values
% cefHCOO = 0.06;
% cefCO = 0.20;
% cefC2H4 = 0.24;
% cefCH4 = 0.38;

%number of electrons transferred
zeffHCOO = 2;
zeffCO = 2;
zeffC2H4 = 12;
zeffCH4 = 8;

%chemical reaction conversion equations from Gupta et al.
CO2F = (j/F)*(cefHCOO/zeffHCOO + cefCO/zeffCO + cefCH4/zeffCH4 + 2*cefC2H4/zeffC2H4);
OHF = (j/F)*(cefHCOO/zeffHCOO + 2*cefCO/zeffCO + 8*cefCH4/zeffCH4 + 12*cefC2H4/zeffC2H4);

% right boundary conditions for the CONSTANT case (Faraday's law at the electrode surface)
% pr = [CO2F; 0; 0; -OHF];    % why are they not divided by diffusion coefficient?? because f is already defined with diffusion coefficients
% qr = [1; 1; 1; 1];

% % right boundary condition for the PULSE case
% x = floor(t/.5); % rounds the elements of x to the nearest integer. divide t by some value to indicate pulse time
% for i = 1:length(x)
%     if mod(x(i),2) == 0   % mod(x,y) returns x - (floor(x/y)*y) so it will equal 0 when x is an even number
%         pr = [CO2F; 0; 0; -OHF];
%         qr = [1; 1; 1; 1];
%     else
%         pr = [0; 0; 0; 0];
%         qr = [1; 1; 1; 1];
%     end
%     
% end

% % right boundary condition for the PULSE case using square function
duty = 20;
% f = 100;    % period (seconds) = 1/f = 5ms symmetric pulses = 10ms period
f = 10; % period of 100ms aka 50ms pulses
% f = .2; %5 second period
%f = .1; % 10 second period
x = square(2*pi*f*t,duty);
for i = 1:length(x)
    if x(i) < 0    
        pr = [CO2F; 0; 0; -OHF];
        qr = [1; 1; 1; 1];
    else
        pr = [0; 0; 0; 0];
        qr = [1; 1; 1; 1];
    end
    
end
