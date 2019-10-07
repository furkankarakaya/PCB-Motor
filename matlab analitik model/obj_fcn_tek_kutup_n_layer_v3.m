% function obj = obj_fcn_tek_kutup_n_layer_v3(x)

%% inputs
global p c results counter layer

%variables
rout_pcb = x(1)/1e3;    %m, pcb rin
np = x(2);      %number of turns in each coil
k_mag = x(3);   %magnet kac tane üst üste
i_a = x(4)/10;   %Arms,per phase current at nominal speed


%constants
J = 25e6;  %A/m2
cu_thick_oz = 2; %oz
% rin_pcb = 25e-3;   %m, pcb rout
mag_angle = 144;   %elec_deg,  magnet angle
ur = 1.05;   %relative permeability of magnet
br = 1.33;    %T, residual flux density
m = 3;      %phase number
n = 500;       %rpm, nominal speed
d_trace = 0.2e-3;    %m, distance between two traces
% t_el = 0.15;    %Nm, nominal torque
% bear = 5e-3;   %m, bearing thickness in radial direction
temp_pcb = 60;   %deg, coils operating temperature

g_pcb_overall = 1.6e-3;    %m,overall pcb thickness

g_cu = cu_thick_oz*0.0347e-3;   %m, copper thickness per layer
area_cu = i_a/J;   %m2, copper area
w_cu_unrounded = area_cu/g_cu;    %m, copper trace width
w_cu = round(w_cu_unrounded,4);     %rounding nearest integer in mm

g_cl = 0.5e-3;

g_magnetic = 2*g_cl+g_pcb_overall;    %m, magnetic air gap

n_ph = layer*np*c;  %number of turns per phase
cs_main_el = p*180/m/c;       %electrical deg, coil span
cs_main_mec = 360/c/m;        %mech deg, coil span




%% magnet sizes

delta_r = d_trace+w_cu;      %m, bitiþik iki turn arasýnda radial mesafe
rout_mag = rout_pcb-3*delta_r+w_cu/2;      %m, magnet rout
rout_mag = round(rout_mag,3);     %rounding nearest integer in mm

rin_mag = rout_mag - 20e-3;          %m, magnet rin
rin_pcb = rin_mag; %m, rin pcb

%% prevent repeatition in optimization
% 
% opt = [rout_pcb*1e3 np cu_thick_oz J/1e6 i_a]; %optimization parameters
% 
% if counter>6     % biraz çözünce baþla karþýlaþtýrmaya
% for  i = 1:1:size(results,1)  %number of rows
%     if prod(results(i,1:numel(opt)) == opt)   %comparing elements of both arrays
%     obj = 1;
%         return;
%     end
% end
% end

%% kd calculation

alpha = abs(180*((3*c-p)/3/c));  %deg, ayný fazdaki iki coil arasýndaki acý
k = 120/2/alpha;  %adet, a ile c arasýnda 60 deg var. bu 60 deg içinde kac coil var

kd = sin(k*alpha*pi/180/2) / (k*sin(alpha*pi/180/2));  %distribution factor

%% calculation of App

%coildeki her bir turn için Apole*kp hesabý

i = 1:1:np;       %numbering each turn in a coil

r_mean = ( (rout_pcb-3*delta_r) + (rin_pcb+delta_r) )/2;    %m, pcb mean radius
delta_theta_el = 2*asin(delta_r/2/r_mean) * 180/pi * p/2;    %elec deg, bitisik iki turn arasýndaki acý
delta_theta_1_el = 2*asin( (2*d_trace+w_cu) / (4*r_mean) ) * 180/pi * p/2;    %elec deg, ilk turn ile coil border arasýndaki acý

rout_turn = rout_pcb-(i+2)*delta_r;     %m, rout of each turn in a coil, trace in ortasý
rin_turn = rin_pcb+i*delta_r;         %m, rin of each turn in a coil, trace in ortasý
a_pole = (rout_turn.^2-rin_turn.^2)*pi/p;    %m^2,   pole area for each turn in a coil

cs_turn_el = cs_main_el - 2*delta_theta_1_el - 2*(i-1)*delta_theta_el;        %elec deg, coil span for each turn in a coil
kp_turn = sin(cs_turn_el*pi/180/2);    %pitch factor for each turn in a coil

