function [F] = Overall_Process_Economic_Objective(X)
%
%   Prepared by George Stephanopoulos.
%
%   This function directs the computation of the "Net Operating Cost", 
%   which is the economic metric that we use to optimize the operation 
%   of the overall process.
%   In addition, it computes the values of other economic parameters, which
%   are used to inform the chemical engineer of the distribution of costs
%   in the process.
%
%   INPUT Variables
%       X---- is the vector of values of the three optimization variables:
%           X(1) = The power output of the heater used in the ractor (KW)
%           X(2) = The period of heating of the reacting mixture (seonds)
%           X(3) = The amount of of Solvent, S2, used in the extractor (m3)
%   INPUT Global Variables
global  Overhead  Annual_operating_period
global  Materials_Costs  Utilities_Costs  Labor_Costs  Vessel_Rental_Costs  Materials_Prices  Materials_Credits
global  Materials_Properties
global  Crystal_phase_from_crystallizer
global  Vessel_Occupancy
%   OUTPUT Global Variables.  They are used by the function
%   "Results_Displayer" for printing purposes
global  Total_Materials_Cost  Total_Utilities_Cost  Total_Labor_Cost  Total_Rental_Costs  Total_Materials_Credits
global  Total_Operating_Cost  Net_Operating_Cost  Cost_per_Kilogram_of_Product   Profit_per_Kilogram_of_Product
global  Number_of_batches_per_year  Annual_Materials_Cost  Annual_Utilities_Cost  Annual_Labor_Cost  Annual_Rental_Cost
global  Annual_Net_Operating_Cost  Annual_Production  Annual_Income  Annual_Profit 
%
ReactorHeater = X(1);
ReactionHeatingPeriod = X(2);
AmountSolvent_S2 = X(3);
%
%   Use the following conditions to prevent the violation of certain
%   constraints
if ReactionHeatingPeriod<= 0 | ReactorHeater<=0 | AmountSolvent_S2<=0   %   Physical constraints;  
    %   These quantities cannot be negative.
    %   Set the value of the objective artificially high, in order to 
    %   prevent the optimizer from violating the above constraints.
    F = 1e25;                               
    return
end
if AmountSolvent_S2 > 4
    %   Set the value of the objective artificially high, in order to
    %   prevent the optimizer from violating the above constraints.
    F = 1e25;
    return
end
if ReactorHeater > 500  %   The reactor heater has a maximum output of 500 KW
    %   Set the value of the objective artificially high, in order to
    %   prevent the optimizer from violating the above constraints.
    F = 1e25;
    return
end
%   
%   EVALUATION OF THE OVERALL PROCESS ECONOMICS, PER BATCH
%
Total_Materials_Cost = sum(Materials_Costs(1,(1:5))) + sum(Materials_Costs(2,(1:5)));
%
%   Materials_Costs(i,j) is a matrix.  The first index, i, indicates the
%   processing unit, and the second index, j, indicates one of the
%   materials used in the process:
%       Index, i:
%               i = 1.  Batch Reactor
%               i = 2.  Batch Extractor
%               i = 3.  Batch Distillation.
%               i = 4.  Batch Crystallizer
%               i = 5.  Dryer
%               i = 6.  Waste Treatment unit.
%       Index, j:
%               j = 1.  Reagent, A
%               j = 2.  Reagent, B
%               j = 3.  Catalyst, C.
%               j = 4.  Solvent, S1.
%               j = 5.  Solvent, S2.
%   So,     Materials_Costs(1,1) = cost of reagent, A, used in the Batch Reactor, and
%           Materials_Costs(2,5) = cost of Solvent, S2, used in the Batch  Extractor.
%
a = sum(Utilities_Costs((1:6),1))+sum(Utilities_Costs((1:6),2))+sum(Utilities_Costs((1:6),3));
b = sum(Utilities_Costs((1:6),4))+sum(Utilities_Costs((1:6),5))+sum(Utilities_Costs((1:6),6)+sum(Utilities_Costs((1:6),7)));
Total_Utilities_Cost = a + b;
%
%   The matrix, Utilities_Costs(i,j) indicates the cost of the j-th type of
%   utility used in the i-th processing unit.
%       Index, i:  See above.
%       Index, j:
%               j = 1.  Electricity used for heating.
%               j = 2.  Electricity used for stirring.
%               j = 3.  Water cooling.
%               j = 4.  Steam heating.
%               j = 5.  Refrigeration cooling.
%               j = 6.  Fuel-based heating.  Used in the dryer.
%               j = 7.  Treatment of wastes.
%
Total_Labor_Cost = sum(Labor_Costs(1:6));
Total_Rental_Costs = sum(Vessel_Rental_Costs(1:6));
%
%   Labor_Costs(i) and Vessel_Rental_Costs(i) are two vectors indicating
%   the labor cost and vessel-rental cost of the processing unit, i.  The
%   index, i, has the same values as indicated above.
%
Total_Operating_Cost = (Total_Materials_Cost + Total_Utilities_Cost + Total_Labor_Cost + Total_Rental_Costs);
Total_Materials_Credits = sum(Materials_Credits(3,(1:5)));
%
%   The matrix, Materials_Credits(i,j), indicates the credit given to unit,
%   i, for the recovery of material, j.  The values of indices, i and j, have the same
%   meaning as for the matrix, Materials_Costs(i,j), see above.
%
Net_Operating_Cost = (1/Overhead)*(Total_Operating_Cost - Total_Materials_Credits);
Cost_per_Kilogram_of_Product = Net_Operating_Cost/(Crystal_phase_from_crystallizer(3)*Materials_Properties(3,1)/1000);
Profit_per_Kilogram_of_Product = Materials_Prices(3) - Cost_per_Kilogram_of_Product;
%
%   EVALUATION OF THE OVERALL PROCESS ECONOMICS, ANNUAL BASIS
%
%   Estimate the number of batches per year, by dividing the
%   Annual_operating_period by the maximum vesel occupancy period by a unit
%   in the process.  This unit with the maximum occupancy period determines
%   the critical time-period for a complete batch.
time = max(Vessel_Occupancy(1:4));      %  Determine the critical occupancy period.                       
Number_of_batches_per_year = Annual_operating_period/time;
%
%   Compute the various Cost Components on an annual basis
Annual_Materials_Cost   = (Total_Materials_Cost - Total_Materials_Credits)* Number_of_batches_per_year;
Annual_Utilities_Cost   = Total_Utilities_Cost * Number_of_batches_per_year;
Annual_Labor_Cost       = Total_Labor_Cost * Number_of_batches_per_year;
Annual_Rental_Cost      = Total_Rental_Costs * Number_of_batches_per_year;
Annual_Net_Operating_Cost = Net_Operating_Cost * Number_of_batches_per_year;
Annual_Production       = ((Crystal_phase_from_crystallizer(3)*Materials_Properties(3,1))/1000) * Number_of_batches_per_year;
Annual_Income           = Annual_Production * Materials_Prices(3);
Annual_Profit           = Profit_per_Kilogram_of_Product * Annual_Production;
%
F =  - Annual_Profit;   %  The Annual_Profit is our economic objective to maximized (or, its negative minimized)
%

end

