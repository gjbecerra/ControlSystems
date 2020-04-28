%% Example 1: Backward Discretization
zeta = 0.5; wn = 1;
Gs = tf(wn^2,[1 2*zeta*wn wn^2]);   % Continuous-time system G(s)
Tf = 12;                            % Final time for simulation
[ys,ts] = step(Gs,Tf);  % Computes step response for G(s)
T = 1;                  % Sample time T = 1 second
z = tf('z',T);          % Defines the discrete time variable z
s = (z-1)/(z*T);        % Defines the backward approximation
Gz = wn^2 / (s^2 + 2*zeta*wn*s + wn^2); % Substitutes s in G(s)
[yz,tz] = step(Gz,Tf);  % Computes step response for G(z)
figure(1), cla, hold on
plot(ts,ys,'LineWidth',3);          
stairs(tz,yz,'LineWidth',1.5);      % Plots the step responses
xlabel('Time [s]','FontSize',13)    % and sets labels and legends
ylabel('y(t)','FontSize',13)
legend('G(s)','G(z)','Location','east','FontSize',13)
xlim([0 12]), ylim([0 1.25])
% exportgraphics(gcf,'../images/backwardStepResp.eps')