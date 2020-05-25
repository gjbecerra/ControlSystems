%% State feedback and observation
% Run first the scripts stateFeedbackRegulator.m and stateObservation.m
% try close(1); catch warning('Figure 1 already closed'); end
Tf = 2; x0 = [2; 5; -1];
% Runs simulation for control law u(t) = -Kx̂(t)
simResults = sim('stateFeedbackRegulatorObservationSim');

figure(2), set(gcf, 'Position',  [100, 200, 800, 550])
subplot(15,1,[1 5]), cla, hold on
plot(simResults.logsout{1}.Values.Time,...
     simResults.logsout{1}.Values.Data,...
     'LineWidth',2)
plot(simResults.logsout{4}.Values.Time,...
     simResults.logsout{4}.Values.Data,...
     'LineWidth',1.5,'LineStyle','--')
ylabel('x_1(t)')
legend('x_1(t)','x̂_1(t)','Location','east','FontSize',11)
grid on, set(gca,'Xticklabel',[])
%
subplot(15,1,[6 10]), cla, hold on
plot(simResults.logsout{2}.Values.Time,...
     simResults.logsout{2}.Values.Data,...
     'LineWidth',2)
plot(simResults.logsout{5}.Values.Time,...
     simResults.logsout{5}.Values.Data,...
     'LineWidth',1.5,'LineStyle','--')
ylabel('x_2(t)')
legend('x_2(t)','x̂_2(t)','Location','east','FontSize',11)
grid on, set(gca,'Xticklabel',[])
%
subplot(15,1,[11 15]), cla, hold on
plot(simResults.logsout{3}.Values.Time,...
     simResults.logsout{3}.Values.Data,...
     'LineWidth',2)
plot(simResults.logsout{6}.Values.Time,...
     simResults.logsout{6}.Values.Data,...
     'LineWidth',1.5,'LineStyle','--')
ylabel('x_3(t)'), xlabel('Tiempo [s]')
legend('x_3(t)','x̂_3(t)','Location','east','FontSize',11)
grid on
% exportgraphics(gcf,'../images/stateFeedbackRegulatorObservation2.eps')
