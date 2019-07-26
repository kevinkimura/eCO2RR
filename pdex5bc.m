function [pl,ql,pr,qr] = pdex5bc(xl,ul,xr,ur,t)
% pl = [ul(1)-0.024; ul(2)-0.475; ul(3)-0.04; ul(4)-3.3e-5];
% ql = [0; 0; 0; 0];

%setting up the left boundary conditions
pl = [ul(1)-0.0342; ul(2)-0.499; ul(3)-7.6e-4; ul(4)-3.3e-7];
ql = [0; 0; 0; 0];
j = 100/1000;
F = 96485;

%constant (same for 5s pulse) -1V vs RHE FE values
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

%chemical reaction conversion equations
CO2F = (j/F)*(cefHCOO/zeffHCOO + cefCO/zeffCO + cefCH4/zeffCH4 + 2*cefC2H4/zeffC2H4);
OHF = (j/F)*(cefHCOO/zeffHCOO + 2*cefCO/zeffCO + 8*cefCH4/zeffCH4 + 12*cefC2H4/zeffC2H4);

%right boundary conditions for the CONSTANT case
pr = [CO2F; 0; 0; -OHF];
qr = [1; 1; 1; 1];

%right boundary condition for the PULSE case
% x = floor(t/5);
% for i = 1:length(x)
%     if mod(x(i),2) == 0
%         pr = [CO2F; 0; 0; -OHF];
%         qr = [1; 1; 1; 1];
%     else
%         pr = [0; 0; 0; 0];
%         qr = [1; 1; 1; 1];
%     end
%     
% end