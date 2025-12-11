% Лабораторная работа №4, вариант 5
% f(x) = 4^(cos(x)), [a,b] = [-3, 0]
clear; clc; close all;

a = -3;
b = 0;

%узлы равномерной сетки
x_nodes = [-3, -2, -1, 0];

% Функция f(x) = 4^(cos(x))
f = @(x) 4 .^ (cos(x));

y_nodes = f(x_nodes);


fprintf("Узлы и значения функции f(x) = 4^(cos(x)):\n");
for i = 1:length(x_nodes)
    printf("x_%d = %2d, f(x_%d) = %.6f\n", i-1, x_nodes(i), i-1, y_nodes(i));
end

% Точки погрешности
x_j = [(5*a + b)/6, (a + b)/2, (a + 5*b)/6];
fprintf("\nx_j:");
disp(x_j);
y_j = f(x_j);
fprintf("y_j:");
disp(y_j);

% Базисные полиномы как функции (вручную считал)
l0 = @(x) ((x + 2) .* (x + 1) .* x) / (-6);
l1 = @(x) ((x + 3) .* (x + 1) .* x) / (2);
l2 = @(x) ((x + 3) .* (x + 2) .* x) / (-2);
l3 = @(x) ((x + 3) .* (x + 2) .* (x + 1)) / (6);

% Интерполяционный многочлен Лагранжа
L = @(x) y_nodes(1)*l0(x) + y_nodes(2)*l1(x) + y_nodes(3)*l2(x) + y_nodes(4)*l3(x);

L_xnodes = L(x_nodes);
fprintf("Значения полинома Лагранжа в узлах:" );
disp(L_xnodes);

L_xj = L(x_j);
fprintf("Значения полинома Лагранжа в точках x_j:" );
disp(L_xj);

errors_L = abs(y_j - L_xj);
% Вывод таблицы
fprintf('\nТаблица результатов (равномерная сетка):\n');
fprintf('-------------------------------------------------------------\n');
fprintf('j   x_j        f(x_j)      L3(x_j)      |f(x_j) - L3(x_j)|\n');
fprintf('-------------------------------------------------------------\n');
for j = 1:length(x_j)
    fprintf('%d   %6.3f   %10.6f   %10.6f   %10.6e\n', ...
            j-1, x_j(j), y_j(j), L_xj(j), errors_L(j));
end
fprintf('-------------------------------------------------------------\n');





##xx = linspace(a, b, 200);
##figure;
##plot(xx, f(xx), 'k-', xx, L(xx), 'b--', 'LineWidth', 1);
##hold on;
##plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 5, 'LineWidth', 1);
##hold off;
##grid on;
##legend('f(x)', 'L_3(x)', 'Узлы', 'Location', 'best');
##xlabel('x'); ylabel('y');


xx = linspace(a, b, 200);
figure;
plot(xx, f(xx), 'k-', 'LineWidth', 1.2); hold on;
plot(xx, L(xx), 'b--', 'LineWidth', 1.2);
plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');      % узлы
plot(x_j, f(x_j), 'gs', 'MarkerSize', 8, 'MarkerFaceColor', 'g');           % точки погрешности на f(x)
plot(x_j, L(x_j), 'gs', 'MarkerSize', 8);                                   % (опционально: на L(x) тоже)
grid on;
xlabel('x'); ylabel('y');
legend('f(x)', 'L_3(x)', 'Узлы интерполяции', 'Точки погрешности', 'Location', 'best');
title('Интерполяция многочленом Лагранжа (равномерная сетка)');
hold off;
