load('concentric.mat');

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
%%

k_scaling = 4;          % scaling factor of the figure
% (You need to plot a figure which has a width of (8.8 * k_scaling)
% in MATLAB, so that when you paste it into your paper, the width will be
% scalled down to 8.8 cm  which can guarantee a preferred clearness.
k_width_hight = 2;      % width:hight ratio of the figure

width = 8.8 * k_scaling;
hight = width / k_width_hight;

%figure margins
top = 0.5;  % normalized top margin
bottom = 3;	% normalized bottom margin
left = 3.5;	% normalized left margin
right = 1;  % normalized right margin

% set default figure configurations
set(0,'defaultFigureUnits','centimeters');
set(0,'defaultFigurePosition',[0 0 width hight]);

set(0,'defaultLineLineWidth',1*k_scaling);
set(0,'defaultAxesLineWidth',0.25*k_scaling);

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
set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');

figure;
hold all;
plot(time_2000,phase_a_2000,'-r','Linewidth',2);
plot(time_2000,phase_b_2000,'-g','Linewidth',2);
plot(time_2000,phase_c_2000,'-b','Linewidth',2);
set(gca,'FontSize',40);
xlabel('Time (ms)','FontSize',40,'FontWeight','Bold')
ylabel('Voltage (V)','FontSize',40,'FontWeight','Bold')
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L10=sprintf('Va = %.3f Vrms ',rms(phase_a_2000));
L11=sprintf('Vb = %.3f Vrms ',rms(phase_a_2000));
L12=sprintf('Vc = %.3f Vrms ',rms(phase_a_2000));
legend(L10,L11,L12);
% title('Concentric Winding Induced Voltage - 2000 RPM ');

