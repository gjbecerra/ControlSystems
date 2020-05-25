%% State Feedback - Example
A = [0 1 0; 0 0 1; -2 -3 -5];
B = [0; 0; 1];
C = [1 0 0];
D = 0;

syms k1 k2 k3 lambda
K = [k1 k2 k3];
poly_cl = det(lambda*eye(3) - (A-B*K));
coeff_cl = flip(coeffs(poly_cl,lambda));

%% Design requirements
PO = 5; Ts = 5; x0 = [1;0;0];
syms zeta
zeta = double(solve(PO == 100*exp(-pi*zeta/sqrt(1-zeta^2))));
zeta = zeta(1);
wn = 4/(zeta*Ts);
poly_des = expand((lambda^2 + 2*zeta*wn*lambda + wn^2)*(lambda + 10*zeta*wn));
coeff_des = double(flip(coeffs(poly_des,lambda)))
Soln = solve(coeff_cl == coeff_des);
k1 = double(Soln.k1);
k2 = double(Soln.k2);
k3 = double(Soln.k3);
K = [k1 k2 k3]

%% Simulation
% Closed loop system
Acl = A - B*K
Bcl = zeros(3,1);
Ccl = eye(3);
Dcl = 0;
sys_cl = ss(Acl,Bcl,Ccl,Dcl)
initial(sys_cl,x0)

%% Simulink test
try close(1); catch warning('Figure 1 already closed'); end
Tf = 2; x0 = [1; 0; 0];
K = [170.8 79.1 9.4];
simResults = sim('stateFeedbackRegulatorSim');
figure(1), set(gcf, 'Position',  [100, 200, 800, 550])
subplot(10,1,[1 5]), cla, hold on
plot(simResults.state.time,simResults.state.signals.values,...
     'LineWidth',2)
ylabel('x(t)')
legend('x_1(t)','x_2(t)','x_3(t)','Location','east')
grid on, set(gca,'Xticklabel',[])
subplot(10,1,[6 10]), cla, hold on
plot(simResults.input.time,simResults.input.signals.values,...
     'LineWidth',2)
xlabel('Tiempo [s]'), ylabel('u(t)')
grid on
% exportgraphics(gcf,'../images/stateFeedbackRegulatorInitial.eps')

