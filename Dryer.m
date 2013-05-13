function Dryer
%
%   10.10 Project.  Spring 2003.
%   Prepared by George Stephanopoulos.
%
%   This function simulates the performance of the Dryer and computes its associated economics.
%   It is called by the function "Simulator.m"
%
%   INPUT Global Variables
global  Crystal_phase_Coating_Liquid_from_crystallizer  Crystal_phase_from_crystallizer   Liquid_phase_from_crystallizer
global  Dryer_heating_cost  Dryer_rental_cost_per_hour  DryerTurn  DryerHeatingPower
global  Labor_unit_cost  
global  Materials_Properties 
%   OUTPUT Global Variables
global  Materials_Costs  Utilities_Costs  Vessel_Rental_Costs  Labor_Costs   Materials_Credits  
global  Vapor_stream_from_dryer  Crystal_stream_from_dryer
%
%   Mass Balances
%
Vapor_stream_from_dryer = Crystal_phase_Coating_Liquid_from_crystallizer;
Crystal_stream_from_dryer = Crystal_phase_from_crystallizer;
%
%   Energy Balances
%
%   Sensible heat absorbed by the components of the liquid coating the crystals; from 263 K to
%   their temperature of vaporization
amount_of_each_liquid_component = (Vapor_stream_from_dryer(1:9)'.*(Materials_Properties((1:9),1)/1000));  % in Kgs
sensible_heat_absorbed_by_each_component = amount_of_each_liquid_component(1:9) .*Materials_Properties((1:9),3).*(Materials_Properties((1:9),6)-263);
temperature = max(Materials_Properties((1:9),6)) + 30;      %  The temperature in the dryer is 30 degrees higher than the highest boiling point
sensible_heat_absorbed_by_crystal = Crystal_stream_from_dryer(3)*(0.215)*(temperature-Crystal_stream_from_dryer(10));
total_sensible_heat = sum(sensible_heat_absorbed_by_each_component(1:9));
Vapor_stream_from_dryer(10) = temperature;
Crystal_stream_from_dryer(10) = temperature;
%   Latent heat absorbed by the components of the liquid coating the crystals
latent_heat_absorbed_by_each_component = Vapor_stream_from_dryer(1:9)'.*Materials_Properties((1:9),4);
total_latent_heat = sum(latent_heat_absorbed_by_each_component(1:9));
total_heat_absorbed_in_dryer = total_sensible_heat + total_latent_heat + sensible_heat_absorbed_by_crystal;
%
%   Drying Period
drying_period = (total_heat_absorbed_in_dryer/DryerHeatingPower)/3600;
%   Economics
dryer_heating_cost = total_heat_absorbed_in_dryer * Dryer_heating_cost;   % in $ per batch
%   Labot Cost 
dryer_labor_cost = (drying_period + DryerTurn) * (Labor_unit_cost);    % in $
dryer_rental_cost  = (drying_period + DryerTurn) * (Dryer_rental_cost_per_hour);    % in $
%
%   SUMMARY OF REACTOR ECONOMICS
%
Materials_Costs(5,(1:5)) = 0;  
Utilities_Costs(5,(1:7)) = 0; 
Utilities_Costs(5,6) = dryer_heating_cost;  %  Cost of heating for drying
Vessel_Rental_Costs(5) = dryer_rental_cost;
Labor_Costs(5) = dryer_labor_cost;
Materials_Credits(5,(1:5))= zeros(1,5);
Vessel_Occupancy(5) = drying_period + DryerTurn;    %  Total occupancy time of the reactor vessel, per batch

