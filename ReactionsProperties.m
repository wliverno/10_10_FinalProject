function ReactionsProperties
%
%  10.10 Project.  Spring 2013.
%  Prepared by George Stephanopoulos.
%
%   This function assigns the values of various properties of the 3 reactions,onto the elements of a matrix, and makes the matrix available to all other functions as a GLOBAL variable.
%
%   The name of the matrix is:  Reactions_Properties(i,j).
%       The first index signifies the reaction, i.e.
%           i = 1, signifies the main reaction, A + 2B = P + (1/4)Q
%           i = 2, signifies the first of the side reactions, 2P = W
%           i = 3, signifies the second of the side reactions, 3P = Z
%       The second index signifies the specific property value of the 
        corresponding reaction, i.e.
%           j = 1, Pre-exponential factor;  
%           j = 2, Activation Energy of the reaction; KJ/mol
%           j = 3, Heat of reaction;  KJ/mol
%   INPUT Global variables.  None
%   OUTPUT Global Variables
%
global  Reactions_Properties  % This matrix contains the properties of the three reactions in the process
%
%   Assign property values for the various reactions
%
%   Properties of the Main Reaction, Reaction-1
%
%   Estimate kinetic parameters for Reaction-1 through regression
[parameters] = KineticsRegression;  %  Use the "Kineticsregression" function to estimate the kinetic parameters
Reactions_Properties(1,1) = parameters(1); % Estimate of the pre-exponential constant, in:(cm3)^2/(second,(moles)^2)
Reactions_Properties(1,2) = parameters(2)/1000; %  estimate of the activation energy, in KJ/mole
Reactions_Properties(1,3) = 30;  %  in KJ/moles
%   Properties of the First Side-Reaction, Reaction-2
%
Reactions_Properties(2,1) = 1000;               %  in  (cm3)/(second, mole)
Reactions_Properties(2,2) = 20;                 %  in KJ/moles
Reactions_Properties(2,3) = 20;                 %  in KJ/moles
%
%   Properties of the Second Side-Reaction, Reaction-3
%
Reactions_Properties(3,1) = 500;                %  in (cm3)^2/(second, (moles)^2)
Reactions_Properties(3,2) = 20;                 %  in KJ/moles
Reactions_Properties(3,3) = 10;                 %  in KJ/moles
