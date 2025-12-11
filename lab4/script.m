% Лабораторная работа №4, вариант 5
% f(x) = 4^(cos(x)), [a,b] = [-3, 0]
clear; clc; close all;

a = -3;
b = 0;

% Узлы равномерной сетки (4 узла для полинома 3-й степени)
n = 3;
x_nodes = linspace(a, b, n+1);  % [-3, -2, -1, 0]

% Функция f(x) = 4^(cos(x))
f = @(x) 4 .^ (cos(x));
y_nodes = f(x_nodes);

% Точки для оценки погрешности
x_j = [(5*a + b)/6, (a + b)/2, (a + 5*b)/6];  % = [-2.5, -1.5, -0.5]
y_j = f(x_j);

%% ==========================
%% Многочлен Лагранжа
%% ==========================

% Базисные полиномы (ручной расчёт для 4 узлов)
l0 = @(x) ((x - x_nodes(2)) .* (x - x_nodes(3)) .* (x - x_nodes(4))) ./ ...
          ((x_nodes(1) - x_nodes(2)) * (x_nodes(1) - x_nodes(3)) * (x_nodes(1) - x_nodes(4)));
l1 = @(x) ((x - x_nodes(1)) .* (x - x_nodes(3)) .* (x - x_nodes(4))) ./ ...
          ((x_nodes(2) - x_nodes(1)) * (x_nodes(2) - x_nodes(3)) * (x_nodes(2) - x_nodes(4)));
l2 = @(x) ((x - x_nodes(1)) .* (x - x_nodes(2)) .* (x - x_nodes(4))) ./ ...
          ((x_nodes(3) - x_nodes(1)) * (x_nodes(3) - x_nodes(2)) * (x_nodes(3) - x_nodes(4)));
l3 = @(x) ((x - x_nodes(1)) .* (x - x_nodes(2)) .* (x - x_nodes(3))) ./ ...
          ((x_nodes(4) - x_nodes(1)) * (x_nodes(4) - x_nodes(2)) * (x_nodes(4) - x_nodes(3)));

L = @(x) y_nodes(1)*l0(x) + y_nodes(2)*l1(x) + y_nodes(3)*l2(x) + y_nodes(4)*l3(x);

L_xj = L(x_j);
errors_L = abs(y_j - L_xj);

% Вывод таблицы для Лагранжа
fprintf("Узлы и значения функции f(x) = 4^(cos(x)):\n");
for i = 1:length(x_nodes)
    fprintf("x_%d = %.3f, f(x_%d) = %.6f\n", i-1, x_nodes(i), i-1, y_nodes(i));
end

fprintf('\nТаблица результатов (Лагранж, равномерная сетка):\n');
fprintf('-------------------------------------------------------------\n');
fprintf('j   x_j        f(x_j)      L3(x_j)      |f(x_j) - L3(x_j)|\n');
fprintf('-------------------------------------------------------------\n');
for j = 1:length(x_j)
    fprintf('%d   %6.3f   %10.6f   %10.6f   %10.6e\n', ...
            j-1, x_j(j), y_j(j), L_xj(j), errors_L(j));
end
fprintf('-------------------------------------------------------------\n');

% График для Лагранжа
xx = linspace(a, b, 200);
figure;
plot(xx, f(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xx, L(xx), 'b--', 'LineWidth', 1.5);
plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(x_j, y_j, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
grid on;
xlabel('x'); ylabel('y');
legend('f(x)', 'L_3(x)', 'Узлы', 'Точки погрешности', 'Location', 'best');
title('Интерполяция многочленом Лагранжа (равномерная сетка)');
hold off;

%% ==========================
%% Многочлен Ньютона
%% ==========================

% Разделённые разности
coeff = y_nodes;
for j = 2:length(x_nodes)
    for i = length(x_nodes):-1:j
        coeff(i) = (coeff(i) - coeff(i-1)) / (x_nodes(i) - x_nodes(i-j+1));
    end
end

P = @(x) coeff(1) ...
       + coeff(2)*(x - x_nodes(1)) ...
       + coeff(3)*(x - x_nodes(1)).*(x - x_nodes(2)) ...
       + coeff(4)*(x - x_nodes(1)).*(x - x_nodes(2)).*(x - x_nodes(3));

P_xj = P(x_j);
errors_P = abs(y_j - P_xj);

% Вывод таблицы для Ньютона
fprintf('\nКоэффициенты полинома Ньютона:\n');
for i = 1:length(coeff)
    fprintf('a%d = %.6f\n', i-1, coeff(i));
end

fprintf('\nТаблица результатов (Ньютон, равномерная сетка):\n');
fprintf('-------------------------------------------------------------\n');
fprintf('j   x_j        f(x_j)      P3(x_j)      |f(x_j) - P3(x_j)|\n');
fprintf('-------------------------------------------------------------\n');
for j = 1:length(x_j)
    fprintf('%d   %6.3f   %10.6f   %10.6f   %10.6e\n', ...
            j-1, x_j(j), y_j(j), P_xj(j), errors_P(j));
end
fprintf('-------------------------------------------------------------\n');

% График для Ньютона
figure;
plot(xx, f(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xx, P(xx), 'b--', 'LineWidth', 1.5);
plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(x_j, y_j, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
grid on;
xlabel('x'); ylabel('y');
legend('f(x)', 'P_3(x)', 'Узлы', 'Точки погрешности', 'Location', 'best');
title('Интерполяция многочленом Ньютона (равномерная сетка)');
hold off;


