Tfull1=[26 30 33.4 35.5 38.3 38.3 38.8 39.4 39.3 40.8 40.7 40.6 41.5 41.4 41.6 41.2 41.9 42 42.2 41.5 42.1 42.8 42.3 42.2 42.9 42.2 43.5 43.5 42.9 43.5 43.5 ];
Thalf=[25.8 29.9 31.9 33.1 33.5 34.3 34 34.8 34.3 34.8 34.7 36 35.2 36.1 35.2 35.7 35.8 35.6 35.7 36.1 35.5 35.5 36.1 36.4 35.5 35.6 36 35.6 35.6 36 35.6];

Tfull=[26 30 33.4 35.5 37 38.5 38.8 39.4 39.8 40.3 40.5 40.8 41.0 41.2 41.5 41.7 41.9 42 42.2 42.5 42.5 42.8 42.8 42.9 42.9 42.9 43.1 43.3 43.3 43.4 43.5 ];
Thalf=[25.8 29.9 31.9 33.1 33.5 34 34.3 34.5 34.8 34.8 34.9 35 35.2 35.4 35.5 35.7 35.8 35.9 35.9 36.1 36.1 36.2 36.2 36.4 36.4 36.4 36.5 36.5 36.5 36.5 36.5];
t=0:10:300;

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

% set(0,'defaultAxesColorOrder',[0 0 0]);
% set(0,'defaultAxesTickDir','out');

set(0,'defaultFigurePaperPositionMode','auto');

% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');
figure;
hold all
plot(t,Tfull,'-r','Linewidth',2);
plot(t,Thalf,'--b','Linewidth',2);
set(gca,'FontSize',40);
xlabel('Time (s)','FontSize',40,'FontWeight','Bold')
ylabel('Temperature (C)','FontSize',40,'FontWeight','Bold')
%  xlim([79000 81000]);
%  ylim([0 0.1]);
grid on
L1=sprintf('Full Load');
L2=sprintf('Half Load');
legend(L1,L2);
% title('Concentric Winding Temperature Characteristics ');

%  xlabel('$Time (s)$','fontsize',40,'interpreter','latex')
%  ylabel('$Temperature (^{\circ}C)$','fontsize',40,'interpreter','latex')
% % xlabel('Time (s)','FontSize',40,'FontWeight','Bold')
% % ylabel('Temperature (C)','FontSize',40,'FontWeight','Bold')
% %  xlim([79000 81000]);
% %  ylim([0 0.1]);
% grid on
% legend('$Full Load$','$Half Load$','interpreter','latex');