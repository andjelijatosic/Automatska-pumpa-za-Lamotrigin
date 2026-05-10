pkg load control

% parametri (uzete su srednje vrednosti za parametre koji su dati u opsezima)
ka = 1;
ke = 0.025;
V = 80;
k = 1;
alfa = 5;

% MRT
Cp0 = 0.025;
Ad0 = (ke * Cp0 * V)/ka;
u0 = (ke * Cp0 * V)/(k - (alfa * ke * Cp0 * V));

% nelinearni model
function dx = sistem(t, x, ka, ke, V, k, alfa, u)
  dx = zeros(2,1);
  Ad = x(1);
  Cp = x(2);
  dx(1) = (-ka * Ad) + (k * u)/(1 + (alfa * u));
  dx(2) = (ka * Ad)/V - (ke * Cp);
end

% plotovanje nelinearnog modela
t = 0:0.01:100;

%!!!
% parametri sinusne perturbacije
amplituda = 0.01;  % amplituda (menja se pri testiranju)
omega = 0.5;      % frekvencija

% definicija ulaza kao funkcije vremena
u_funkcija = @(t) u0 + amplituda*sin(omega*t);
x0 = [Ad0; Cp0];	% krece se tacno iz MRT (bez const perturbacije)

f = @(t,x) sistem(t, x, ka, ke, V, k, alfa, u_funkcija(t));
[t, x] = ode45(f, t, x0);

figure;
plot(t, x(:,2), 'r', 'LineWidth', 2);
xlabel('vreme t [min]');
ylabel('koncentracija leka Cp [mmol/L]');
hold on;

% linearizovan model
A = [-ka, 0; ka/V, -ke];
B = [k/((1 + alfa * u0)^2); 0];
C = [0 1];
D = 0;

sys = ss(A, B, C, D);

%!!!
% devijacije
u_dev = amplituda*sin(omega*t);
x0_dev = [0; 0];          % jer se krece iz MRT

[y_lin, t_lin] = lsim(sys, u_dev, t, x0_dev);

Cp_lin = y_lin + Cp0;

plot(t_lin, Cp_lin, 'b--', 'LineWidth', 2);
legend('Nelinearni', 'Linearni');
grid on;
