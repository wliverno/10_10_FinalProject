function Set_Parameters
%   This function calls several other functions, which activate the assignment of values to the parameters associated with various components of the Project. Each of these other functions puts the saved values in the corresponding parameters of the project and makes them available to whatever function needs them through the appropriate GLOBAL characterization of the parameters.
%
%   INPUT Global Variables.  None
%   OUTPUT Global Variables.  None.
%
%   STEP-1(A):  Set the Physical Properties values for all materials in the Project.
MaterialsProperties;
%
%   STEP-1(B):  Set the values for all Properties of the three Chemical Reactions in the Project.
ReactionsProperties;
%
%   STEP-1(C):  Set the values for the various characteristics of the all the processing units in the process of the Project.
ProcessUnitsParameters;
%
%   STEP-1(D):  Set economic parameters
EconomicData;
%
%   STEP-1(E):  Set the characteristics of the Feed to the Reactor.
ReactorFeed;

end

