%% State Feedback with Reference Tracking
A = [0 1 0; 0 0 1; -2 -3 -5];
B = [0; 0; 1];
C = [1 0 0];
D = 0;

Ae = [A zeros(3,1); -C 0];
Be = [B; 0];

%% Design requirements
% Controlability
clc
rank(ctrb(Ae,Be))
p_des = [-0.8+0.839, -0.8-0.839, -8 -10]
Ke = place(Ae,Be,p_des)
K = Ke(1:3);
ka = Ke(4);

%% Simulink test
try close(1); catch warning('Figure 1 already closed'); end
Tf = 100; x0 = [0; 0; 0];
refval = 1; tstep = 10;
simResults = sim('stateFeedbackTrackingSim');
figure(1), set(gcf, 'Position',  [100, 200, 800, 550])
subplot(15,1,[1 5]), cla, hold on
plot(simResults.state{1}.Values.Time,...
     simResults.state{1}.Values.Data(:,1),...
     'LineWidth',2)
plot(simResults.reference{1}.Values.Time,...
     simResults.reference{1}.Values.Data,...
     'LineWidth',2,'LineStyle','--')
ylabel('x_1(t)')
legend('x_1(t)','x_1^{ref}','Location','east')
grid on, set(gca,'Xticklabel',[])
subplot(15,1,[6 10]), cla, hold on
plot(simResults.state{1}.Values.Time,...
     simResults.state{1}.Values.Data(:,2),...
    'LineWidth',2)
ylabel('x_2(t)')
legend('x_2(t)','Location','east')
grid on, set(gca,'Xticklabel',[])
subplot(15,1,[11 15]), cla, hold on
plot(simResults.state{1}.Values.Time,...
     simResults.state{1}.Values.Data(:,3),...
     'LineWidth',2)
ylabel('x_3(t)'), xlabel('Tiempo [s]')
legend('x_3(t)','Location','east')
grid on
% exportgraphics(gcf,'../images/stateFeedbackTrackingStep.eps')

