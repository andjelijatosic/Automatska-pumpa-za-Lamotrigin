pkg load control

% funkcija prenosa
G = tf(0.0125, [1, 1.025, 0.025])

% konstante
T1 = 40;
T2 = 1;
K = 0.5;

% promenljiva konstanta
tau = 20;

Ti = min(T1, 4*(tau + T2));
kc = T1 / (K * (tau + T2));

% parametri regulatora
kp = kc;
ki = kc / Ti;

% funkcija prenosa regulatora
Greg = tf([kp, ki], [1, 0])

% povratna sprega
Wpp = feedback((Greg * G), 1)

% odziv i ispis odziva
t = linspace(0, 1000, 5000);
[y, t] = step(Wpp, t);

figure;
plot(t, y, 'LineWidth', 2);
grid on;

title('Step odziv sistema za doziranje lamotrigina');
xlabel('Vreme');
ylabel('Koncentracija LTG u krvi');


