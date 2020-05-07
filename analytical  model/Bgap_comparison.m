clc; clear all; close all;


%% load the data

clc; clear all; close all;

filedir = 'C:\Users\DELL\Desktop\working copy\pcb motor makale\matlab plot\bfield.csv';   % file import
B_fem_table = readtable(filedir);

dist_fem = table2array(B_fem_table(:,1));  
By_FEM = table2array(B_fem_table(:,2));  


x_dist = dist_fem'; % Taking transpose
By_FEM = -By_FEM';  % Taking transpose


x_dist = resample(x_dist,2048*2,numel(x_dist)); % adjust array size to 2048 points
x_dist = x_dist(1:end/2);

By_FEM = resample(By_FEM,2048*2,numel(By_FEM)); % adjust array size to 2048 points
By_FEM = By_FEM(1:end/2);



%% analytical analysis of air gap flux density



hm     = 2e-3;  %m, magnet thickness
L      = 7e-3;  %m, distance between rotor and stator cores
pole   = 16;  %pole number
r_mean      = 35.5e-3;  %m, radius of which field is investigated


alpha_p = 0.8; % magnets are approximated to have 0.78 embrace as in LDIA
tau_p  = (2*pi*r_mean) / pole;  %m, pole pitch in circumferential direction

mur    = 1.05;
mu0    = pi*4e-7;

br25 = 1.33; %T, residual magnetism at 25C
RTC = -0.11;  % Percent/C, reversible temperature coefficient of residual induction
temp_amb = 25;  %C, ambient temp

N = 60;  %harmonics to be considered

x= linspace(-tau_p/2,1.5*tau_p,2048);    %m, circumferential length on which field is investigated for phA
y = L/2;   %m, axial distance on which field is investigated


[ ~, By_analy ] = FieldAnalysis_DSAFPM( hm, L, tau_p,...
    br25, alpha_p, mur, mu0, N, RTC, temp_amb, x_analy, y ); % field analysis using magnetic scalar potential

% field analysis assumptions: 
% - magnets are approximated as magnets having alpha_p embrace as in LDIA
% - field is calculated at mid radius, which is (rout+rin)/2



%% perform harmonics analysis using fft to compare harmonic content of air gap flux density both analytically and fem

close all;


% analytical Bgap fft
By_analy_fft = resample(By_analy,2048,numel(By_analy)); % adjust array size to 2048 points
h_max = 300;   % max number of harmonics to be considered
L = 2048;                 % fft calculation
NFFT = 2^nextpow2(L);     % fft calculation
fft_res_By_analy = fft(By_analy_fft, NFFT)/L; % fft calculation
By_analy_harm_peak = 2*abs(fft_res_By_analy(2:h_max+1))';   % peak value of each harmonic
% bar(By_analy_harm_peak)   % harmonics are calculated in this step, bar gives peak value of each harmonic


% FEM Bgap fft
By_FEM_fft = resample(By_FEM,2048,numel(By_FEM)); % adjust array size to 2048 points
h_max = 300;   % max number of harmonics to be considered
L = 2048;                 % fft calculation
NFFT = 2^nextpow2(L);     % fft calculation
fft_res_By_FEM = fft(By_FEM_fft, NFFT)/L; % fft calculation
By_FEM_harm_peak = 2*abs(fft_res_By_FEM(2:h_max+1))';   % peak value of each harmonic
% bar(By_FEM_harm_peak)   % harmonics are calculated in this step, bar gives peak value of each harmonic




%% IEEE Plot Figures Settings

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
set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');
set(0,'defaultFigurePaperPositionMode','auto');
% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','northeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');


%% Air gap flux density comparison of analytical and 3D fem results

elec_angle = x_dist*360/max(x_dist);  %deg, electrical angle

close all;

figure 
hold on
% grid on
% ax = gca;
xlabel('Angle (elec. deg)');
ylabel('Flux density (T)');
% ax.FontSize = 12;
% ax.Box='on';
% ax.FontName='Times New Roman';
plot(elec_angle(1:5:end), By_analy(1:5:end),'k-','linewidth',3);
plot(elec_angle(1:50:end), By_FEM(1:50:end),'ro','linewidth',3);

set(gca,'XTick', 0:60:360);
xlim([0 360])
legend({'Analytical calculation','3D-FEA results'});
hold off

% export_fig b-comp.pdf -transparent


%% harmonic content bar plot comparison of analytical and FEM results

harm_plot = 15;  % number of harmonics to be plotted

Bgap_fft_comp = [By_analy_harm_peak(1:harm_plot), By_FEM_harm_peak(1:harm_plot) ]; % required for bar plot in series 
bar(Bgap_fft_comp);  % this is the harmonics comparison for phase voltages

close all;

figure 
hold on
xlabel('Harmonic order');
ylabel('Flux density (T)');
bar(Bgap_fft_comp);
xlim([0 harm_plot])
set(gca,'XTick', 1:2:harm_plot);
legend({'Analytical calculation','3D-FEA results'});
hold off

% export_fig b-comp-bar.pdf -transparent




