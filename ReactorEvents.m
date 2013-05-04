function [value,isd,dir]=ReactorEvents(t,Y,P,K)

%   This function stops the ode45 integration of the differential equations
%   in the file, reactions.m, when the temperature in the reactor reaches the ReactorCoolTemp(C).
%   It is called by the function, Reactor.m, which simulates the Batch Reactor.
%
%
global  ReactorCoolTemp
%
%   Check if the reactor temperature has reached the final temperature, ReactorCoolTemp(C).
value = Y(10)-(ReactorCoolTemp+273);  % Set this difference equal to zero.  Here, it would return tvec2 and Y2 when Y2=303
%
isd = 1;  % This switch determines whether ode45 stops once it reaches the 'event'.
% Since we'd like it to stop, we'll set this to 1, implying that the switch is ON.
%
dir = -1;  % This switch determines the direction from which we approach our zero.
% Since we want to detect cooling we will set it to -1 to detect when it has cooled to ReactorCoolTemp.