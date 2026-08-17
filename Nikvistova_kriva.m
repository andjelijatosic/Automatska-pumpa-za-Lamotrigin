pkg load control

num = [1];
den = [21, 21, 0];
W0 = tf(num, den);

% Pokretanje margin funkcije
[pretekPoj, pretekFaz, omegapi, omegapf] = margin(W0);

% Pretvaranje preteka faze iz stepena u radijane i računanje preteka kašnjenja
pretekFaz_rad = deg2rad(pretekFaz);
pretekKasnjenja = pretekFaz_rad / omegapf;

% Prikaz rezultata u komandnom prozoru
fprintf('Pretek faze: %.2f stepeni\n', pretekFaz);
fprintf('Učestanost omegapf: %.4f rad/s\n', omegapf);
fprintf('Pretek kašnjenja: %.2f sekundi\n', pretekKasnjenja);

crtanje nikvistove krive
nyquist(W0);

