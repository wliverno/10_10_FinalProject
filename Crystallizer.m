function Crystallizer
%
%   10.10 Project.  Spring 2003.
%   Prepared by George Stephanopoulos.
%
%   This function simulates the performance of the Batch Crystallizer and computes its associated economics.
%   It is called by the function "Simulator.m"
%
%   INPUT Global Variables
global  Extractor_Phase_1_exit_stream   
global  Materials_Properties 
global  CrystallizerVolume  CrystallizationStir  CrystallizationTurn  CrystallizerCool
global  Electricity_cost   Refrigeration_cooling_cost 
global  Labor_unit_cost  
global  Crystallizer_rental_cost_per_hour
%   OUTPUT Global Variables
global  Materials_Costs  Utilities_Costs  Vessel_Rental_Costs  Labor_Costs   Materials_Credits  
global  Crystal_phase_Coating_Liquid_from_crystallizer  Crystal_phase_from_crystallizer   Liquid_phase_from_crystallizer
global  Vessel_Occupancy

%
%   Mass Balances
Feed_to_crystallizer = Extractor_Phase_1_exit_stream;   %  The stream of Phase-1 from the extractor is the feed to the crystallizer.
crystals__from_crystallizer   = (0.9)*Feed_to_crystallizer(3);   %  90% of moles of P crystallize
weight_of_crystals = crystals__from_crystallizer * Materials_Properties(3,1)/1000;   % Kilograms of crystals, P
liquid_coating_crystals = (0.1)*weight_of_crystals;        % Kg of liquid coating the crystals in the crystallizer
liquid_after_removal_of_crystals(1:9) = Feed_to_crystallizer(1:9) - [0 0 crystals__from_crystallizer 0 0 0 0 0 0];
%  The next line computes the mole fractions of all components in the
%  liquid at the end of crystallization, e.g. (mole fraction of A) = (moles of A)/(sum of moles of all components)
mole_fractions_in_liquid_after_removal_of_crystals(1:9) = liquid_after_removal_of_crystals(1:9)/sum(liquid_after_removal_of_crystals(1:9));
%  The next line computes the wight ratios of all components in the liquid
%  with respect to chemical, A, e.g. (weight ratio of B)= (weight of B)/(weight of A).
weight_ratios_in_liquid_after_removal_of_crystals(1:9) = (mole_fractions_in_liquid_after_removal_of_crystals(1:9)'.*Materials_Properties((1:9),1))/(mole_fractions_in_liquid_after_removal_of_crystals(1)*Materials_Properties(1,1));
%  The next line computes the sum of the weight ratios, i.e. sum(weight ratio of A, weight ratio of B, etc.) 
sum_of_weight_ratios = sum(weight_ratios_in_liquid_after_removal_of_crystals(1:9));
%  The next line computes the moles of A in the liquid coating the crystals
%  as follows:  The sum of the weights of all components in the liquid
%  coating the crystals is equal to the "liquid_coating_crystals", computed
%  in line 24, above.  Therefore, (weight,A)=
%  (liquid_coating_crystals)/sum(weight ratios*ratios of molecular weights), and 
%  (moles,A) = (weight,A)*1000/(molecular weight,A);  moles of A in the liquid coating the crystals.
moles_in_the_liquid_coating_the_crystals(1) = 1000*(liquid_coating_crystals)/ (sum_of_weight_ratios*Materials_Properties(1,1));
%  The next line yields the moles of B,P,Q,W,Z,C,S1,S2 in the liquid
%  coating the crystals
moles_in_the_liquid_coating_the_crystals(2:9) = (mole_fractions_in_liquid_after_removal_of_crystals(2:9)/mole_fractions_in_liquid_after_removal_of_crystals(1))*moles_in_the_liquid_coating_the_crystals(1);
%   Define a new vector, "Crystal_phase_Coating_Liquid_from_crystallizer(1:9)",
%   that describes the moles of A, B, P, Q, W, Z, C, S1, S2 in the liquid coating the crystals.
%   "Crystal_phase_Coating_Liquid_from_crystallizer(1:9)" describes the
%   composition of the liquid that leaves the crystallizer with the
%   crystals.
Crystal_phase_Coating_Liquid_from_crystallizer(1:9) = moles_in_the_liquid_coating_the_crystals(1:9); 
%   Composition of the solid Crystal Product 
Crystal_phase_from_crystallizer(3) = crystals__from_crystallizer;
Crystal_phase_from_crystallizer(1:2) = 0;
Crystal_phase_from_crystallizer(4:9) = 0;
%   Composition of the liquid phase leaving the crystallizer
Liquid_phase_from_crystallizer(1:9) = liquid_after_removal_of_crystals(1:9) - Crystal_phase_Coating_Liquid_from_crystallizer(1:9);
%   Energy Balance
heat_load_removed_during_liquid_cooling = ((Feed_to_crystallizer(3:8)*(Materials_Properties((3:8),1)/1000))*Materials_Properties(8,3))*(Feed_to_crystallizer(10) - 263);  % Heat removed during cooling to -10 C
heat_load_removed_during_crystallization = (Feed_to_crystallizer(3)*Materials_Properties(3,1)/1000) * Materials_Properties(3,5);    % Heat of fusion of P removed during crystal formation, in KJ
%   Crystallization period
load_for_cooling_and_crystallization = heat_load_removed_during_liquid_cooling + heat_load_removed_during_crystallization;  % in KJ
Q = CrystallizerCool - CrystallizationStir;  % in KW
CrystallizationTime = (load_for_cooling_and_crystallization /Q)/3600;      % in hours
%
heat_load_removed_due_to_stirrer = CrystallizationStir * (3600 * CrystallizationTime);   % Heat added by stirrer, which must be removed during crystallization, in KJ
Total_heat_removed = load_for_cooling_and_crystallization + heat_load_removed_due_to_stirrer;
%
Liquid_phase_from_crystallizer(10) = 263;   %  Setting temperature of exiting stream at -10 C.
Crystal_phase_from_crystallizer(10) = 263; %  Setting temperature of exiting stream at -10 C.
Crystal_phase_Coating_Liquid_from_crystallizer(10) = 263;   %  Setting temperature of exiting stream at -10 C.
%
%   Materials Costs
Materials_Costs(4,(1:5)) = zeros(1,5);
%   Utilities Costs
Utilities_Costs(4,(1:7)) = 0;   
Utilities_Costs(4,2) = CrystallizationStir * CrystallizationTime * Electricity_cost ;   %  Cost of electricity for stirring
Utilities_Costs(4,5) = Total_heat_removed * Refrigeration_cooling_cost  ;   %  Refrigeration cooling cost
%   Labor Cost
crystallizer_labor_cost = (CrystallizationTime + CrystallizationTurn) * (Labor_unit_cost);    % in $
Labor_Costs(4) = crystallizer_labor_cost ;
%   Equipemnt Rental Cost
crystallizer_rental_cost = (CrystallizationTime + CrystallizationTurn) * (Crystallizer_rental_cost_per_hour);       %  in $
Vessel_Rental_Costs(4) = crystallizer_rental_cost;
%   Materials_Credits
Materials_Credits(4,(1:5)) = zeros(1,5);
Vessel_Occupancy(4) = CrystallizationTime + CrystallizationTurn;     %  Total occupancy time of the distillation system, per batch



