function Results_Displayer
%  This function organizes the display of the simulation and economic results for the whole process.
%
%   INPUT Global Variables.
global  FigureNumber
global  ReactorHeater ReactionHeatingPeriod  AmountSolvent_S2
global  Reactor_feed  Reactor_effluent    
global  ReactorTimeVector   Reactor_dynamics   Reactor_effluent  
global  Solvent_S2  Extractor_Phase_1_exit_stream  Extractor_Phase_2_exit_stream 
global  Materials_Costs  Utilities_Costs  Vessel_Rental_Costs  Labor_Costs   Materials_Credits  
global  Materials_Prices   Materials_Properties
global  Crystal_phase_Coating_Liquid_from_crystallizer Crystal_phase_from_crystallizer Liquid_phase_from_crystallizer
global  Distillation_overhead_product  Distillation_bottoms_product
global  Vessel_Occupancy
global  Total_Materials_Cost  Total_Utilities_Cost  Total_Labor_Cost  Total_Rental_Costs  Total_Operating_Cost  
global  Total_Materials_Credits  Net_Operating_Cost  Cost_per_Kilogram_of_Product  Profit_per_Kilogram_of_Product
global  Vapor_stream_from_dryer  Crystal_stream_from_dryer
global  Number_of_batches_per_year  Annual_Materials_Cost  Annual_Utilities_Cost Annual_Labor_Cost Annual_Rental_Cost
global  Annual_Net_Operating_Cost  Annual_Production   Annual_Income   Annual_Profit 
%
disp('     ');
%
%   STEP-3(A):  DISPLAY THE VALUES OF THE OPTIMIZATION VARIABLES 
%
disp('    VALUES OF THE OPTIMIZATION VARIABLES');
fprintf(' Reactor Heater Output (KW/hr)           =   %f\n',ReactorHeater);
fprintf(' Reactor Heating Period (seconds)        =   %f\n',ReactionHeatingPeriod);
fprintf(' Amount of Extraction Solvent, S1 (m3)   =   %f\n\n\n',AmountSolvent_S2);
%   STEP-3(B):  DISPLAY THE PROCESS INFORMATION FOR A SINGLE BATCH OF
%               PRODUCTION. 
%
disp('    TABLE OF PROCESS STREAMS PER BATCH OF PRODUCTION');
disp('     ');
disp(['Process Stream                   Moles, A   Moles, B    Moles, P     Moles, Q     Moles, W     Moles, Z      Moles, C     Moles, S1     Moles, S2    Temperature']);
disp('---------------------------------------------------------------------------------------------------------------------------------------------------------------------');
fprintf('Reactor \n');
fprintf('      Feed                     %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n',Reactor_feed(1:10));
fprintf('      Effluent                 %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n',Reactor_effluent(1:10));
fprintf('Extractor \n');
fprintf('      Fresh Solvent, S2        %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f    %8.4f      %6.2f \n',Solvent_S2(1:10));
fprintf('      Solvent,S1-Phase         %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n',Extractor_Phase_1_exit_stream(1:10));
fprintf('      Solvent,S2-Phase         %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f    %8.4f      %6.2f \n',Extractor_Phase_2_exit_stream(1:10));
fprintf('Distillation \n');
fprintf('      Overhead                 %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n',Distillation_overhead_product(1:10));
fprintf('      Bottoms                  %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f    %8.4f      %6.2f \n',Distillation_bottoms_product(1:10));
fprintf('Crystallizer \n');
fprintf('      Crystal-Phase, Solid     %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n',Crystal_phase_from_crystallizer(1:10));
fprintf('      Crystal-Phase, Liquid    %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f      %8.6f      %6.2f \n',Crystal_phase_Coating_Liquid_from_crystallizer(1:10));
fprintf('      Liquid-Phase             %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f      %8.4f      %8.4f      %6.2f \n',Liquid_phase_from_crystallizer(1:10));
fprintf('Dryer \n');
fprintf('      Crystal-Phase(pure)      %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n',Crystal_stream_from_dryer(1:10));
fprintf('      Vapor-Phase              %8.4f     %8.4f   %8.4f     %8.4f     %8.4f     %8.4f      %8.4f        %8.4f      %8.4f      %6.2f \n\n\n',Vapor_stream_from_dryer(1:10));

end

