%% State observation - Example 1
A = [0 1 0; 0 0 1; -2 -3 -5];
B = [0; 0; 1];
C = [1 0 0];
D = 0;

% Check if rank(Po) = 2 (system is observable):
rank(obsv(A,C))

%% Desired characteristic equation:
PO = 5; Ts = 1;
syms zeta wn
zeta = double(solve(PO == 100*exp(-pi*zeta/sqrt(1-zeta^2))));
zeta = zeta(1);
wn = 4/(zeta*Ts);
syms L1 L2 L3 lambda
Dd = double(flip(coeffs((lambda^2 + 2*zeta*wn*lambda + wn^2)*(lambda + 10*zeta*wn), lambda)))
L = [L1; L2; L3];
roots(Dd)

% Actual characteristic equation:
Da = flip(coeffs(det(lambda*eye(3) - (A - L*C)),lambda));
Soln = solve(Dd == Da);
L1 = double(Soln.L1);
L2 = double(Soln.L2);
L3 = double(Soln.L3);
L = [L1; L2; L3];

% Observer simulation
% try close(1); catch warning('Figure 1 already closed'); end
Tf = 4; x0 = [1; 1; 1];
simResults = sim('stateObservationSim');
%
figure(1), set(gcf, 'Position',  [1000, 200, 800, 550])
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
% exportgraphics(gcf,'../images/stateObservationStepInitial.eps')
