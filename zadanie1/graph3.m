a = 0.6;
b = 0.8;
x = a:0.001:b;

% Вычисляем модули производных
phi1_deriv = 1 ./ (2 * (x + 1).^(3/2));
phi2_deriv = 2 ./ (x.^3);

% Строим графики
plot(x, phi1_deriv, 'b', 'LineWidth', 2);
hold on;
plot(x, phi2_deriv, 'r', 'LineWidth', 2);
plot(x, ones(size(x)), 'k--', 'LineWidth', 2);
grid on;

legend('|φ_1''(x)|', '|φ_2''(x)|', 'y = 1');
title('Проверка условия сходимости');
xlabel('x');
ylabel('y');
