%% PCB winding temperature measurement curve-fitting

t=0:5:180;

arc=[ 22 27.7 32.8 36.7 41 44.6 48.2 51 54.3 57 59.8 62 64.4 66.7 68.3 70.1 72 73.7 75 76.4 77.8 79.1 80.4 81.1 82.1 83.1 84.1 84.5 85 85.4 85.7 86.3 86.6 87.2 87.5 87.6 87.6];
uew=[22 26.4 30 33 36.1 38.8 41.1 43.7 45.4 47.6 49.5 51.4 53 54.5 55.9 57.5 58.5 59.9 60.6 61.8 62.6 63.8 65.5 66.3 67.5 68.1 68.8 69.5 70 70.1 70.2 70.5 71.3 71.4 71.3 71.8 72.2];
concentric=[22 29 34.3 39.5 44.1 47.8 53 57.5 61.1 64.3 68 71.5 74.5 76.9 79.8 82.2 84.6 88.3 90.3 91.8 93 94.3 95.5 96.5 97.1 97.6 98.5 99.3 100 101 101 101 101 101 101 102 102];
parallel=[22 25.6 30.6 34.6 42.6 45.8 48.7 51.5 53.7 56.6 58.3 60.3 62.3 64.4 66.3 67.6 68.8 70.5 72.1 73.2 74.1 75.1 76.6 77.4 78.1 79 79.4 80 80.8 81.1 82.1 82.4 83.1 83.6 84 84.1 84.2 ];
radial=[22 26 32.4 36.1 39.8 43.6 47.9 51 53.9 56.7 59.3 61.8 63.8 66.1 67.7 69.5 70.6 72 73.1 74.1 75.3 76.3 76.7 77.1 77.6 78.1 78.6 79.2 80 80.5 81 81.1 82 82.4 83 83.5 83.8];
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