app = sum(kp_turn.*a_pole);    %sum of Apole*pitch factor in a coil



%% turnler birbirine girerse skip

% if( (max(rin_turn)+delta_r) > (min(rout_turn)-delta_r) )
%        obj = 1e6;
%     return  
%     
% end

if( (max(rin_turn)+delta_r) > (rout_pcb-(np+layer+2)*delta_r)  )
       obj = 1e6;
    return  
    
end

%% turnler üçgen þeklini almaya baþlarsa skip

r_inner_max = max(rin_turn)+w_cu/2;   %m, en içteki turnün inner edge radiusu
delta_x1 = d_trace/sin(cs_main_mec/2*pi/180);   %m, d_trace in yarattýgý radius
delta_x11 = w_cu/sin(cs_main_mec/2*pi/180);   %m, d_trace in yarattýgý radius
r_inner = np*(delta_x1+delta_x11);   %m, en içteki turn için köþelerin kesiþim noktasýnýn radiusu

if( r_inner > r_inner_max )  % turnler ücgen olmaya baslarsa
    obj = 1e6;
    return
end

%% b avg calculation


l_mag = k_mag * 1e-3;  %mm, magnet thickness
b_square = (2*l_mag*br) / (ur * g_magnetic + 2*l_mag);  %T, leakageler ignore edildiðinde kare flux density'nin tepesi
b_peak = b_square * 4 / pi * sin(mag_angle*pi/180/2);  %T, B fundamental component peak value
b_avg = b_peak * 2 / pi; %T, average flux density, magnetic loading



%% torque calculation

t_el = (3*sqrt(2)/4 * b_avg* layer*app*i_a*c*p*kd);     %Nm, rated torque


%% size calculations for scripting


% l_core calculation
b_core = 1.4;    %T, core desired B
rout_core = rout_mag;     %m, core outher radius
rin_core = rin_mag;        %m, core inner radius
flux_pp = b_avg*pi*(rout_core^2-rin_core^2)/p;   %wb, flux per pole
l_core_unrounded = flux_pp/2/b_core/(rout_core-rin_core);    %m, core depth
l_core = round(l_core_unrounded,4);     %rounding nearest integer in mm




%% resistance calculation  

ro_cu_20 = 1.68e-8;      %ohm*m, resistivity of copper at 20 deg
temp_ref = 20;    %deg, temp at ro_cu is defined
temp_coef = 0.004041;   %temperature dependency of copper resistance

ro_cu = ro_cu_20 * (1+temp_coef*(temp_pcb-temp_ref));     %ohm*m, resistivity of copper

cs_turn_mech = cs_turn_el*2/p;     %mech deg, mechanical coil span
l_cu_per_coil = sum([(rout_pcb-(i+3)*delta_r)-(rin_pcb+i*delta_r)]+[(rout_pcb-(i+2)*delta_r)-(rin_pcb+i*delta_r)]+...
    cs_turn_mech*pi/180.*(rin_pcb+i*delta_r + rout_pcb-(i+3)*delta_r))+...
    2*( (2*pi)/(m*c) * (rout_pcb-2*delta_r));  %m, total length of copper in a coil
res_ph = (layer*c)*ro_cu*l_cu_per_coil/area_cu;   %ohm, phase resistance


%% q calculation

% q = m*2*n_ph*i_a/pi/(rin_pcb+np*delta_r);  %electric loading

%% induced voltage  

f = n*p/120;       %Hz, frequency
e_a_fund_rms_analytical = pi*sqrt(2)*f*b_avg*app*kd*(c*layer);   %V,rms voltage per phase


%% b_avg harmonics calculation analytically

h_max = 15;   %max harmonics to be included
h = 1:1:h_max;   %harmonics to be encountered

% b_peak_h_analytical = b_square * 4/pi ./h .* sin(mag_angle*h/2*pi/180) .*mod(h,2);    %T, peak of sinusoidal harmonics, even harmonics zero
b_peak_h_analytical = b_square * 4/pi ./h .* cos(pi/2*h-mag_angle*h/2*pi/180) .*mod(h,2);    %T, peak of sinusoidal harmonics, even harmonics zero

b_avg_h = b_peak_h_analytical*2/pi;  %T, avg flux density for harmonics 

