%% Example 5: Digital Control Synthesis
% try close 1
% catch warning('Figure 1 is already closed.')
% end
s = tf('s');
G = 0.8/((30*s+1)*(13*s+1)*(3*s+1));
[num,den] = tfdata(G,'v');
Kp = 14.029;
Ti = 13.5593;
Td = 12.5;
Gc = Kp*(1 + 1/(Ti*s) + Td*s);
Gcl = feedback(Gc*G,1);
[ycl,tcl] = step(Gcl,120);
figure(1), cla, hold on
plot(tcl,ycl,'LineWidth',2);          
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
title('')
set(gcf, 'Position',  [100, 200, 800, 550])
% exportgraphics(gcf,'../images/stepRespPIDCont.eps')

%% PID Backward Discretization - Comparison for different sample times
% try close 1
% catch warning('Figure 1 is already closed.')
% end
Tvec = [2 1 0.5 0.1];
figure(1), cla, hold on
for k = 1:length(Tvec)
    T = Tvec(k);
    z = tf('z',T);          % Defines the discrete time variable z
    s = (z-1)/(z*T);        % Defines the backward approximation
    Gback = Kp*(1 + 1/(Ti*s) + Td*s);
    [num_back,den_back] = tfdata(Gback,'v');
    
    % Runs Simulink Model
    out = sim('digitalControlBackwardSim');
    
    % Plots the simulation results
    if k == 1
        plot(out.y_cont.time,out.y_cont.data,'LineWidth',4);
    end
    plot(out.y_back.time,out.y_back.data,'LineWidth',1.5);
end
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
title('Backward Discretization')
legend('Cont PID','Disc PID, Ts=2','Disc PID, Ts=1',...
       'Disc PID, Ts=0.5','Disc PID, Ts=0.1',...
       'Location','east','FontSize',11)
ylim([0 1.4])
set(gcf, 'Position',  [100, 200, 800, 550])
exportgraphics(gcf,'../images/stepRespPIDComparBackward.eps')

%% PID Tustin Discretization - Comparison for different sample times
% try close 1
% catch warning('Figure 1 is already closed.')
% end
Tvec = [2 1 0.5 0.1];
figure(1), cla, hold on
for k = 1:length(Tvec)
    T = Tvec(k);
    z = tf('z',T);          % Defines the discrete time variable z
    s = (2/T)*((z-1)/(z+1));    % Defines the Tustin approximation
    Gback = Kp*(1 + 1/(Ti*s) + Td*s);
    [num_tust,den_tust] = tfdata(Gback,'v');
    
    % Runs Simulink Model
    out = sim('digitalControlTustinSim');
    
    % Plots the simulation results
    if k == 1
        plot(out.y_cont.time,out.y_cont.data,'LineWidth',4);
    end
    plot(out.y_tust.time,out.y_tust.data,'LineWidth',1.5);
end
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
title('Tustin Discretization')
legend('Cont PID','Disc PID, Ts=2','Disc PID, Ts=1',...
       'Disc PID, Ts=0.5','Disc PID, Ts=0.1',...
       'Location','east','FontSize',11)
ylim([0 1.4])
set(gcf, 'Position',  [100, 200, 800, 550])
% exportgraphics(gcf,'../images/stepRespPIDComparTustin.eps')

%% PID Tustin Discretization - Comparison for different sample times
try close 1
catch warning('Figure 1 is already closed.')
end
try close 2
catch warning('Figure 1 is already closed.')
end

T = 0.1;
z = tf('z',T);          % Defines the discrete time variable z
s = (2/T)*((z-1)/(z+1));    % Defines the Tustin approximation
Gback = Kp*(1 + 1/(Ti*s) + Td*s);
[num_tust,den_tust] = tfdata(Gback,'v');

% Runs Simulink Model
out = sim('digitalControlTustinSim');

% Plots the simulation results for the control signal u(t)
figure(1), cla, hold on
plot(out.u_cont.time,out.u_cont.data,...
    'LineWidth',4);
stairs(out.u_tust.time,out.u_tust.data,...
    'LineWidth',1.5);
stairs(out.u_tust_diffeq.time,out.u_tust_diffeq.data,...
    'LineWidth',1.5,'LineStyle','--');

xlabel('Time [s]','FontSize',13)
ylabel('u(t)','FontSize',13)
title('Control Signal u(t)')
legend('Continuous PID','Discrete PID, TF','Discrete PID, DiffEq',...
       'Location','northeast','FontSize',11)
axis([0 2 -4000 4000])
set(gcf, 'Position',  [100, 200, 800, 550])
exportgraphics(gcf,'../images/stepRespPIDComparUTustin.eps')

% Plots the simulation results for the output signal y(t)
figure(2), cla, hold on
plot(out.y_cont.time,out.y_cont.data,...
    'LineWidth',4);
stairs(out.y_tust.time,out.y_tust.data,...
    'LineWidth',1.5);
stairs(out.y_tust_diffeq.time,out.y_tust_diffeq.data,...
    'LineWidth',1.5,'LineStyle','--');

xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
title('Output Signal y(t)')
legend('Continuous PID','Discrete PID, TF','Discrete PID, DiffEq',...
       'Location','northeast','FontSize',11)
% axis([0 2 -4000 4000])
set(gcf, 'Position',  [100, 200, 800, 550])
% exportgraphics(gcf,'../images/stepRespPIDComparYTustin.eps')
