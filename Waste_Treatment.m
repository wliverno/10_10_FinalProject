function Waste_Treatment
%
%   10.10 Project.  Spring 2003.
%   Prepared by George Stephanopoulos.
%
%   This function simulates the performance of the Batch Crystallizer and computes its associated economics.
%   It is called by the Project XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%
global  Vapor_stream_from_dryer  
global  Liquid_phase_from_crystallizer
global  Liquid_waste_treatment_cost  Vapor_waste_treatment_cost
global  Utilities_Costs
global  Materials_Costs  Vessel_Rental_Costs  Labor_Costs   Materials_Credits  Overhead
global  Materials_Properties %  This matrix contains the physical properties of all materials in the process


%
%   Define feed streams to the Waste treatment Unit
Liquid_feed = Liquid_phase_from_crystallizer;
Vapor_feed  = Vapor_stream_from_dryer ;
%
%   Cost of treating liquid wastes
liquid_amount = Liquid_feed(1:9)*Materials_Properties((1:9),1)/1000;    % in Kilograms
liquid_wastes_treatment_cost = liquid_amount * Liquid_waste_treatment_cost;
%   Cost of treating vapor wastes
vapor_amount = Vapor_feed(1:9)*Materials_Properties((1:9),1)/1000;  %  in Kilograms
vapor_wastes_treatment_cost = liquid_amount * Vapor_waste_treatment_cost;
%
Materials_Costs(6,(1:5)) = 0;
Utilities_Costs(6,(1:6)) = 0;
Utilities_Costs(6,7) = liquid_wastes_treatment_cost + vapor_wastes_treatment_cost;
Labor_Costs(6) = 0;
Vessel_Rental_Costs(6) = 0;