%% scripting function to get b harmonics

% scripting(l_mag, l_core, rout_mag, rin_mag, p, g_clc, g_cu, g_pcb, mag_angle);
% 

%% air gap flux density importing from maxwell and finding its harmonics

% filedir = 'C:\Users\DELL\Documents\pcb-motor\matlab analitik model\Bgap_3D.dat';   % file direction of .dat file
% delimiterIn = ' ';  % sütunlar ne ile ayrýlmýs, space
% headerlinesIn = 5;  % kaç satýrda baslýk var
% Bgap_2D= importdata(filedir,delimiterIn,headerlinesIn);   %structure
% b_h_maxw = Bgap_2D.data(:,2);   % imported bgap, 2049 point olmalý fft için
% % plot(b_h_maxw);
% 
% % fft calculation
% L = 2048;                 % fft calculation
% NFFT = 2^nextpow2(L);     % fft calculation
% fft_res = fft(b_h_maxw, NFFT)/L; % fft calculation
% b_peak_h_abs_maxw = 2*abs(fft_res(2:h_max+1))';   %T, maxweelden çekilen B'nin harmoniklerinin peak degeri
% b_peak_h_sign_maxw = (sign ( imag(-fft_res(2:h_max+1)) ))';   %maxxwellden çekilen B'nin harmoniklerinin açýsý (harmoniklerin iþaretleri için)
% b_peak_h_maxw = b_peak_h_abs_maxw .* b_peak_h_sign_maxw;  %her bir harmoniðin iþareti verildi
% b_avg_h = b_peak_h_maxw*2/pi;  %T,  avg flux density for harmonics 

%% harmonics voltage calculation

%f calculation
f_h = f;    % Hz, frequency

%kd calculation
kd_h = sin(h*k*alpha*pi/180/2) ./ (k*sin(h*alpha*pi/180/2));  %harmonics distribution factor

% app calculation
kp_turn_h = zeros(h_max,np);   %row = harmonics, column = turns
a_pole_h = zeros(h_max,np);   %row = harmonics, column = turns

for harm = 1:1:h_max
kp_turn_h(harm,:) = sin(harm*cs_turn_el*pi/180/2);    %harmonics' pitch factor for each turn in a coil
a_pole_h(harm,:) = a_pole;           %m^2, pole area for each harmonics (same)
end

