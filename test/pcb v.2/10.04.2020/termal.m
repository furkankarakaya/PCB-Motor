%% PCB winding temperature measurement curve-fitting

t=linspace(0,300,31);

concentric1=[19.3 26 30 33.4 35.5 38.3 38.3 38.8 39.4 39.3 40.8 40.7 40.6 41.5 41.4 41.6 41.2 41.9 42 42.2 41.5 42.1 42.8 42.3 42.2 42.9 42.2 43.5 43.5 42.9 43.5 ];
arc1=[ 19.3 25.2 29 31.4 33 33.6 34.8 34.8 35.4 35.2 35.7 36.4 36.4 36.3 36.7 36.5 36.6 36.6 36.3 36 36.4 36.1 36.5 36.5 35.9 35.9 35.9 35.8 35.8 36 35.9];
uew1=[ 19.3 21.6  25.4 27.8 29.1 30.1 30.6 29.3 31.4 31.7 31.2 30.7 31.7 31 31.9 31.7 32.2 31.8 31.9 32.7 32 32 32.3 32.1 32.4 32.3 33.1 33 32.3 33 32 ];
parallel1=[ 19.3 24.3 28.1 28.9 30.9 31.9 32.4 32.3 32.9 32.5 32.9 33.3 33.2 33.1 32.9 33 33.4 33.5 33.4 33.5 33.6 33.1 33.2 33.1 32.9 32.8 32.7 32.9 32.4 32.6 31.9 ];
radial1=[ 19.3 24 26.5 28.9 29.9 31.3 31.7 32.5 32.4 32.9 32.4 32.4 32.9 33.2 33.3 33.5 33.3 33.6 33.4 34.5 34.9 33.9 34 34.8 34.3 34.7 34.9 35.1 35.1 34.9 35.5 ];

concentric=[19.3 26 30 33.4 35.5 37.6 38.3 38.8 39.4 39.9 40.3 40.7 40.9 41.2 41.4 41.6 41.8 41.9 42 42.2 42.3 42.5 42.6 42.8 42.9 42.9 42.9 43.1 43.2 43.5 43.5 ];
uew=[ 19.3 21.6  25.4 27.8 29.1 30.1 30.6 31 31.4 31.5 31.6 31.7 31.7 31.8 31.9 32 32 32.3 32.4 32.4 32.5 32.6 32.6 32.7 32.8 32.9 33 33 33 33 33 ];
arc=[ 19.3 25.2 29 31.4 33 34 34.8 35 35.2 35.5 35.7 36.0 36.4 36.6 36.7 36.8 36.9 37 37 37 37.1 37.1 37.2 37.2 37.2 37.2 37.2 37.2 37.2 37.2 37.2];
radial=[ 19.3 24.5 28.3 30.5 31.4 32.5 32.9 33.3 33.4 33.7 33.9 33.9 34 34.2 34.3 34.5 34.5 34.6 34.6 34.8 34.9 34.9 34.8 34.8 34.8 34.8 34.9 35.1 35.1 35 35 ];
parallel=[ 19.3 24.3 28.1 29.9 30.9 31.9 32.4 32.5 32.7 32.7 32.9 33 33.1 33.3 33.4 33.4 33.4 33.5 33.5 33.5 33.6 33.6 33.6 33.8 33.9 33.9 33.9 34 34 34 34.1 ];

% 
% dc1=(max(C1)-min(C1));
% dc2=(max(C2)-min(C2));
% dc3=(max(C3)-min(C3));
% dc4=(max(C4)-min(C4));

% p1=polyfit(t1,C1,4);
% x1=polyval(p1,k);
% p2=polyfit(t2,C2,4);
% x2=polyval(p2,k);
% p3=polyfit(t3,C3,3);
% x3=polyval(p3,k);
set(0,'defaultLegendLocation','southeast');
figure;
hold all
plot(t,concentric,'Linewidth',4);
plot(t,arc,'Linewidth',4);
plot(t,radial,'Linewidth',4);
plot(t,parallel,'Linewidth',4);
plot(t,uew,'Linewidth',4);

