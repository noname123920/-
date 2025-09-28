a = 0.6;
b = 0.8;
x = a:0.001:b;

% Все функции
f_x = sqrt(x + 1) - 1 ./ x;          % f(x)
y_zero = zeros(size(x));              % y = 0
y_line = x;                           % y = x
phi1 = 1 ./ sqrt(x + 1);              % φ₁(x)
phi2 = (1 ./ x).^2 - 1;               % φ₂(x)

figure;
plot(x, f_x, 'g', 'LineWidth', 2); hold on;    % f(x) - зелёный
plot(x, y_zero, 'k--', 'LineWidth', 1);        % y = 0 - чёрный пунктир
plot(x, y_line, 'k', 'LineWidth', 2);          % y = x - чёрный
plot(x, phi1, 'r', 'LineWidth', 2);            % φ₁(x) - красный
plot(x, phi2, 'b', 'LineWidth', 2);            % φ₂(x) - синий

grid on;
legend('y = f(x)', 'y = 0', 'y = x', 'y = φ₁(x)', 'y = φ₂(x)');
title('Проверка эквивалентности преобразований');
xlabel('x');
ylabel('y');
