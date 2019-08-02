clc
close all

pt2_real = load('pt2_PEIS_ReZ');
pt2_imag = load('pt2_PEIS_ImagZ');

pt3_real = load('pt3_PEIS_ReZ');
pt3_imag = load('pt3_PEIS_ImagZ');

pt4_real = load('pt4_PEIS_ReZ');
pt4_imag = load('pt4_PEIS_ImagZ');

pt5_real = load('pt5_PEIS_ReZ');
pt5_imag = load('pt5_PEIS_ImagZ');

pt6_real = load('pt6_PEIS_ReZ');
pt6_imag = load('pt6_PEIS_ImagZ');

pt9_real = load('pt9_PEIS_ReZ');
pt9_imag = load('pt9_PEIS_ImagZ');

pt10_real = load('pt10_PEIS_ReZ');
pt10_imag = load('pt10_PEIS_ImagZ');

pt11_real = load('pt11_PEIS_ReZ');
pt11_imag = load('pt11_PEIS_ImagZ');

pt12_real = load('pt12_PEIS_ReZ');
pt12_imag = load('pt12_PEIS_ImagZ');

pt13_real = load('pt13_PEIS_ReZ');
pt13_imag = load('pt3_PEIS_ImagZ');

pt16_real = load('pt16_PEIS_ReZ');
pt16_imag = load('pt16_PEIS_ImagZ');

pt28_real = load('pt28_PEIS_ReZ');
pt28_imag = load('pt28_PEIS_ImagZ');

%%

figure 
plot(pt2_real(1).Real_Z(2,1:34),pt2_imag(1).Imag_Z(2,1:34),'LineWidth',8)
hold on
plot(pt3_real(1).Real_Z(2,1:33),pt3_imag(1).Imag_Z(2,1:33),'LineWidth',8)
title('50kHz to 100mHz, 10mV perturbations')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('Single Sine', 'Multiple Sine')
hold off

figure
plot(pt3_real(1).Real_Z(2,1:33),pt3_imag(1).Imag_Z(2,1:33),'LineWidth',8)
hold on
plot(pt4_real(1).Real_Z(2,1:34),pt4_imag(1).Imag_Z(2,1:34),'LineWidth',8)
title('Multi Sine, 10mV perturbations')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('50kHz to 100mHz', '80kHz to 100mHz')
hold off

figure
plot(pt4_real(1).Real_Z(2,1:34),pt4_imag(1).Imag_Z(2,1:34),'LineWidth',8)
hold on
plot(pt5_real(1).Real_Z(2,1:32),pt5_imag(1).Imag_Z(2,1:32),'LineWidth',8)
plot(pt16_real(1).Real_Z(2,1:31),pt16_imag(1).Imag_Z(2,1:31),'LineWidth',8)
title('Multi Sine, 10mV perturbations')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('80kHz to 100mHz', '80kHz to 200mHz', '80kHz to 300mHz')
hold off

figure
plot(pt5_real(1).Real_Z(2,1:32),pt5_imag(1).Imag_Z(2,1:32),'LineWidth',8)
hold on
plot(pt6_real(1).Real_Z(2,1:32),pt6_imag(1).Imag_Z(2,1:32),'LineWidth',8)
title('Multi Sine, 80kHz to 200mHz')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('10mV perturbations', '5mV perturbations')
hold off

figure
plot(pt9_real(1).Real_Z(2,1:33),pt9_imag(1).Imag_Z(2,1:33),'LineWidth',8)
hold on
plot(pt10_real(1).Real_Z(2,1:33),pt10_imag(1).Imag_Z(2,1:33),'LineWidth',8)
plot(pt11_real(1).Real_Z(2,1:33),pt11_imag(1).Imag_Z(2,1:33),'LineWidth',8)
title('Multi Sine, 100kHz to 200mHz')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('5mV perturbations', '10mV perturbations', '20mV perturbations')
hold off

figure
plot(pt12_real(1).Real_Z(2,1:31),pt12_imag(1).Imag_Z(2,1:31),'LineWidth',8)
hold on
plot(pt13_real(1).Real_Z(2,1:31),pt13_imag(1).Imag_Z(2,1:31),'LineWidth',8)
title('Multi Sine, 10mV perturbations, 100kHz to 400mHz')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('with stirring', 'without stirring')
hold off


figure
plot(pt16_real(1).Real_Z(2,1:31),pt16_imag(1).Imag_Z(2,1:31), 'LineWidth',8)
hold on
plot(pt28_real(1).Real_Z(2,1:31),pt28_imag(1).Imag_Z(2,1:31),'LineWidth',8)
title('Multi Sine, 80kHz to 300mHz')
xlabel('Real_Z (Ohm)')
ylabel('NegImag_Z (Ohm)')
legend('10mV perturbations', '15mV perturbations')
hold off
