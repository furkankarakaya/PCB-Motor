%%
% load('concentric.mat');
%%

% filter_freq= 400000; %Hz
time_array = time_1500 - time_1500(1);
Tstep = (time_array(2) - time_array(1));
time_array2 = transpose(0:Tstep:100e-3-20*Tstep); % 45 ms of data is taken

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
test_rad_fft=InducedVoltagePhaseA_FFTDATA.mag;
test_rad_freq=InducedVoltagePhaseA_FFTDATA.freq;
figure;
hold all;

x=[transpose(deneme2) transpose(deneme2) transpose(deneme)];
y=[InducedVoltagePhaseA_FFTDATA.mag(1:51) magInducedVoltagePhaseA transpose(an_mag_arc)];
bar(x,y);
% bar(InducedVoltagePhaseA_FFTDATA.freq(1:51),InducedVoltagePhaseA_FFTDATA.mag(1:51));
xlabel('Harmonic Order','FontSize',14,'FontWeight','Bold')
ylabel('Magnitude of Induced Voltage (V)','FontSize',14,'FontWeight','Bold')
title('Radial Winding Induced Voltage FFT Result - 2000 RPM ');
L1=sprintf('Test Results: Vfundamental = %.3f V ',max(InducedVoltagePhaseA_FFTDATA.mag(1:51)));
L2=sprintf('FEA Results: Vfundamental = %.3f V ',max(magInducedVoltagePhaseA));
L3=sprintf('Analytical results: Vfundamental = %.3f V ',max(an_mag_arc));
legend(L1,L2,L3);
grid on
xlim([0.6 5]);
title('ARC Winding Induced Voltage FFT Result - 2000 RPM ');
% an_mag_arc=[an_mag_arc, zeros(1, length(magInducedVoltagePhaseA) - length(an_mag_arc))];
% an_fr_arc=[an_fr_arc, zeros(1, length(FreqkHz) - length(an_fr_arc))];
% deneme=linspace(1,99,50);
% deneme=[0 deneme];
% deneme2=0:1:50;
% test_arc_fft=InducedVoltagePhaseA_FFTDATA.mag;
% test_arc_freq=InducedVoltagePhaseA_FFTDATA.freq;
%%
figure;
hold all;
plot(time_1500+0.00251,phase_a_2000,'Linewidth',2);
plot(Timems./1000,InducedVoltagePhaseA,'Linewidth',2);
plot(time-9.25e-04,-an_vol_arc,'Linewidth',2);
set(gca,'FontSize',14);
xlabel('Time (s)','FontSize',14,'FontWeight','Bold')
ylabel('Induced Phase Voltages (V)','FontSize',14,'FontWeight','Bold')
xlim([0 0.005645]);
%  ylim([-9 9]);
grid on
L1=sprintf('Test Results: Vrms = %.3f V ',rms(phase_a_2000));
L2=sprintf('FEA Results: Vrms = %.3f V ',rms(InducedVoltagePhaseA));
L3=sprintf('Analytical results: Vrms = %.3f V ',rms(an_vol_arc));
legend(L1,L2,L3);
title('ARC Winding Induced Voltage - 2000 RPM ');
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
