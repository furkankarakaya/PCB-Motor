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
% r_fac=1.126*sin(109.1*r-2.307)+0.1531*sin(393.6*r+3.331)+3.694*sin(1128*r-3.911)+0.06233*sin(868.6*r+2.164)+3.658*sin(1130*r+5.446);
% r_fac=0.8064*sin(56.28*r-0.4332)+32.64*sin(292.1*r+6.905)+0.06193*sin(1071*r-1.849)+0.05559*sin(864.1*r+2.337)+0.03164*sin(1240*r+1.559)+32.81*sin(290.7*r-2.469);
% r_fac=1.144*sin(107.6*r-2.254)+3.138*sin(505.8*r-0.6347)+0.05396*sin(1079*r-2.151)+0.0476*sin(866.4*r+2.249)+0.02959*sin(1272*r+0.423)+0.0523*sin(206.5*r-2.584)+3.026*sin(509.3*r+2.383);
% r_fac=0.7602-0.1038*cos(r*228.2)+0.3851*sin(r*228.2)+0.2116*cos(r*228.2*2)+0.1121*sin(r*228.2*2)+0.06348*cos(r*228.2*3)-0.07286*sin(r*228.2*3);
% r_fac=1.137*exp(-((r-0.03557)/0.01142)^2);
r_fac=(-4.615e07)*r^4+(6.565e06)*r^3+(-3.484e05)*r^2+(8175)*r^1-70.57;
J=2/(0.8*0.07e-06);
% Torque=avg_BI*J*sin((45-11.25)*pi/180)*(288*25.053*0.8*0.07e-09)*(46+25)*0.5e-03;

f=r_fac*k_w*N*B_max*sin(w*t+pole*teta/2)*r;
g1=int(f, teta, -2081/(1600*2)+r*165/(8*2) , 2081/(1600*2)-r*165/(8*2));
h1=int(g1, r, 25e-03, 33e-03);
g2=int(f, teta, -1603/(900*2)+r*950/(27*2) , 1603/(900*2)-r*950/(27*2));
h2=int(g2, r, 33e-03, 38.382e-03);
g3=int(f, teta, -9443/(4100*2)+r*2000/(41*2) , 9443/(4100*2)-r*2000/(41*2));
h3=int(g3, r, 38.382e-03, 42.507e-03);
g4=int(f, teta, -529/(175*2)+r*460/(7*2) , 529/(175*2)-r*460/(7*2));
h4=int(g4, r, 42.507e-03, 46e-03);
v1=diff(h1);
v2=diff(h2);
v3=diff(h3);
v4=diff(h4);
l1=matlabFunction(v1);
l2=matlabFunction(v2);
l3=matlabFunction(v3);
l4=matlabFunction(v4);
m1=feval(l1,time);
m2=feval(l2,time);
m3=feval(l3,time);
m4=feval(l4,time);

f3=r_fac*k_w3*N*B3_max*sin(3*w*t+3*pole*teta/2)*r;
g13=int(f3, teta, -2081/(1600*2)+r*165/(8*2) , 2081/(1600*2)-r*165/(8*2));
h13=int(g13, r, 25e-03, 33e-03);
g23=int(f3, teta, -1603/(900*2)+r*950/(27*2) , 1603/(900*2)-r*950/(27*2));
h23=int(g23, r, 33e-03, 38.382e-03);
g33=int(f3, teta, -9443/(4100*2)+r*2000/(41*2) , 9443/(4100*2)-r*2000/(41*2));
h33=int(g33, r, 38.382e-03, 42.507e-03);
g43=int(f3, teta, -529/(175*2)+r*460/(7*2) , 529/(175*2)-r*460/(7*2));
h43=int(g43, r, 42.507e-03, 46e-03);
v13=diff(h13);
v23=diff(h23);
v33=diff(h33);
v43=diff(h43);
l13=matlabFunction(v13);
l23=matlabFunction(v23);
l33=matlabFunction(v33);
l43=matlabFunction(v43);
m13=feval(l13,time);
m23=feval(l23,time);
m33=feval(l33,time);
m43=feval(l43,time);
% 

f7=r_fac*k_w7*N*B7_max*sin(7*w*t+7*pole*teta/2)*r;
g17=int(f7, teta, -2081/(1600*2)+r*165/(8*2) , 2081/(1600*2)-r*165/(8*2));
h17=int(g17, r, 25e-03, 33e-03);
g27=int(f7, teta, -1603/(900*2)+r*950/(27*2) , 1603/(900*2)-r*950/(27*2));
h27=int(g27, r, 33e-03, 38.382e-03);
g37=int(f7, teta, -9443/(4100*2)+r*2000/(41*2) , 9443/(4100*2)-r*2000/(41*2));
h37=int(g37, r, 38.382e-03, 42.507e-03);
g47=int(f7, teta, -529/(175*2)+r*460/(7*2) , 529/(175*2)-r*460/(7*2));
h47=int(g47, r, 42.507e-03, 46e-03);
v17=diff(h17);
v27=diff(h27);
v37=diff(h37);
v47=diff(h47);
l17=matlabFunction(v17);
l27=matlabFunction(v27);
l37=matlabFunction(v37);
l47=matlabFunction(v47);
m17=feval(l17,time);
m27=feval(l27,time);
m37=feval(l37,time);
m47=feval(l47,time);
% 
f9=r_fac*k_w9*N*B9_max*sin(9*w*t+9*pole*teta/2)*r;
g19=int(f9, teta, -2081/(1600*2)+r*165/(8*2) , 2081/(1600*2)-r*165/(8*2));
h19=int(g19, r, 25e-03, 33e-03);
g29=int(f9, teta, -1603/(900*2)+r*950/(27*2) , 1603/(900*2)-r*950/(27*2));
h29=int(g29, r, 33e-03, 38.382e-03);
g39=int(f9, teta, -9443/(4100*2)+r*2000/(41*2) , 9443/(4100*2)-r*2000/(41*2));
h39=int(g39, r, 38.382e-03, 42.507e-03);
g49=int(f9, teta, -529/(175*2)+r*460/(7*2) , 529/(175*2)-r*460/(7*2));
h49=int(g49, r, 42.507e-03, 46e-03);
v19=diff(h19);
v29=diff(h29);
v39=diff(h39);
v49=diff(h49);
l19=matlabFunction(v19);
l29=matlabFunction(v29);
l39=matlabFunction(v39);
l49=matlabFunction(v49);
m19=feval(l19,time);
m29=feval(l29,time);
m39=feval(l39,time);
m49=feval(l49,time);

load('max_arc_voltage.mat');
figure;
hold all
plot(time-9.25e-04,(m1+m2+m3+m4+m13+m23+m33+m43+m17+m27+m37+m47+m19+m29+m39+m49),'LineWidth',2);
plot(Timems/1000,-InducedVoltagePhaseA,'LineWidth',2);
xlim([0.00094 0.0075]);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('ARC Winding Induced Phase Voltage Comparison');
grid on
L1=sprintf('Analytical Results: Vrms = %.3f V ',rms(m1+m2+m3+m4+m13+m23+m33+m43));
L2=sprintf('FEA results: Vrms = %.3f V ',rms(InducedVoltagePhaseA));
legend(L1,L2);

% an_fr_arc=[1 3 7 9];
% an_mag_arc=[max(m1+m2+m3+m4) max(m13+m23+m33+m43) max(m17+m27+m37+m47) max(m19+m29+m39+m49)];
% an_vol_arc=m1+m2+m3+m4+m13+m23+m33+m43+m17+m27+m37+m47+m19+m29+m39+m49;


% legend('Analytical Result','FEA Result');

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


