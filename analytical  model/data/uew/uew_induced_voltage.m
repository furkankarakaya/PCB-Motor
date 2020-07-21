syms teta t r
time=0:1e-5:10e-3; %Time 
n=2000; %RPM
pole=16;    %Number of poles
w=n*pole*2*pi/120;  %Electrical frequency
k_w=sin(90*pi/180)*sin(30*pi/180)/(3*sin(10*pi/180));  %Winding factor
k_w3=sin(90*3*pi/180)*sin(3*30*pi/180)/(3*sin(3*10*pi/180));
k_w7=sin(90*7*pi/180)*sin(7*30*pi/180)/(3*sin(7*10*pi/180));
k_w9=sin(90*9*pi/180)*sin(9*30*pi/180)/(3*sin(9*10*pi/180));
B_max=0.8325;   %Max of fundamental of airgap B field
B3_max=-0.1104;   %Max of fundamental of airgap B field
B7_max=0.0130;
B9_max=-0.0083;
N=48;    %Number of series turns
r_fac=1.098*sin(103*r-2.093)+0.1324*sin(436.6*r+1.804)+1.566*sin(904.4*r+4.041)+1.587*sin(898.3*r+1.116);

J_mag_A=2/(0.8*0.07e-06);
% J_A=J_mag_A*1754/2480*(cos(teta)-sin(teta));
f_A=r_fac*0.53*J_mag_A*(288*25.053*0.8*0.07e-09)*cos((30.55)*pi/180);
% F_A=int(f_A, teta, 0, 22.5*pi/180);
T_A=int(f_A, r, 25e-03, 46e-03);
tA=matlabFunction(T_A);
Torque_A=feval(tA);

% J_mag_A=2*sqrt(2)*cos(w*t)/(0.8*0.07e-06);
% J_A=J_mag_A*1754/2480*(cos(teta)-sin(teta));
% f_A=r_fac*B_max*sin(w*t+pole*teta/2)*J_A*(96*25.053*0.8*0.07e-09);
% F_A=int(f_A, teta, 0, 22.5*pi/180);
% T_A=int(F_A, r, 25e-03, 46e-03);
% tA=matlabFunction(T_A);
% Torque_A=feval(tA,time);
% 
% J_mag_B=2*sqrt(2)*cos(w*t+120*pi/180)/(0.8*0.07e-06);
% J_B=J_mag_B*1754/2480*(cos(teta)-sin(teta));
% f_B=r_fac*B_max*sin(w*t+pole*teta/2)*J_B*(96*25.053*0.8*0.07e-09);
% F_B=int(f_B, teta, 120*pi/180, 144.5*pi/180);
% T_B=int(F_B, r, 25e-03, 46e-03);
% tB=matlabFunction(T_B);
% Torque_B=feval(tB,time);
% Torque=Torque_A+Torque_B;
% Torque=0.53*J*cos((30.55)*pi/180)*(288*25.053*0.8*0.07e-09)*(46+25)*0.5e-03;

f=0.89*r_fac*k_w*N*B_max*sin(w*t+pole*teta/2)*r;
g1=int(f, teta, -5661/(3100*2)+r*1291/(31*2) , 5661/(3100*2)-r*1291/(31*2));
h1=int(g1, r, 25e-03, 31.215e-03);
g2=int(f, teta, -30291/(18500*2)+r*1317/(37*2) , 30291/(18500*2)-r*1317/(37*2));
h2=int(g2, r, 31.215e-03, 46e-03);
v1=diff(h1);
v2=diff(h2);
l1=matlabFunction(v1);
l2=matlabFunction(v2);
m1=feval(l1,time);
m2=feval(l2,time);

f3=1.82*r_fac*k_w3*N*B3_max*sin(3*w*t+3*pole*teta/2)*r;
g13=int(f3, teta, -5661/(3100*2)+r*1291/(31*2) , 5661/(3100*2)-r*1291/(31*2));
h13=int(g13, r, 25e-03, 31.215e-03);
g23=int(f3, teta, -30291/(18500*2)+r*1317/(37*2) , 30291/(18500*2)-r*1317/(37*2));
h23=int(g23, r, 31.215e-03, 46e-03);
v13=diff(h13);
v23=diff(h23);
l13=matlabFunction(v13);
l23=matlabFunction(v23);
m13=feval(l13,time);
m23=feval(l23,time);

f7=r_fac*k_w7*N*B7_max*sin(-7*w*t+7*pole*teta/2)*r;
g17=int(f7, teta, -5661/(3100*2)+r*1291/(31*2) , 5661/(3100*2)-r*1291/(31*2));
h17=int(g17, r, 25e-03, 31.215e-03);
g27=int(f7, teta, -30291/(18500*2)+r*1317/(37*2) , 30291/(18500*2)-r*1317/(37*2));
h27=int(g27, r, 31.215e-03, 46e-03);
v17=diff(h17);
v27=diff(h27);
l17=matlabFunction(v17);
l27=matlabFunction(v27);
m17=feval(l17,time);
m27=feval(l27,time);


