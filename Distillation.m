function Distillation
%   This function simulates the performance of the Batch Distillation and computes its associated economics.
%   It is called by the function "Simulator.m"
%
%   INPUT Global Variables
global  Materials_Properties            
global  DistillationTurn  Distillation_rental_cost_per_hour
global  Electricity_cost  Water_cooling_cost  Steam_heating_cost
global  Labor_unit_cost  
global  Extractor_Phase_2_exit_stream 
%   OUTPUT Global Variables
global  Utilities_Costs  Vessel_Rental_Costs  Labor_Costs   Materials_Credits  Materials_Prices
global  Distillation_overhead_product  Distillation_bottoms_product
global  Vessel_Occupancy
%
%   SIMULATION
%
distillation_feed = Extractor_Phase_2_exit_stream;
%   Description of Distillation Overhead stream
Distillation_overhead_product(1) = xxxxxxxxxxxxxxxxxxxx;    %  moles of A
Distillation_overhead_product(2) = xxxxxxxxxxxxxxxxxxxx;    %  moles of B
Distillation_overhead_product(9) = xxxxxxxxxxxxxxxxxxxxxx;  %  moles of S2
Distillation_overhead_product(3:8) = 0;     %  moles of P, Q, W, W, Z, C, S1
Distillation_overhead_product(10) = 298;    % temperature in degrees, C.
Distillation_overhead_product(11) = (Distillation_overhead_product(1:9)*Materials_Properties((1:9),1)/1e3);  %total amount in kilograms
%   Description of the Distillation Bottoms stream.
Distillation_bottoms_product(1) = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;    %  moles of A
Distillation_bottoms_product(2) = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;    %  moles of B  
Distillation_bottoms_product(9) = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;    %  moles of S2
Distillation_bottoms_product(3:8) = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;    %  moles of P, Q, W, W, Z, C, S1
Distillation_bottoms_product(10) = 458;    % temperature in degrees, C.
Distillation_bottoms_product(11) = (Distillation_bottoms_product(1:9)*Materials_Properties((1:9),1)/1e3);  %total amount in kilograms
%   Utilities
%   Heating duty in the reboiler.
heating_duty_for_sensible_heating = xxxxxxxxxxxxxxxxx;   %  in KJ.  Heat used to heat distillation feed from its temperature to 458 degrees Kelvin
heating_duty_for_vaporization = xxxxxxxxxxxxxxxxxxxxx;   %  in KJ.  Heat used to vaporize the moles of A,B, and S2, which go to the distillate stream 
total_heating_duty = heating_duty_for_sensible_heating + heating_duty_for_vaporization;                                

%   Cooling duty in the condenser.
cooling_duty_for_sensible_cooling = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; %  in KJ.  Heat removed during the cooling of the distillate from 458 to 298 degrees Kelvin 
total_cooling_duty = heating_duty_for_vaporization + cooling_duty_for_sensible_cooling       %  in KJ.  The cooling duty is equal to the amount of heating used for vaporization

%
%   Compute the Economics of the Distillation per batch.
%
distillation_period = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;   	% in hours
distillation_rental_cost = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;       		%  in $
distillation_heating_cost = (total_heating_duty) * (Steam_heating_cost);    	%  in $ 
distillation_cooling_cost = (total_cooling_duty) * (Water_cooling_cost);    	%  in $
%
%   Materials Credits
credit_from_recovered_A = ((Distillation_overhead_product(1)*Materials_Properties(1,1))/1e3) * Materials_Prices(1);   % $ of credit from recovered A
credit_from_recovered_B = ((Distillation_overhead_product(2)*Materials_Properties(2,1))/1e3) * Materials_Prices(2);   % $ of credit from recovered B
credit_from_recovered_S2= ((Distillation_bottoms_product(9)*Materials_Properties(9,1))/1e3) * Materials_Prices(9);    % $ of credit from recovered S2
%   Labor Cost 
distillation_labor_cost = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;    % in $
%
%   SUMMARY OF DISTILLATION ECONOMICS
%
Materials_Costs(3,(1:5)) = 0 ;  
Utilities_Costs(3,(1:7)) = 0;           
Utilities_Costs(3,3) = distillation_cooling_cost;
Utilities_Costs(3,4) = distillation_heating_cost ;
Vessel_Rental_Costs(3) = distillation_rental_cost;
Labor_Costs(3) = distillation_labor_cost;
Materials_Credits(3,1)= credit_from_recovered_A;
Materials_Credits(3,2)= credit_from_recovered_B;
Materials_Credits(3,(3:4)) = 0;     		%  No credit for C,and S1, since none has been recovered
Materials_Credits(3,5)= credit_from_recovered_S2;
Vessel_Occupancy(3) = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;    	%  Total occupancy time of the distillation system, per batch

disp('Visited Distillation')

end

