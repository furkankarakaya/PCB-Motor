%%
% load('concentric.mat');
%%

% filter_freq= 400000; %Hz
time_array = time_1500 - time_1500(1);
Tstep = (time_array(2) - time_array(1));
time_array2 = transpose(0:Tstep:100e-3-Tstep); % 45 ms of data is taken

% Vdc1 - Rectifier - No int

InducedVoltagePhaseA1 = phase_a_2000;
InducedVoltagePhaseA = [InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1;InducedVoltagePhaseA1]; % 45 ms of data is taken
ts_InducedVoltagePhaseA = timeseries(InducedVoltagePhaseA,time_array2);

sim('for_fft.slx');

%% Adjust FFT parameters

fft_cycle = 1;
fft_start = 0;
fft_fund = 266.67;
fft_maxfreq = 200000;
fft_THDmaxfreq = 200000;
% h_level=0.1;
% n_harmonic=20;

%% Idc - Module 1 - No int

InducedVoltagePhaseA_FFTDATA = power_fftscope(InducedVoltagePhaseA_forfft);
InducedVoltagePhaseA_FFTDATA.startTime = fft_start;
InducedVoltagePhaseA_FFTDATA.cycles = fft_cycle; 
InducedVoltagePhaseA_FFTDATA.fundamental = fft_fund; 
InducedVoltagePhaseA_FFTDATA.maxFrequency = fft_maxfreq;
InducedVoltagePhaseA_FFTDATA.THDmaxFrequency = fft_THDmaxfreq;
InducedVoltagePhaseA_FFTDATA = power_fftscope(InducedVoltagePhaseA_FFTDATA);

%% Plot the FFT result (magnitude) of module's DC currents

figure;
hold all;
freq=transpose(linspace(0,374,375));
x=[freq(1:20) freq(1:20) freq(1:20)];
y=[transpose(e_a_h_peak(1:20)) magInducedVoltagePhaseA(1:20) test_con_fft(1:20) ];
% x=[FreqkHz./FreqkHz(2) FreqkHz./FreqkHz(2)];
% y=[InducedVoltagePhaseA_FFTDATA.mag(1:51) magInducedVoltagePhaseA];
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
set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');
set(0,'defaultFigurePaperPositionMode','auto');
% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','northeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');
bar(x,y);
% bar(InducedVoltagePhaseA_FFTDATA.freq(1:51),InducedVoltagePhaseA_FFTDATA.mag(1:51));
xlabel('Harmonic Order','FontSize',40,'FontWeight','Bold')
ylabel('Induced Voltage (V)','FontSize',40,'FontWeight','Bold')
grid on
xlim([0.6 3.5]);
ylim([0 9]);
xticks([1 2 3]);
yticks([0 3 6 9]);
legend('Analytical Result','FEA Result','Test Result');


%%
% figure;
% hold all;
% plot(xaxis,VarName2,'Linewidth',2);
% plot(xaxis,VarName3,'Linewidth',2);
% plot(xaxis,VarName4,'Linewidth',2);
% set(gca,'FontSize',14);
% xlabel('Time (s)','FontSize',14,'FontWeight','Bold')
% ylabel('Induced Phase Voltages (V)','FontSize',14,'FontWeight','Bold')
% %  xlim([-5e-03 5e-03]);
% %  ylim([-9 9]);
% grid on
% legend('Phase A','Phase B','Phase C');
% title('Concentric Winding Induced Voltage - 2000 RPM ');
%%
% %% Harmonic Analysis
% 
% mp_Idc1_noint_200v=[i1_ag_noint_FFTDATA.freq i1_ag_noint_FFTDATA.mag i1_ag_noint_FFTDATA.phase ];
% mp_Idc1_yesint_200v=[i1_ag_yesint_FFTDATA.freq i1_ag_yesint_FFTDATA.mag i1_ag_yesint_FFTDATA.phase ];
% mp_Idc2_noint_200v=[i2_ag_noint_FFTDATA.freq i2_ag_noint_FFTDATA.mag i2_ag_noint_FFTDATA.phase ];
% mp_Idc2_yesint_200v=[i2_ag_yesint_FFTDATA.freq i2_ag_yesint_FFTDATA.mag i2_ag_yesint_FFTDATA.phase ];
% mp_Isum_noint_200v=[itotal_ag_noint_FFTDATA.freq itotal_ag_noint_FFTDATA.mag itotal_ag_noint_FFTDATA.phase ];
% mp_Isum_yesint_200v=[itotal_ag_yesint_FFTDATA.freq itotal_ag_yesint_FFTDATA.mag itotal_ag_yesint_FFTDATA.phase ];
% mp_Idif_noint_200v=[idif_ag_noint_FFTDATA.freq idif_ag_noint_FFTDATA.mag idif_ag_noint_FFTDATA.phase ];
% mp_Idif_yesint_200v=[idif_ag_yesint_FFTDATA.freq idif_ag_yesint_FFTDATA.mag idif_ag_yesint_FFTDATA.phase ];
% mp_Vdc_noint_200v=[v2_ag_noint_FFTDATA.freq v2_ag_noint_FFTDATA.mag v2_ag_noint_FFTDATA.phase ];
% mp_Vdc_yesint_200v=[v2_ag_yesint_FFTDATA.freq v2_ag_yesint_FFTDATA.mag v2_ag_yesint_FFTDATA.phase ];
% 
% num = size(mp_Idc1_noint_200v);
% i=1;
% 
% for k = 1:num(1)
%     if (mp_Idc1_noint_200v(k,2) >= h_level*max(mp_Idc1_noint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Idc1_yesint_200v(k,2) >= h_level*max(mp_Idc1_yesint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Idc2_noint_200v(k,2) >= h_level*max(mp_Idc2_noint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Idc2_yesint_200v(k,2) >= h_level*max(mp_Idc2_yesint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Isum_noint_200v(k,2) >= h_level*max(mp_Isum_noint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Isum_yesint_200v(k,2) >= h_level*max(mp_Isum_yesint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Idif_noint_200v(k,2) >= h_level*max(mp_Idif_noint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Idif_yesint_200v(k,2) >= h_level*max(mp_Idif_yesint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Vdc_noint_200v(k,2) >= h_level*max(mp_Vdc_noint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     elseif  (mp_Vdc_yesint_200v(k,2) >= h_level*max(mp_Vdc_yesint_200v(:,2)))
%         a(i,:)=[mp_Idc1_noint_200v(k,:) mp_Idc1_yesint_200v(k,:) mp_Idc2_noint_200v(k,:) mp_Idc2_yesint_200v(k,:) mp_Isum_noint_200v(k,:) mp_Isum_yesint_200v(k,:) mp_Idif_noint_200v(k,:) mp_Idif_yesint_200v(k,:) mp_Vdc_noint_200v(k,:) mp_Vdc_yesint_200v(k,:)];
%         i=i+1;
%     end
% end
% 
% %% Exporting as .xlsx file
% 
% C=[{{},'Idc1_noint_200v',{},{},'Idc1_yesint_200v',{},{},'Idc2_noint_200v',{},{},'Idc2_yesint_200v',{},{},'Isum_noint_200v',{},{},'Isum_yesint_200v',{},{},'Idif_noint_200v',{},{},'Idif_yesint_200v',{},{},'V2_noint_200v',{},{},'V2_yesint_200v',{};'Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase','Frequency','Magnitude','Phase',};num2cell(a)];
% T=cell2table(C);
% filename = 'harmonicse.xlsx';
% writetable(T,filename);
