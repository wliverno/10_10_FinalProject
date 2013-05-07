function dYdt=Reactions(t,Y,P)
% 
%   This function provides the values of the derivatives of the batch reactor mass and energy balances.
%   It is called by the MatLab Integration routine,  ode45.m, from the function, Reactor.m
%
%   INPUTS
%       Y -- [molesA, molesB, molesP, molesQ, molesW, molesZ, molesC, molesS1, molesS2, T_Reactor, total moles, total volume]
%       P -- [heat_on, cooling_on] ;  
%                           If heat_on > 0, then the reactor heater is on.
%                           If cooling_on > 0, then the reactor cooler is on.
%   INPUT Global Variables
global  Materials_Properties                         %  This matrix contains the physical properties of all materials in the process
global  Reactions_Properties                        %  This matrix contains the properties of the three reactions in the process
global  Reactor_feed                                     % Characteristics of the reactor feed
global  ReactorVolume  ReactorCool  ReactorCoolTemp ReactorStir  ReactorHeater 
%
%   OUTPUTS
%       dYdt -- Vector of derivatives of moles of species and temperature in the reactor
%   OUTPUT Global Variables. None
%
%   Assign Reaction properties to Local Variables
Reaction1PreExp = Reactions_Properties(1,1);
Reaction1Eact     = Reactions_Properties(1,2);
HeatRxn1             = Reactions_Properties(1,3);
Reaction2PreExp = Reactions_Properties(2,1);
Reaction2Eact      = Reactions_Properties(2,2);
HeatRxn2              = Reactions_Properties(2,3);
Reaction3PreExp = Reactions_Properties(3,1);
Reaction3Eact     = Reactions_Properties(3,2);
HeatRxn3            = Reactions_Properties(3,3);
dYdt = zeros(12,1); 		% Zero vector for integration
%
%   Set Concentration for each chemical species
volcm = ReactorVolume * (100^3); % cm^3
conc_A   = Y(1)/volcm; 	% moles of A /cm3
conc_B   = Y(2)/volcm; 	% moles of B /cm3
conc_P   = Y(3)/volcm; 	% moles of P /cm3
conc_Q   = Y(4)/volcm; 	% moles of Q /cm3
conc_W   = Y(5)/volcm;	% moles of W /cm3
conc_Z   = Y(6)/volcm; 	% moles of Z/cm3 
conc_C   = Y(7)/volcm;                        	% moles/cm3 of Catalyst, C;  This stays constant
conc_S1  = Y(8)/volcm;                         	% moles/cm3 of Solvent, S1;  This stays constant
conc_S2  = 0;                        		% moles/cm3 of Solvent, S2;  This is not present
T        = Y(10);                    		% Set temperature
%
H(1) = HeatRxn1;                     		% Set the vector containing the heats of the three reactions
H(2) = HeatRxn2;
H(3) = HeatRxn3;
H = H';
%
rate    = zeros(1,3);                 		 % Zero differentials
%
%	As rate(i)  we signify the total production rate of a product by reaction-i, e.g. (rate of reaction-i)*(reactor volume)
R = 8.314e-3; % kJ/mol*K
rate(1) = Reaction1PreExp * exp(-Reaction1Eact/(R * T)) * conc_A * (conc_B^2); 	% Compute total rate of reaction 1
rate(2) = Reaction2PreExp * exp(-Reaction2Eact/(R * T)) * (conc_P^2);               	% Compute total rate of reaction 2
rate(3) = Reaction3PreExp * exp(-Reaction3Eact/(R * T)) * (conc_P^3);               	% Compute total rate of reaction 3
%   Formulate the Material Balances for the Batch reactor
dYdt(1)= -rate(1)*volcm;
dYdt(2)= -2*rate(1)*volcm;
dYdt(3)= (rate(1) - (2*rate(2)) - (3*rate(3)))*volcm;
dYdt(4)= 0.25*rate(1)*volcm;
dYdt(5)= rate(2)*volcm;
dYdt(6)= rate(3)*volcm;
dYdt(7)= 0;              % change in moles/cm3 of Catalyst, C;  This stays constant
dYdt(8)= 0;              % change in moles/cm3 of Solvent, S1;  This stays constant
dYdt(9)= 0;              % change in moles/cm3 of Solvent, S2;  S2 is not present.
dYdt(11)=0;             % There  is no change in the total mass, i.e. Kilograms, of the reacting mixture.
component_mass = dYdt(1:9).* Materials_Properties((1:9),1)/1e3;    		%   in kilograms
component_volume = component_mass./Materials_Properties((1:9),2);      		%   in m3.
dYdt(12)= sum(component_volume(1:9));                                			% change in total volume, m3.
%
%   Formulate the Energy Balance for the Batch Reactor
%
%   The Energy Balance has the following form:
%   d(mass in the reactor*heat capacity*temperature)/dt = (work of the stirrer) 
%       + (heat exchanged with the surroundings) 
%       - (sum of heats consumed by the three endothermic reactions)
% energy conservation equation
%
mass_of_reacting_mixture = Reactor_feed(11);    		% in Kilograms
total_heat_capacity_reacting_mixture = (mass_of_reacting_mixture) *Materials_Properties(8,3);  
					%  assumed that heat capacity is the same as of Solvent S1.
%
%   Qdot:  Heat exchanged with surrounding environment
%   If the Reactor Heater is ON and Water-Cooling is OFF, then Qdot is given by the following equation.   
if(P(1)>0)                              		% i.e. the reactor heater is on
    Qdot = ReactorStir + (ReactorHeater / 3600);                   	% Add stirrer energy to heater energy, when heater is on, KW
end
%   If Reactor Water-Cooling system is ON and the Reactor Heater is OFF, then Qdot is given by the following equation.
ReactorCoolTempK = ReactorCoolTemp + 273;
if(P(2)>0)                              
    Qdot =  ReactorStir - (ReactorCool * (T - ReactorCoolTempK));   	% Add stirrer energy to cooler when it is on, KW
end
%
%    Total heat rate produced by the three exothermic reactions
DH = rate * H;
%
%   Complete Energy Balance and compute the derivative of temperature with time
dYdt(10)= (1/total_heat_capacity_reacting_mixture)* (DH + Qdot); 