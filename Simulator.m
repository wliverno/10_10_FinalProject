function F = Simulator(X)
%  This function directs the sequential simulation of the processing units in the process.
%   INPUT.   
%       X  ----  Vector of Optimization Variables
%               X(1) = ReactorHeater
%               X(2) = ReactionHeatingPeriod
%               X(3) = AmountSolvent_S2
%   OUTPUT Global Variables
global  ReactorHeater ReactionHeatingPeriod  AmountSolvent_S2
%   OUTPUT  F ----  The value of the Net Operating Profit
%
ReactorHeater = X(1);
ReactionHeatingPeriod = X(2);
AmountSolvent_S2 = X(3);
% 
% Simulate the Process

Reactor; %................   STEP-2(A)-1:  Simulate Batch Reactor
% Extractor; %..............   STEP-2(A)-2:  Simulate the Batch Extractor
% Distillation; %...........   STEP-2(A)-3:  Simulate the Batch Distillation
% Crystallizer; %...........   STEP-2(A)-4:  Simulate the Batch Crystallizer
% Dryer; %..................   STEP-2(A)-5:  Simulate the Batch Batch Dryer
% Waste_Treatment; %........   STEP-2(A)-6:  Simulate the Waste Treatment Unit

F = Overall_Process_Economic_Objective(X); %   STEP-2(A)-7:  Compute Process Economics
end

