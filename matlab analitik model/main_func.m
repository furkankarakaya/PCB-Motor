clear all
clc

global p c counter results layer
counter = 1;
results = [];
p = 16;
c = 4;   %number of coils per phase

layer = 6;

% system(sprintf('open_maxwell.vbs "%s"', 'C:\Users\DELL\Documents\pcb-motor\matlab analitik model')); %open maxwell first

%% borders

rout_pcb_max = 50;   %mm, max outer radius
rout_pcb_min = 50;   %mm, min outer radius

i_a_max = 5;   %Arms, max phase current
i_a_min = 0.1;   %Arms, min phase current

np_max = 15;    %max sarmal say�s�
np_min = 1;     %min sarmal say�s�

k_mag_max = 5;  % magnet kac tane �st �ste
k_mag_min = 1;  % magnet kac tane �st �ste

%% ga options 

LB = [rout_pcb_min np_min k_mag_min i_a_min*10];
UB = [rout_pcb_max np_max k_mag_max i_a_max*10];
max_stall_gen = 50;  %If the average change in the fitness function value over Stall generations is less than Function tolerance, the algorithm stops.
function_tolerance = 1e-6;  %obj fcn daki change ne kadar �nemli
options = gaoptimset(@ga);
options.TolFun = function_tolerance;    %opt. bitirmek i�in gereken en k�c�k de�i�im
options.StallGenLimit = max_stall_gen;  %opt. bitirmek i�in gereeken generation say�s�
options.CrossoverFraction = 0.3;  %Elit say�s� haricinde kalanlar�n ka�� mutasyon ile next generasyona aktar�lacak
options.PopulationSize = 400;  % nuf�s

% [x,fval] = ga(@obj_single_sided,numel(LB),[],[],[],[],LB,UB,[],[1,2,3,4],options);
[x,fval] = ga(@obj_single_sided,numel(LB),[],[],[],[],LB,UB,[],[1,2,3,4],options);


results = unique(results,'rows');
results = sortrows(results,size (results,2)); %obj fcn a g�re s�rala