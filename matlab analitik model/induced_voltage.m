syms teta t r
time=0:1e-5:10e-3; %Time 
n=2000; %RPM
pole=16;    %Number of poles
w=n*pole*2*pi/120;  %Electrical frequency
k_w=sin(90*pi/180)*sin(30*pi/180)/(3*sin(10*pi/180));  %Winding factor
k_w3=sin(90*3*pi/180)*sin(3*30*pi/180)/(3*sin(3*10*pi/180));
k_w7=sin(90*7*pi/180)*sin(7*30*pi/180)/(3*sin(7*10*pi/180));
k_w9=sin(90*9*pi/180)*sin(9*30*pi/180)/(3*sin(9*10*pi/180));
B_max=0.8598;   %Max of fundamental of airgap B field
B3_max=-0.1133;   %Max of fundamental of airgap B field
B7_max=0.0133;
B9_max=-0.0085;
N=48;    %Number of series turns

f=k_w*N*B_max*sin(w*t+pole*teta/2)*r;
g1=int(f, teta, -1823/(1000*2)+r*5188/(125*2) , 1823/(1000*2)-r*5188/(125*2));
h1=int(g1, r, 25e-03, 31.215e-03);
g2=int(f, teta, -12098/(7375*2)+r*2104/(59*2) , 12098/(7375*2)-r*2104/(59*2));
h2=int(g2, r, 31.215e-03, 46e-03);
v1=diff(h1);
v2=diff(h2);
l1=matlabFunction(v1);
l2=matlabFunction(v2);
m1=feval(l1,time);
m2=feval(l2,time);

f3=k_w*N*B3_max*sin(-3*w*t+3*pole*teta/2)*r;
g13=int(f3, teta, -1823/(1000*2)+r*5188/(125*2) , 1823/(1000*2)-r*5188/(125*2));
h13=int(g13, r, 25e-03, 31.215e-03);
g23=int(f3, teta, -12098/(7375*2)+r*2104/(59*2) , 12098/(7375*2)-r*2104/(59*2));
h23=int(g23, r, 31.215e-03, 46e-03);
v13=diff(h13);
v23=diff(h23);
l13=matlabFunction(v13);
l23=matlabFunction(v23);
m13=feval(l13,time);
m23=feval(l23,time);

f7=k_w*N*B7_max*sin(-7*w*t+7*pole*teta/2)*r;
g17=int(f7, teta, -1823/(1000*2)+r*5188/(125*2) , 1823/(1000*2)-r*5188/(125*2));
h17=int(g17, r, 25e-03, 31.215e-03);
g27=int(f7, teta, -12098/(7375*2)+r*2104/(59*2) , 12098/(7375*2)-r*2104/(59*2));
h27=int(g27, r, 31.215e-03, 46e-03);
v17=diff(h17);
v27=diff(h27);
l17=matlabFunction(v17);
l27=matlabFunction(v27);
m17=feval(l17,time);
m27=feval(l27,time);


f9=k_w*N*B9_max*sin(9*w*t+9*pole*teta/2)*r;
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

figure;
hold all
plot(time-9.25e-04,(m1+m2+m13+m23+m17+m27+m19+m29)*0.85,'LineWidth',2);
plot(Timems/1000,-InducedVoltagePhaseA,'LineWidth',2);
xlim([0.00094 0.0075]);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Parallel Winding Induced Phase Voltage Comparison');
grid on
legend('Analytical Result','FEA Result');

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


