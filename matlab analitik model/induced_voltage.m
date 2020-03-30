syms teta t r
time=0:1e-5:10e-3; %Time 
n=2000; %RPM
pole=16;    %Number of poles
w=n*pole*2*pi/120;  %Electrical frequency
k_w=sin(30*pi/180)/(3*sin(10*pi/180));  %Winding factor
B_max=0.8598;   %Max of fundamental of airgap B field
N=48;    %Number of series turns

f=k_w*N*B_max*sin(w*t+pole*teta/2)*r;
g1=int(f, teta, -1823/(1000*2)+r*5188/(125*2), 1823/(1000*2)-r*5188/(125*2));
h1=int(g1, r, 25e-03, 31.215e-03);
g2=int(f, teta, -12098/(7375*2)+r*2104/(59*2), 12098/(7375*2)-r*2104/(59*2));
h2=int(g2, r, 31.215e-03, 46e-03);
v1=diff(h1);
v2=diff(h2);
l1=matlabFunction(v1);
l2=matlabFunction(v2);
m1=feval(l1,time);
m2=feval(l2,time);

figure;
hold all
plot(time+0.00094,m1+m2,'LineWidth',2);
plot(Timems/1000,InducedVoltagePhaseA,'LineWidth',2);
xlim([0.00094 0.0075]);
xlabel('Time (s)');
xlabel('Time (s)');
grid on
legend('Analytical Result','FEA Result');
