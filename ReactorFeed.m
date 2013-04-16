function ReactorFeed
%
%   10.10 Project.  Spring 2013.
%   Prepared by George Stephanopoulos.
%
%   This function determines the composition and volume of the reacting mixture, before the reaction starts.
%
%   INPUT Global Variables.
global  Materials_Properties    %  Provided from the "Materials_Properties" function
global  ReactorVolume           %  Provided from the "ProcessUnitsParameters" function  
%   OUTPUT Global Variables
global  Reactor_feed            %  Describes the composition, temperature, total mass, and volume of feed 
%
%   Basic assumptions:
%  (a)  Total Volume of Reacting Mixture = (Volume of Solvent,S1) + (Volume of A) + (Volume of B) + (Volume of C).
%  (b)  (Volume of C) = (Volume of A) 
%  (c)  (Volume of Solvent,S1) = 10*[(Volume of A) +   (Volume of B)]
%  (d)  The molar amounts of A and B in the mixture are in their stoichiometric ratio. 
%  (e)  Total Volume of Reacting Mixture = Capacity of the reactor vessel. This requirement will maximize the amount of the desired product per batch.
%
%   Compute the amounts of the required A, B, C, and Solvent-S1.
%
total_volume_of_reacting_mixture = ReactorVolume;   %  This satisfies requirement (e), above.
%
%       Note:  Requirement (d), above, implies the following relationship between volume_A and volume_B:  
%       (volume_B/volume_A) = 2*(MW_B/MW_A)*(density_A/density_B)
a = 2*(Materials_Properties(2,1)/Materials_Properties(1,1))*(Materials_Properties(1,2)/Materials_Properties(2,2));
volume_A = (total_volume_of_reacting_mixture)/(12 + 11*a);
volume_B = volume_A*a;
volume_C = volume_A;
volume_S1= 10*(volume_A + volume_B);

