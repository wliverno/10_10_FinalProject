function EconomicData
%  This function prepares the economic data and makes them available
%  through global variables to all the routines that use them
%
%   INPUT Global Variable.  None.
%   OUTPUT Global Variables
global  Overhead  Annual_operating_period
global  Electricity_cost  Water_cooling_cost  Steam_heating_cost  Refrigeration_cooling_cost  Dryer_heating_cost
global  Liquid_waste_treatment_cost  Vapor_waste_treatment_cost
global  Labor_unit_cost  
global  Extractor_rental_cost_per_hour  Reactor_rental_cost_per_hour  Distillation_rental_cost_per_hour  
global  Crystallizer_rental_cost_per_hour  Dryer_rental_cost_per_hour
global  Materials_Prices
%
%   Annual Operating Period
Annual_operating_period = 4000;     % Hours of operation per year
%
%   Overhead
Overhead = 0.5;             % 50% overhead to the total production cost
%
%   Labor Cost
Labor_unit_cost = 100;      % In $ per hour, including labor-associated overhead.

%   Utilities
Water_cooling_cost = 0.0001;        % Cost of water cooling, $/kJ of heat removed
Electricity_cost = 2.5;             %  Cost of electricity, $/kw-hr (used for heating and the stirrer)
Dryer_heating_cost = 0.10;          % $ per KJ of heat supplied
Steam_heating_cost = 0.03;          % $ per KJ of heat supplied
Refrigeration_cooling_cost = 0.008; % $ per KJ of heat removed
%
%   Vessel rental costs
Reactor_rental_cost_per_hour = 3000;          % Rental cost for the reactor vessel,  $ per hour of use
Extractor_rental_cost_per_hour = 3000;        % Rental cost for the extractor vessel,  $ per hour of use    
Distillation_rental_cost_per_hour = 6000;     % Rental cost for the distillation system, $ per hour of use
Crystallizer_rental_cost_per_hour = 5000;     % Rental cost for the crystallizer vessel, $ per hour of use
Dryer_rental_cost_per_hour = 3000;            % Rental cost for the dryer system,  $ per hour of use
%
%   Materials_Prices
Materials_Prices(1) = 500;          %  price of reagent, A, $/Kg
Materials_Prices(2) = 2000;         %  price of reagent, B, $/Kg
Materials_Prices(3) = 20000;        %  price of product, P, $/Kg
Materials_Prices(4) = 0;            %  price of by-product, Q, $/Kg
Materials_Prices(5) = 0;            %  price of waste, W, $/Kg
Materials_Prices(6) = 0;            %  price of waste, Z, $/Kg
Materials_Prices(7) = 1000;         %  price of catalyst, C, $/Kg
Materials_Prices(8) = 10;           %  price of Solvent, S1, $/Kg
Materials_Prices(9) = 30;           %  price of Solvent, S2, $/Kg
%
%   Waste treatment Costs
Liquid_waste_treatment_cost = 2;    %  $ per Kilogram of liquid waste
Vapor_waste_treatment_cost = 0.5;   %  $ per Kilogram of vapor waste

disp('Visited EconomicData')

end

