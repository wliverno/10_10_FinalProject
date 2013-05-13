function Extractor
%
%   This function simulates the performance of the Batch Extractor and computes its associated economics.
%   It is called by the function "Simulator.m"
%   
%   INPUT Global Variables 
global  Reactor_effluent           %  Provides the molar amounts for all materials and temperature.
global  Materials_Properties    %  This matrix contains the physical properties of all materials in the process
global  Labor_unit_cost  Extractor_rental_cost_per_hour  Electricity_cost 
global  ExtractorVolume  ExtractorTurn  ExtractorStir
global  Materials_Prices
global  AmountSolvent_S2
%   OUTPUT Global Variables
global  Extractor_Phase_1_exit_stream  Extractor_Phase_2_exit_stream 
global  Materials_Costs  Utilities_Costs  Vessel_Rental_Costs  Labor_Costs   Materials_Credits
global  Vessel_Occupancy
global  Solvent_S2
%
%   Characterize the Extraction Solvent, S2
%
volume_solvent_S2 = AmountSolvent_S2;  %  sets the solvent volume, in m3, to a value given from outside.
mass_solvent_S2 = volume_solvent_S2 * Materials_Properties(9,2);    %  in Kilograms
moles_solvent_S2 = 1000*mass_solvent_S2/Materials_Properties(9,1);  %  in g-moles
Solvent_S2 = [0; 0; 0; 0; 0; 0; 0; 0; moles_solvent_S2; 298; mass_solvent_S2; volume_solvent_S2];
%
%   Characterize the input to the Batch Extractor as identical to the
%   Reactor Effluent
%
Extractor_feed = Reactor_effluent;
Phase_1_initially = Extractor_feed';
Phase_2_initially = Solvent_S2;          %  This vector contains the molar amounts of all chemicals in S2
volume_Phase_1 = Phase_1_initially(12);  %  in m3.
volume_Phase_2 = volume_solvent_S2;      %  in m3.
%
%   Check if the volume of Solvent, S2, can be accomodated by the Extractor
%   vessel.
total_volume = volume_Phase_1 + volume_Phase_2;
if total_volume > ExtractorVolume
    disp('WARNING: The volume of Solvent, S2, is larger than what can be accommodated by the extractor vessel, given the volume of material from the reactor.  The volume of Solvent, S2, has been reset to be equal to the difference, (Extractor vessel volume) - (Volume of material from reactor)');
    volume_Phase_2 = ExtractorVolume - volume_Phase_1;
end
%   Set the Equilibrium constants for the distribution of A, B, P, Q, W, Z,
%   C, S1, S2, between the two solvents.
EquilibriumConstants = [10; 8; 0; 0; 0; 0; 0; 0; 10];  
% Equilibrium Constant = [concentration of a species in Solvent S2]/[concentration of a species in Solvent S1]
%
%   Carry out the equilibrium calculations.  
%   At equilibrium, [species,in Phase-2]/[species,in Phase-1] = Equilibrium constant of x.
%   where, [x] is the molar concentration of a species.
%
K = EquilibriumConstants;
volume_ratio = volume_Phase_2/volume_Phase_1;  % volume of phase-2 over volume of phase-1
divider = volume_ratio .* K + 1;
moles_transferred = zeros(9,1);
moles_transferred(1:8) = volume_ratio.*K(1:8).*Phase_1_initially(1:8)./divider(1:8);  % moles of A,B,P,Q,W,Z,C,S1 transferred from phase-1 to phase-2
moles_transferred(9) = Phase_2_initially(9)/divider(9);     % moles of S2 transferred from phase-2 to phase-1


%   Number of Moles at equilibrium, at the end of the extraction
Phase_1_equilibrium(1:8) = Phase_1_initially(1:8) - moles_transferred(1:8);   %  A, B, P, Q, W, Z, C, S1
Phase_1_equilibrium(9) = Phase_1_initially(9) + moles_transferred(9);      %  S2
Phase_2_equilibrium(1:8) = Phase_2_initially(1:8) + moles_transferred(1:8);    %  %  A, B, P, Q, W, Z, C, S1
Phase_2_equilibrium(9) = Phase_2_initially(9) - moles_transferred(9);      %  S2
%