f9=r_fac*k_w9*N*B9_max*sin(9*w*t+9*pole*teta/2)*r;
g19=int(f9, teta, -1823/(1000*2)+r*5188/(125*2) , 1823/(1000*2)-r*5188/(125*2));
h19=int(g19, r, 25e-03, 31.215e-03);
g29=int(f9, teta, -12098/(7375*2)+r*2104/(59*2) , 12098/(7375*2)-r*2104/(59*2));
h29=int(g29, r, 31.215e-03, 46e-03);
v19=diff(h19);
v29=diff(h29);
l19=matlabFunction(v19);
l29=matlabFunction(v29);
m19=feval(l19,time);
m29=feval(l29,time);

load('parallel.mat');
figure;
hold all
plot(time-9.25e-04,(m1+m2+m13+m23+m17+m27+m19+m29),'LineWidth',2);
plot(Timems/1000,-InducedVoltagePhaseA,'LineWidth',2);
xlim([0.00094 0.0075]);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Parallel Winding Induced Phase Voltage Comparison');
grid on
legend('Analytical Result','FEA Result');
%%
an_fr_par=[0 1 2 3 4 5 6 7 8 9];
an_mag_par=[0 max(m1+m2) 0 max(m13+m23) 0 0 0 max(m17+m27) 0 max(m19+m29)];
an_vol_par=m1+m2+m13+m23+m17+m27+m19+m29;

freq=transpose(linspace(0,374,375));
an_mag_par=[an_mag_par, zeros(1, length(test_uew_fft) - length(an_mag_par))];
an_fr_par=[an_fr_par, zeros(1, length(test_uew_freq) - length(an_fr_par))];
%%
an_mag_par=[an_mag_par, zeros(1, length(test_uew_fft) - length(an_mag_par))];
k_scaling = 4;          % scaling factor of the figure
k_width_hight = 2;      % width:hight ratio of the figure
width = 8.8 * k_scaling;
hight = width / k_width_hight;
% figure margins
top = 0.5;  % normalized top margin
bottom = 3;	% normalized bottom margin
left = 3.5;	% normalized left margin
right = 1;  % normalized right margin
% set default figure configurations
set(0,'defaultFigureUnits','centimeters');
set(0,'defaultFigurePosition',[0 0 width hight]);
set(0,'defaultLineLineWidth',1*k_scaling);
set(0,'defaultAxesLineWidth',0.1*k_scaling);
set(0,'defaultLineMarkerSize',3.1*k_scaling);
set(0,'defaultAxesGridLineStyle',':');
set(0,'defaultAxesYGrid','on');
set(0,'defaultAxesXGrid','on');
set(0,'defaultAxesFontName','Times New Roman');
set(0,'defaultAxesFontSize',8*k_scaling);
set(0,'defaultTextFontName','Times New Roman');
set(0,'defaultTextFontSize',8*k_scaling);
set(0,'defaultLegendFontName','Times New Roman');
set(0,'defaultLegendFontSize',8*k_scaling);
set(0,'defaultAxesUnits','normalized');
set(0,'defaultAxesPosition',[left/width bottom/hight (width-left-right)/width  (hight-bottom-top)/hight]);
set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');
set(0,'defaultFigurePaperPositionMode','auto');
% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','northeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');
figure;
hold all;
freq=transpose(linspace(0,374,375));
x=[freq(1:51) freq(1:51) freq(1:51)];
y=[transpose(an_mag_par(1:51)) magInducedVoltagePhaseA test_uew_fft(1:51) ];
bar(x,y);
xlabel('Harmonic Order','FontSize',40,'FontWeight','Bold')
ylabel('Induced Voltage (V)','FontSize',40,'FontWeight','Bold')
% title('Radial Winding Induced Voltage FFT Result - 2000 RPM ');
% L1=sprintf('Analytical Results: Fundamental = %.3f V ',max(an_mag_rad));
% L2=sprintf('FEA Results: Fundamental = %.3f V ',max(magInducedVoltagePhaseA));
% L3=sprintf('Test Results: Fundamental = %.3f V ',max(test_rad_fft));
% legend(L1,L2,L3);
legend('Analytical Result','FEA Result','Test Result');
grid on
xlim([0.6 3.5]);
ylim([0 9]);
xticks([1 2 3]);
yticks([0 3 6 9]);
%%
plot(time_1500*1000-1.265,phase_a_2000);
xlim([0 3.75]);
ylim([-10 10]);
xlabel(' Time (ms)');
ylabel(' Voltage (V)');
% figure;
% hold all
% plot(time,m1+m2,'LineWidth',2);
% plot(time,m13+m23,'LineWidth',2);
% plot(time,m15+m25,'LineWidth',2);
% plot(time,m19+m29,'LineWidth',2);
% xlim([0.00094 0.0075]);
% xlabel('Time (s)');
% xlabel('Time (s)');
% grid on
% deneme=[1 3 7 9];
% deneme2=[max(m1+m2) max(m13+m23) max(m15+m25) max(m19+m29)];
% x=[FreqkHz./FreqkHz(2) deneme];
% y=[magInducedVoltagePhaseA ];
% bar(FreqkHz./FreqkHz(2),magInducedVoltagePhaseA);


