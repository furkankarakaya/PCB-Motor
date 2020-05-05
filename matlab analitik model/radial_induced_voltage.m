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

% Torque=avg_BI*J*sin((45-11.25)*pi/180)*(288*25.053*0.8*0.07e-09)*(46+25)*0.5e-03;

f=r_fac*k_w*N*B_max*sin(w*t+pole*teta/2)*r;
g1=int(f, teta, -330643/(170000*2)+r*1577/(34*2) , 330643/(170000*2)-r*1577/(34*2));
h1=int(g1, r, 25e-03, 31.817e-03);
g2=int(f, teta, -26.95*pi/360 , 26.95*pi/360);
h2=int(g2, r, 31.817e-03, 39.416e-03);
g3=int(f, teta, -1081/(330*2)+r*2350/(33*2) , 1081/(330*2)-r*2350/(33*2));
h3=int(g3, r, 39.416e-03, 46e-03);
v1=diff(h1);
v2=diff(h2);
v3=diff(h3);
l1=matlabFunction(v1);
l2=matlabFunction(v2);
l3=matlabFunction(v3);
m1=feval(l1,time);
m2=feval(l2,time);
m3=feval(l3,time);

f3=r_fac*k_w3*N*B3_max*sin(3*w*t+3*pole*teta/2)*r;
g13=int(f3, teta, -330643/(170000*2)+r*1577/(34*2) , 330643/(170000*2)-r*1577/(34*2));
h13=int(g13, r, 25e-03, 31.817e-03);
g23=int(f3, teta, -26.95*pi/360 , 26.95*pi/360);
h23=int(g23, r, 31.817e-03, 39.416e-03);
g33=int(f3, teta, -1081/(330*2)+r*2350/(33*2) , 1081/(330*2)-r*2350/(33*2));
h33=int(g33, r, 39.416e-03, 46e-03);
v13=diff(h13);
v23=diff(h23);
v33=diff(h33);
l13=matlabFunction(v13);
l23=matlabFunction(v23);
l33=matlabFunction(v33);
m13=feval(l13,time);
m23=feval(l23,time);
m33=feval(l33,time);

f7=r_fac*k_w7*N*B7_max*sin(7*w*t+7*pole*teta/2)*r;
g17=int(f7, teta, -330643/(170000*2)+r*1577/(34*2) , 330643/(170000*2)-r*1577/(34*2));
h17=int(g17, r, 25e-03, 31.817e-03);
g27=int(f7, teta, -26.95*pi/360 , 26.95*pi/360);
h27=int(g27, r, 31.817e-03, 39.416e-03);
g37=int(f7, teta, -1081/(330*2)+r*2350/(33*2) , 1081/(330*2)-r*2350/(33*2));
h37=int(g37, r, 39.416e-03, 46e-03);
v17=diff(h17);
v27=diff(h27);
v37=diff(h37);
l17=matlabFunction(v17);
l27=matlabFunction(v27);
l37=matlabFunction(v37);
m17=feval(l17,time);
m27=feval(l27,time);
m37=feval(l37,time);


f9=r_fac*k_w*N*B9_max*sin(9*w*t+9*pole*teta/2)*r;
g19=int(f9, teta, -330643/(170000*2)+r*1577/(34*2) , 330643/(170000*2)-r*1577/(34*2));
h19=int(g19, r, 25e-03, 31.817e-03);
g29=int(f9, teta, -26.95*pi/360 , 26.95*pi/360);
h29=int(g29, r, 31.817e-03, 39.416e-03);
g39=int(f9, teta, -1081/(330*2)+r*2350/(33*2) , 1081/(330*2)-r*2350/(33*2));
h39=int(g39, r, 39.416e-03, 46e-03);
v19=diff(h19);
v29=diff(h29);
v39=diff(h39);
l19=matlabFunction(v19);
l29=matlabFunction(v29);
l39=matlabFunction(v39);
m19=feval(l19,time);
m29=feval(l29,time);
m39=feval(l39,time);


load('radial.mat');
figure;
hold all
plot(time-9.25e-04,(m19+m29+m39+m17+m27+m37+m13+m23+m33+m1+m2+m3),'LineWidth',2);
plot(Timems/1000,-InducedVoltagePhaseA,'LineWidth',2);
xlim([0.00094 0.0075]);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Radial Winding Induced Phase Voltage Comparison');
grid on
L1=sprintf('Analytical Result Vrms=%.2f V', rms(m19+m29+m39+m17+m27+m37+m13+m23+m33+m1+m2+m3));
L2=sprintf('FEA Result Vrms=%.2f V', rms(InducedVoltagePhaseA)');
legend(L1,L2);

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


