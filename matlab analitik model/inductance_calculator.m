function [ ind_ph ] = inductance_calculator( rin_turn, rout_turn, cs_turn_mech, g_magnetic, l_mag, layer, c)

% this function calculates inductance of planar printed inductor.
% first area of each turn is calculated
% then magnetic field is calculated for each turn
% flux linkage is calculated then.
% inductance is flux linkage per current.
% here current is assumed to be 1 A

%% area of each turn 
u0 = pi*4e-7; %perm of air
area_turn = pi* (rout_turn.^2 - rin_turn.^2) .* cs_turn_mech/360;  %m2, area of each turn


%% B for each turn

np = length(rin_turn); %number of turns
turn = 1:1:np;   %turns

g = g_magnetic + l_mag;  %m, magnetic air gap including l_mag
b_turn = turn * u0 * layer / g;   %T, magnetic field density for each turn


%% flux linkage for each turn
for turn = 1:1:np
    
   theSum = 0;
for i = turn : (np-1)
  theSum = theSum + b_turn(i)*(area_turn(i)-area_turn(i+1));
end

flux_turn(turn) = area_turn(np)*b_turn(np)+theSum;  %Wb, flux linkage for specific turn
end

flux_per_coil = sum(flux_turn);  %Wb, flux linkage for ONE COIL

flux_per_layer = flux_per_coil * c;  %Wb, flux linkage for one layer per phase

flux_per_phase = flux_per_layer * layer;  %Wb, flux linkage per phase

ind_ph = flux_per_phase;   %H, phase inductance

end

