%% PCB winding temperature measurement curve-fitting

k=0:0.1:220;
t1=0:10:380; % 1.4 A
t2=0:10:180; % 2 A
t3=0:10:70; % 3 A
% t4=0:10:150; % so?uma datas?

C1=[ 25 29.8 34.3 37.8 40.6 44 46.4 47.8 48.5 51 52 53.3 54 55 56 56.6 57.2 58 58.6 60.5 61 60.5 60 58 54.5 46.8 43.7 41.1 38.5 36.4 35.5 33.8 32 30.9 30.2 29.2 28.5 28.1 27.6];
C2=[ 25 36 46 54 60.4 66.9 72.2 77 79.4 83.2 85.6 88.6 90 93.3 96 98.1 100 100.5 101 ];
C3=[ 25 51.4 72.6 92.4 105 118 125 134 ]; 
% C4= [ 58 54.5 46.8 43.7 41.1 38.5 36.4 35.5 33.8 32 30.9 30.2 29.2 28.5 28.1 27.6];

dc1=(max(C1)-min(C1));
dc2=(max(C2)-min(C2));
dc3=(max(C3)-min(C3));
dc4=(max(C4)-min(C4));

% p1=polyfit(t1,C1,4);
% x1=polyval(p1,k);
% p2=polyfit(t2,C2,4);
% x2=polyval(p2,k);
% p3=polyfit(t3,C3,3);
% x3=polyval(p3,k);

figure;
hold all
% plot(k,x1,'LineWidth',2);
% plot(k,x2,'LineWidth',2);
% plot(k,x3,'LineWidth',2);
plot(t1,C1,'LineWidth',2);
plot(t2,C2,'LineWidth',2);
plot(220,60,'*');
% plot(t3,C3,'*','LineWidth',2);
% plot(t4,C4,'LineWidth',2);

grid on
xlabel('Time (s)');
ylabel('Temperature (C)');
title('Temperature rise of PCB');
legend('1.4 A','2 A');


