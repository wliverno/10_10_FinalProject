function ProcessUnitsParameters
%   This function sets the parametric values for the various processing
%   units in the process of the Project.  Makes these values available to
%   other MatLab functions through the command, GLOBAL.
%
%   INPUT Global Variables
%   OUTPUT Global Variables
global  ReactorVolume ReactorStir ReactorCool ReactorTurn  ReactorCoolTemp  TimeReactorCool        
global  ExtractorVolume  ExtractorTurn  ExtractorStir
global  DistillationTurn   DistillationVolume
global  CrystallizerVolume  CrystallizationStir  CrystallizationTurn  CrystallizerCool
global  DryerTurn  DryerHeatingPower
%
%   Set the parametric values for the Batch Reactor
%
ReactorVolume = 2;          % reactor filling volume in cubic meters (m3)
ReactorStir = 5;            % Reactor stirring power, KW
ReactorCool = 20;           % Reactor water cooling heat transfer coeficient, KW/(degree C).
ReactorTurn = 3;            % Reactor turn around time, hr
ReactorCoolTemp = 25;       % Temperature to which the reactor is to be cooled at the end of the batch
TimeReactorCool = 2000;     % Time that the reactor cooling is on, seconds

%   Set the parametetric values for the Batch Extractor
%
ExtractorVolume = 6;            % extractor filling volume in cubic meters (m3).
ExtractorTurn = 2;              % Extractor turn around time, in hours.
ExtractorStir = 5;              % Extractor stirring power, KW
%
%   Set the parametetric values for the Batch Distillation system
%
DistillationVolume = 6;         % distillation volume in cubic meters (m3).
DistillationTurn = 3;           % Distillation turn around time, in hours
%
%   Set the parametetric values for the Batch Crystallizer
%
CrystallizerVolume = 4;         % Volume of the crystallization vessel, in cubic meters (m3).
CrystallizationStir = 3;        % Crystallization vessel stirring power, KW
CrystallizationTurn = 2;        % Crystallizer's turn around time, in hours.
CrystallizerCool = 10;          % Capacity of the refrigeration-based cooling, KW.
%
%   Set the parametetric values for the Batch Dryer
%
DryerTurn = 2;              % Dryer's turn around time, in hours.
DryerHeatingPower = 1.5;    % Heating power of the dryer, in KW 
%
%   No parameters for the Waste Treatment system

disp('Visited ProcessUnitsProperties')

end

