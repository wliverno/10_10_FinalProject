function TransientPlots(ReactorTimeVector,Reactor_dynamics)

%   This function plots molar amounts of the six chemicals and temperature, 
%   resulting from the simulation of the Batch reactor, as a function of
%   time.
%   It is called by the function, "Results_Displayer", if and only if the
%   user has indicated so.
%
global FigureNumber
% Make a plot showing the species molar amounts and temperature with time in the reactor
figure(FigureNumber); % Open a new figure for each set of plots
subplot(4,2,1), plot(ReactorTimeVector,Reactor_dynamics(:,1)), xlabel('time, sec'),ylabel('Reactant, A')
subplot(4,2,2), plot(ReactorTimeVector,Reactor_dynamics(:,2)), xlabel('time, sec'),ylabel('Reactant, B')
subplot(4,2,3), plot(ReactorTimeVector,Reactor_dynamics(:,3)), xlabel('time, sec'),ylabel('Product, P')
subplot(4,2,4), plot(ReactorTimeVector,Reactor_dynamics(:,4)), xlabel('time, sec'),ylabel('By-Product, Q')
subplot(4,2,5), plot(ReactorTimeVector,Reactor_dynamics(:,5)), xlabel('time, sec'),ylabel('Waste, W')
subplot(4,2,6), plot(ReactorTimeVector,Reactor_dynamics(:,6)), xlabel('time, sec'),ylabel('Waste, Z')
subplot(4,2,7), plot(ReactorTimeVector,Reactor_dynamics(:,10)-273), xlabel('time, sec'),ylabel('Temperature, C')
FigureNumber = FigureNumber+1;
%  Table of Moles,A versus time
% disp(['   Time' '        Temperature']);
% for k=1:length(ReactorTimeVector)
    % fprintf(' %7.3f       %6.3f\n',ReactorTimeVector(k),Reactor_dynamics(k,10));
% end