%% Metodos de Discretizacion - Ejemplo
zeta = 0.5;
wn = 1;
Gc = tf(wn^2,[1 2*zeta*wn wn^2]);
Tf = 12;

%% Backward
[yc,tc] = step(Gc,Tf);
T = 1;
z = tf([1 0],1,T);
s = (z-1)/(z*T);         % Backward approx
Gb = wn^2 / (s^2 + 2*zeta*wn*s + wn^2);
[yb,tb] = step(Gb,Tf);
figure(1), cla, hold on
plot(tc,yc,'LineWidth',3);
stairs(tb,yb,'LineWidth',1.5);
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
legend('G(s)','G(z)','Location','east','FontSize',13)
xlim([0 12]), ylim([0 1.25])
exportgraphics(gcf,'../images/backwardStepResp.eps')

%% Backward, different sample times
[yc,tc] = step(Gc,Tf);
Tvec = [2 1 0.5 0.1];
figure(1), cla, hold on
plot(tc,yc,'LineWidth',3);
for k = 1:length(Tvec)
    T = Tvec(k);
    z = tf([1 0],1,T);
    s = (z-1)/(z*T);         % Backward approx
    Gb = wn^2 / (s^2 + 2*zeta*wn*s + wn^2);
    [yb,tb] = step(Gb,Tf);
    stairs(tb,yb,'LineWidth',1.5);
end
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
legend('G(s)','G(z),T=2','G(z),T=1','G(z),T=0.5','G(z),T=0.1','Location','east','FontSize',12)
xlim([0 12]), ylim([0 1.25])
exportgraphics(gcf,'../images/backwardStepRespDiffT.eps')

%% Diff equation
% ybb = zeros(1,length(tb));
% u = ones(1,length(tb));
% for k = 1:length(tb)
%     if k == 1
%         ybb(k) = (1/3)*u(k);
%     elseif k == 2
%         ybb(k) = ybb(k-1) + (1/3)*u(k);
%     else    
%         ybb(k) = ybb(k-1) - (1/3)*ybb(k-2) + (1/3)*u(k);
%     end
% end
% stairs(tb,ybb,'LineWidth',2,'LineStyle','--')

%% Tustin
[yc,tc] = step(Gc,Tf);
T = 1;
z = tf([1 0],1,T);
s = (2/T)*((z-1)/(z+1)); % Tustin approx
Gt = wn^2 / (s^2 + 2*zeta*wn*s + wn^2);
[yt,tt] = step(Gt,Tf);  
figure(1), cla, hold on
plot(tc,yc,'LineWidth',3);
stairs(tt,yt,'LineWidth',1.5);
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
legend('G(s)','G(z)','Location','east','FontSize',13)
xlim([0 12]), ylim([0 1.25])
exportgraphics(gcf,'../images/tustinStepResp.eps')

%% Tustin, different sample times
[yc,tc] = step(Gc,Tf);
Tvec = [2 1 0.5 0.1];
figure(1), cla, hold on
plot(tc,yc,'LineWidth',3);
for k = 1:length(Tvec)
    T = Tvec(k);
    z = tf([1 0],1,T);
    s = (2/T)*((z-1)/(z+1)); % Tustin approx
    Gt = wn^2 / (s^2 + 2*zeta*wn*s + wn^2);
    [yb,tb] = step(Gt,Tf);
    stairs(tb,yb,'LineWidth',1.5);
end
xlabel('Time [s]','FontSize',13)
ylabel('y(t)','FontSize',13)
legend('G(s)','G(z),T=2','G(z),T=1','G(z),T=0.5','G(z),T=0.1','Location','east','FontSize',12)
xlim([0 12]), ylim([0 1.25])
exportgraphics(gcf,'../images/tustinStepRespDiffT.eps')
