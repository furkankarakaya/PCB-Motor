load('concentric.mat');

figure;
hold all;
plot(time_500,phase_a_500,'Linewidth',1);
plot(time_500,phase_b_500,'Linewidth',1);
plot(time_500,phase_c_500,'Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Voltage (V)','FontSize',14,'FontWeight','Bold')
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L1=sprintf('Va = %.3f Vrms ',rms(phase_a_500));
L2=sprintf('Vb = %.3f Vrms ',rms(phase_a_500));
L3=sprintf('Vc = %.3f Vrms ',rms(phase_a_500));
legend(L1,L2,L3);
title('Concentric Winding Induced Voltage - 500 RPM ');

figure;
hold all;
plot(time_1000,phase_a_1000,'Linewidth',1);
plot(time_1000,phase_b_1000,'Linewidth',1);
plot(time_1000,phase_c_1000,'Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Voltage (V)','FontSize',14,'FontWeight','Bold')
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L4=sprintf('Va = %.3f Vrms ',rms(phase_a_1000));
L5=sprintf('Vb = %.3f Vrms ',rms(phase_a_1000));
L6=sprintf('Vc = %.3f Vrms ',rms(phase_a_1000));
legend(L4,L5,L6);
title('Concentric Winding Induced Voltage - 1000 RPM ');

figure;
hold all;
plot(time_1500,phase_a_1500,'Linewidth',1);
plot(time_1500,phase_b_1500,'Linewidth',1);
plot(time_1500,phase_c_1500,'Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Voltage (V)','FontSize',14,'FontWeight','Bold')
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L7=sprintf('Va = %.3f Vrms ',rms(phase_a_1500));
L8=sprintf('Vb = %.3f Vrms ',rms(phase_a_1500));
L9=sprintf('Vc = %.3f Vrms ',rms(phase_a_1500));
legend(L7,L8,L9);
title('Concentric Winding Induced Voltage - 1500 RPM ');

figure;
hold all;
plot(time_2000,phase_a_2000,'Linewidth',1);
plot(time_2000,phase_b_2000,'Linewidth',1);
plot(time_2000,phase_c_2000,'Linewidth',1);
set(gca,'FontSize',14);
xlabel('Time (ms)','FontSize',14,'FontWeight','Bold')
ylabel('Voltage (V)','FontSize',14,'FontWeight','Bold')
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L10=sprintf('Va = %.3f Vrms ',rms(phase_a_2000));
L11=sprintf('Vb = %.3f Vrms ',rms(phase_a_2000));
L12=sprintf('Vc = %.3f Vrms ',rms(phase_a_2000));
legend(L10,L11,L12);
title('Concentric Winding Induced Voltage - 2000 RPM ');

