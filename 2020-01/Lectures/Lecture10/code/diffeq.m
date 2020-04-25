function uk = diffeq(ek,num_tust,den_tust)
persistent ek1      % e(k-1)
persistent ek2      % e(k-2)
persistent uk1      % u(k-1)
persistent uk2      % u(k-2)
if isempty(ek1) && isempty(ek2) && isempty(uk1) && isempty(uk2)
    ek1 = 0; ek2 = 0;   % Initializes persistent variables
    uk1 = 0; uk2 = 0;   % during the first execution
end
b2 = num_tust(1);
b1 = num_tust(2);   % Configures coefficients in the
b0 = num_tust(3);   % difference equation
a2 = den_tust(1);
a1 = den_tust(2);
a0 = den_tust(3); 
% Computes the current iteration of the difference equation
uk = -(a0/a2)*uk2 + (b2/a2)*ek + (b1/a2)*ek1 + (b0/a2)*ek2;
% Shifts the values in e and u for the next iteration
% e(k-2) <- e(k-1), e(k-1) <- e(k)
% u(k-2) <- u(k-1), u(k-1) <- u(k), 
ek2 = ek1; ek1 = ek; uk2 = uk1; uk1 = uk;