app_h = kp_turn_h.*a_pole_h;   %her bir turn için apole*kp  (matrice of #harm.x#np)
app_h = sum(app_h,2)';   %isin icine np de katýldý, bir coildeki np*apole*kp carpýmý

e_a_h_rms = pi*sqrt(2).*f_h.*b_avg_h.*app_h.*kd_h*(c*layer);   %V,rms harmonics voltage per phase

e_a_h_peak = e_a_h_rms*sqrt(2);   %V, phase harmonik voltajlarýnýn peak deðerleri




%% THD Calculation  

% phase voltage thd   
thd_ph = 100*sqrt((sumsqr(e_a_h_rms)-e_a_h_rms(1)^2)) / abs(e_a_h_rms(1));   %thd for phase voltage
% bar(h,e_a_h);

% line voltage thd
e_ll_h_vector = e_a_h_rms.*(1-cos(h*120*pi/180)+1i*sin(h*120*pi/180));   % line to line voltage vector
e_ll_h_rms = abs(e_ll_h_vector);
e_ll_h_ang_rms = angle(e_ll_h_vector);

thd_ll = 100*sqrt((sumsqr(e_ll_h_rms)-e_ll_h_rms(1)^2))/abs(e_ll_h_rms(1));   %thd for phase voltage
e_ll_h_peak = e_ll_h_rms*sqrt(2);   %V, line to line voltage harmonics peak 

%% terminal voltage calculation

v_terminal_ph_rms = e_a_fund_rms_analytical+i_a*res_ph;

%% efficiency calculation

p_cu_loss = m*i_a^2*res_ph;        %W, total copper loss 
p_out = n*pi/30*t_el;    %W, rated output power
p_in = 3*i_a*(v_terminal_ph_rms);  %W, total input power
eff = p_out/p_in;     %efficiency


%% voltage waveforms,,,, waveformlar yanlýs gibi

time = 0:1/f/2000:1/f;   % time array

% phase voltage

e_ph_h_a = zeros(harm,length(time));  % phase a voltage
e_ph_h_b = zeros(harm,length(time));  % phase b voltage

for harm = 1:1:h_max
e_sin_a = sin(2*pi*f*time*harm +(harm-1)*pi/2 );  % phase a sinus part
e_sin_b = sin(harm*(2*pi*f*time-2*pi/3)+(harm-1)*pi/2 ); % phase a sinus part
e_ph_h_a(harm,:) = sqrt(2)*e_a_h_rms(harm)*e_sin_a;  % phase a her bir harmonigin time frame grafigi
e_ph_h_b(harm,:) = sqrt(2)*e_a_h_rms(harm)*e_sin_b; % phase b her bir harmonigin time frame grafigi
end

e_ph_a_time = sum(e_ph_h_a);  %V, phase a time domain including all harmonics
e_ph_b_time = sum(e_ph_h_b); %V, phase b time domain including all harmonics
e_ll_time_by_subtr = e_ph_a_time-e_ph_b_time;  %line to line voltage time frame obtained

e_ll_h_time = zeros(harm,length(time));  %l-l voltage
for harm = 1:1:h_max
e_ll_sin = sin(2*pi*f*harm*time+e_ll_h_ang_rms(harm));  % ll voltage sinüs part
e_ll_h_time(harm,:) = sqrt(2)*e_ll_h_rms(harm)*e_ll_sin;  % ll voltage her bir harmonigin time frame grafigi
end

e_ll_time = sum(e_ll_h_time);  % ll voltage time frame including all harmonics



%% mass calculation

dens_pcb_fr4 = 1.85e3;    %kg/m3, density of pcb fr4 material
dens_cu = 8.96e3;     %kg/m3, density of copper
dens_mag = 7.4e3;     %kg/m3, density of magnets
dens_core = 7.87e3;      %kg/m3, density of iron core

vol_pcb = pi*(rout_pcb^2-rin_pcb^2)*(g_pcb_overall-g_cu*layer);   %m3, pcb volume
m_pcb_fr4 = vol_pcb*dens_pcb_fr4;   %kg, mass of pcb fr4

vol_per_mag = pi*(rout_mag^2-rin_mag^2)*mag_angle/180*l_mag/p;  %m3, magnet volume per magnet
m_mag = 2*vol_per_mag*p*dens_mag;   %kg, total magnet mass, p tane

vol_per_core = pi*(rout_core^2-rin_core^2)*l_core;  %m3, tek taraflý core vol
m_core = vol_per_core*2*dens_core;  %kg, total core mass

vol_cu = m*layer*c*l_cu_per_coil*area_cu;  %m3, total copper volume
m_cu = vol_cu*dens_cu;   %kg, copper mass

m_pcb = m_pcb_fr4+m_cu;   %kg, total pcb weight

m_total = m_core+m_mag+m_pcb; %kg, total mass

%% deflection calculation

deflection = deflection_calculator(rin_mag, rout_mag, g_cl, rin_core, l_core, mag_angle, b_peak);  %gives deflection in percentage of clearance per core side

%% phase inductance calculation

ind_ph = inductance_calculator( rin_turn, rout_turn, cs_turn_mech, g_magnetic, l_mag, layer, c );

%% R/L ratio

% RL_ratio = res_ph / ind_ph;  %R/L ratio


%% penalty functions

pen_eff_c = 1e3;  %efficiency penalty
eff_min = 0.6;
pen_eff = pen_eff_c*max(0,eff_min-eff);

pen_torque_c = 1e5;  %thd penalty
torque_min = 1;
pen_torque = pen_torque_c*max(0,torque_min-t_el); %min tork


def_max = 25;  %maximum deflection
pen_deflection = max(0,deflection-def_max)*1e6;


%% obj function

obj = pen_torque + m_total ;

%% iterasyon sonuçlarýný array'a yazdýrma

results(counter,:) = [rout_pcb*1e3 np i_a l_mag*1e3 l_core*1e3 res_ph ind_ph eff*100 e_a_h_rms(1) thd_ph thd_ll b_avg deflection m_total t_el obj]; %kaydedilen sonuclar

counter = counter+1;

% end