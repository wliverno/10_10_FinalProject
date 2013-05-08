function ReactorFeed
%   This function determines the composition and volume of the reacting mixture, before the reaction starts.
%
%   INPUT Global Variables.
global  Materials_Properties    %  Provided from the "Materials_Properties" function
global  ReactorVolume           %  Provided from the "ProcessUnitsParameters" function  
%   OUTPUT Global Variables
global  Reactor_feed  Reactor_feed_kilograms          %  Describes the composition, temperature, total mass, and volume of feed 
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


%   Compute the amounts (in kilograms and moles) of all the materials in the reactor feed.
%
Reactor_feed_kilograms(1) = volume_A*Materials_Properties(1,2);      %  Reactor feed:  Amount of A in kilograms.
Reactor_feed_kilograms(2) = volume_B*Materials_Properties(2,2);      %  Reactor feed:  Amount of B in kilograms.
Reactor_feed_kilograms(7) = volume_C*Materials_Properties(7,2);      %  Reactor feed:  Amount of C in kilograms.
Reactor_feed_kilograms(8) = volume_S1*Materials_Properties(8,2);     %  Reactor feed:  Amount of S1 in kilograms.
%
Reactor_feed(1) = 1000*Reactor_feed_kilograms(1)/Materials_Properties(1,1); % Reactor feed: Amount of A in g-moles.
Reactor_feed(2) = 1000*Reactor_feed_kilograms(2)/Materials_Properties(2,1); % Reactor feed: Amount of B in g-moles.
Reactor_feed(7) = 1000*Reactor_feed_kilograms(7)/Materials_Properties(7,1); % Reactor feed: Amount of C in g-moles.
Reactor_feed(8) = 1000*Reactor_feed_kilograms(8)/Materials_Properties(8,1); % Reactor feed: Amount of S1 in g-moles.
%
%   Add the following for vector consistency, despite the fact that the
%   Reactor Feed does not contain the chemicals, P,Q,W,Z, and Solvent S2.
%
Reactor_feed_kilograms(3) = 0;      %  Reactor feed:  Amount of P in kg.
Reactor_feed_kilograms(4) = 0;      %  Reactor feed:  Amount of Q in kg.
Reactor_feed_kilograms(5) = 0;      %  Reactor feed:  Amount of W in kg.
Reactor_feed_kilograms(6) = 0;      %  Reactor feed:  Amount of Z in kg.
Reactor_feed_kilograms(9) = 0;      %  Reactor feed:  Amount of Solvent,S2,in Kgs
Reactor_feed(3) = 0;   %  Reactor feed:  Amount of P in g-moles.
Reactor_feed(4) = 0;   %  Reactor feed:  Amount of Q in g-moles.
Reactor_feed(5) = 0;   %  Reactor feed:  Amount of W in g-moles.
Reactor_feed(6) = 0;   %  Reactor feed:  Amount of Z in g-moles.
Reactor_feed(9) = 0;   %  Reactor feed:  Amount of Solvent, S2, in g-moles.
%
%   Set the temperature, total kilograms, and total volume of the reactor feed.
Reactor_feed(10) = 298;    % in degrees, K.
Reactor_feed(11) = sum(Reactor_feed_kilograms); % Total mass of reactor feed,Kgs.
Reactor_feed(12) = total_volume_of_reacting_mixture; %  in cubic meters (m3).

disp('Visited ReactorFeed')

end

