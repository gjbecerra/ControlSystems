%% Example 1: Tustin Discretization - Multiple Sample Times
zeta = 0.5; wn = 1;
Gs = tf(wn^2,[1 2*zeta*wn wn^2]);   % Continuous-time system G(s)
Tf = 12;                            % Final time for simulation
[ys,ts] = step(Gs,Tf);  % Computes step response for G(s)
Tvec = [2 1 0.5 0.1];   % Vector with different sample times T
figure(1), cla, hold on
plot(ts,ys,'LineWidth',3);          
for k = 1:length(Tvec)
    T = Tvec(k);
    z = tf('z',T);      % Defines the discrete time variable z
    s = (2/T)*((z-1)/(z+1));    % Defines the Tustin approximation
    Gz = wn^2 / (s^2 + 2*zeta*wn*s + wn^2); % Substitutes s in G(s)
    [yz,tz] = step(Gz,Tf);  % Computes step response for G(z)    
    stairs(tz,yz,'LineWidth',1.5);      % Plots the step responses
end
xlabel('Time [s]','FontSize',13)    % and sets labels and legends
ylabel('y(t)','FontSize',13)
legend('G(s)','G(z),T=2','G(z),T=1','G(z),T=0.5','G(z),T=0.1',...
       'Location','east','FontSize',12)
xlim([0 12]), ylim([0 1.25])
% exportgraphics(gcf,'../images/tustinStepRespDiffT.eps')