%   Specify the characteristics of the exiting two streams from the batch extractor
Extractor_Phase_1_exit_stream(1:9) = Phase_1_equilibrium(1:9);  %  Assign amounts in moles to the Phase_1_exit_stream
Extractor_Phase_2_exit_stream(1:9) = Phase_2_equilibrium(1:9);  %  Assign amounts in moles to the Phase_2_exit_stream 

%   Compute total masses in kilograms
component_amounts_in_kilograms_1 = Extractor_Phase_1_exit_stream(1:9)'.*Materials_Properties(1:9,1)/1000;  
							% Kgs for each component
Extractor_Phase_1_exit_stream(11) = sum(component_amounts_in_kilograms_1);   % Total mass, Kgs.
component_amounts_in_kilograms_2 = Extractor_Phase_2_exit_stream(1:9)'.*Materials_Properties(1:9,1)/1000;         							% Kgs for each component
Extractor_Phase_2_exit_stream(11) = sum(component_amounts_in_kilograms_2);   % Total mass, Kgs.

%   Compute total volume, in m3.
component_volumes_1 = component_amounts_in_kilograms_1./Materials_Properties(1:9,2); % densities = Materials_Properties(1:9,2), in Kgs/m3
Extractor_Phase_1_exit_stream(12) = sum(component_volumes_1);
component_volumes_2 = component_amounts_in_kilograms_2./Materials_Properties(1:9,2); % densities = Materials_Properties(1:9,2), in Kgs/m3
Extractor_Phase_2_exit_stream(12) = sum(component_volumes_2);

%   Compute the Extraction Time, hours
volcm = 100^3; % Conversion factor from cm^3 to m^3
extraction_period = (1.5e8/3600)*((moles_transferred(2)/(volcm*Extractor_Phase_2_exit_stream(12))));

%   Assign temperatures
heat_produced_by_stirrer = ExtractorStir*extraction_period*3600;  % heat input into the system by stirrer over the period of stirring
total_mass_in_extractor = Extractor_Phase_1_exit_stream(11) + Extractor_Phase_2_exit_stream(11);
temperature_rise_due_to_stirrer = heat_produced_by_stirrer/(total_mass_in_extractor * Materials_Properties(9,3)); % degrees K
Extractor_Phase_1_exit_stream(10) = Extractor_feed(10) + temperature_rise_due_to_stirrer; % degrees K
Extractor_Phase_2_exit_stream(10) = Extractor_feed(10) + temperature_rise_due_to_stirrer; % degrees K
%
%   Compute the Economics of the Extractor per batch.
%                                   
%   Equipment rental cost
extractor_rental_cost = (extraction_period + ExtractorTurn)*Extractor_rental_cost_per_hour;       %  in $
extractor_stirrer_electricity_cost = (extraction_period + ExtractorTurn)*Electricity_cost*(ExtractorStir); % in $
%
%   Materials Cost
solvent_cost_S2 = mass_solvent_S2*Materials_Prices(9);         % in $
%
%   Labot Cost 
extractor_labor_cost = (extraction_period + ExtractorTurn)*Labor_unit_cost;    % in $
%
%   SUMMARY OF EXTRACTOR ECONOMICS
%
Materials_Costs(2,(1:4)) = 0 ;  
Materials_Costs(2,5) = solvent_cost_S2;  
Utilities_Costs(2,(1:7)) = 0; 
Utilities_Costs(2,2) = extractor_stirrer_electricity_cost; 
Vessel_Rental_Costs(2) = extractor_rental_cost ;
Labor_Costs(2) = extractor_labor_cost;
Materials_Credits(2,(1:5))= zeros(1,5);
Vessel_Occupancy(2) = extraction_period + ExtractorTurn;                                                                      					%  Total occupancy time of the extractor vessel, per batch
end


