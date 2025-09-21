a = 0.6;
b = 0.8;
x = a:0.001:b;

% Определяем наши функции phi(x)
phi1 = 1 ./ sqrt(x + 1);
phi2 = (1 ./ x).^2 - 1;

% Строим графики
plot(x, x, 'k', 'LineWidth', 2); % Рисуем y = x
hold on;
plot(x, phi1, 'r', 'LineWidth', 2); % Рисуем y = phi1(x)
plot(x, phi2, 'b', 'LineWidth', 2); % Рисуем y = phi2(x)
plot(x, zeros(size(x)), 'g--'); % Рисуем ось X для наглядности
grid on;
legend('y = x', 'y = \phi_1(x) = 1/sqrt(x+1)', 'y = \phi_2(x) = (1/x)^2 - 1');
title('Поиск подходящей итерационной функции \phi(x)');