set(gca,'FontSize',20);
xlabel('Time (s)','FontSize',20,'FontWeight','Bold')
ylabel('Temperature (C)','FontSize',20,'FontWeight','Bold')
title('PCB Temperature Under Full-Load');
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L1=sprintf('Concentric Winding');
L2=sprintf('ARC Winding');
L3=sprintf('Radial Winding');
L4=sprintf('Parallel Winding');
L5=sprintf('UEW Winding');
legend(L1,L2,L3,L4,L5);
%%
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
% set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');
set(0,'defaultFigurePaperPositionMode','auto');
% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');
figure;
hold all;
plot(t,concentric,'Linewidth',4);
plot(t,arc,'Linewidth',4);
plot(t,radial,'Linewidth',4);
plot(t,parallel,'Linewidth',4);
% plot(t,uew,'Linewidth',4);
xlabel('Time (s)','FontSize',40,'FontWeight','Bold')
ylabel('Temperature (C)','FontSize',40,'FontWeight','Bold')
% title('Radial Winding Induced Voltage FFT Result - 2000 RPM ');
% L1=sprintf('Analytical Results: Fundamental = %.3f V ',max(an_mag_rad));
% L2=sprintf('FEA Results: Fundamental = %.3f V ',max(magInducedVoltagePhaseA));
% L3=sprintf('Test Results: Fundamental = %.3f V ',max(test_rad_fft));
% legend(L1,L2,L3);
L1=sprintf('Concentric Winding');
L2=sprintf('ARC Winding');
L3=sprintf('Radial Winding');
L4=sprintf('Parallel Winding');
% L5=sprintf('UEW Winding');
legend(L1,L2,L3,L4);
grid on
% xlim([0.6 3.5]);
% ylim([0 9]);
%%
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
% set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');
set(0,'defaultFigurePaperPositionMode','auto');
% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');
figure;
hold all;
plot((time_con+5e-03)*1000,con,'Linewidth',4);
plot((time_rad+10e-03-1.25e-03)*1000,rad,'Linewidth',4);
plot((time_arc+5e-03-0.59e-03)*1000,-arc,'Linewidth',4);
plot((time_par+5e-03-0.61e-03)*1000,-par,'Linewidth',4);
% plot(t,uew,'Linewidth',4);
xlabel('Time (ms)','FontSize',40,'FontWeight','Bold')
ylabel('Voltage (V)','FontSize',40,'FontWeight','Bold')
% title('Radial Winding Induced Voltage FFT Result - 2000 RPM ');
% L1=sprintf('Analytical Results: Fundamental = %.3f V ',max(an_mag_rad));
% L2=sprintf('FEA Results: Fundamental = %.3f V ',max(magInducedVoltagePhaseA));
% L3=sprintf('Test Results: Fundamental = %.3f V ',max(test_rad_fft));
% legend(L1,L2,L3);
% L1=sprintf('Concentric Winding');
% L2=sprintf('Radial Winding');
% L3=sprintf('Arc Winding');
% L4=sprintf('Parallel Winding');
% L5=sprintf('UEW Winding');
% legend(L1,L2,L3,L4);
grid on
xlim([0 3.78]);
ylim([-10 10]);
%%
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
% set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');
set(0,'defaultFigurePaperPositionMode','auto');
% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');
figure;
hold all;
plot(Distancemm,Bz_1,'Linewidth',4);
% plot(t,uew,'Linewidth',4);
xlabel('Radius (mm)','FontSize',40,'FontWeight','Bold')
ylabel('Flux Density (T)','FontSize',40,'FontWeight','Bold')
% title('Radial Winding Induced Voltage FFT Result - 2000 RPM ');
% L1=sprintf('Analytical Results: Fundamental = %.3f V ',max(an_mag_rad));
% L2=sprintf('FEA Results: Fundamental = %.3f V ',max(magInducedVoltagePhaseA));
% L3=sprintf('Test Results: Fundamental = %.3f V ',max(test_rad_fft));
% legend(L1,L2,L3);
% L1=sprintf('Concentric Winding');
% L2=sprintf('Radial Winding');
% L3=sprintf('Arc Winding');
% L4=sprintf('Parallel Winding');
% L5=sprintf('UEW Winding');
% legend(L1,L2,L3,L4);
grid on
xlim([25 46]);
ylim([0.3 0.8]);