% Узлы те же
a = -3;
b = 0;


% Функция f(x) = 4^(cos(x))
f = @(x) 4 .^ (cos(x));

x_nodes = [-3, -2, -1, 0];
y_nodes = f(x_nodes);

% 1. Разделённые разности
n = length(x_nodes);
coeff = y_nodes;  % коэффициенты Ньютона
for j = 2:n
    for i = n:-1:j
        coeff(i) = (coeff(i) - coeff(i-1)) / (x_nodes(i) - x_nodes(i-j+1));
    end
end


fprintf("Узлы и значения функции f(x) = 4^(cos(x)):\n");
for i = 1:length(x_nodes)
    printf("x_%d = %2d, f(x_%d) = %.6f\n", i-1, x_nodes(i), i-1, y_nodes(i));
end


% Вывод коэффициентов
fprintf('\nКоэффициенты полинома Ньютона:\n');
for i = 1:n
    fprintf('a%d = %.6f\n', i-1, coeff(i));
end

% 2. Функция полинома Ньютона (с поэлементным умножением)
P = @(x) coeff(1) ...
       + coeff(2)*(x - x_nodes(1)) ...
       + coeff(3)*(x - x_nodes(1)).*(x - x_nodes(2)) ...
       + coeff(4)*(x - x_nodes(1)).*(x - x_nodes(2)).*(x - x_nodes(3));


% Точки погрешности
x_j = [(5*a + b)/6, (a + b)/2, (a + 5*b)/6];
fprintf("\nx_j:");
disp(x_j);
P_xj = P(x_j);
fprintf("Значения в точках x_j:");
disp(P_xj);


y_j = f(x_j);
errors_P = abs(y_j - P_xj);

% Вывод таблицы
fprintf('\nТаблица результатов (равномерная сетка):\n');
fprintf('-------------------------------------------------------------\n');
fprintf('j   x_j        f(x_j)      P3(x_j)      |f(x_j) - P3(x_j)|\n');
fprintf('-------------------------------------------------------------\n');
for j = 1:length(x_j)
    fprintf('%d   %6.3f   %10.6f   %10.6f   %10.6e\n', ...
            j-1, x_j(j), y_j(j), P_xj(j), errors_P(j));
end
fprintf('-------------------------------------------------------------\n');

##xx = linspace(a, b, 200);
##figure;
##plot(xx, f(xx), 'k-', xx, P(xx), 'b--', 'LineWidth', 1);
##hold on;
##plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 5, 'LineWidth', 1);
##hold off;
##grid on;
##legend('f(x)', 'P_3(x)', 'Узлы', 'Location', 'best');
##xlabel('x'); ylabel('y');



xx = linspace(a, b, 200);
figure;
plot(xx, f(xx), 'k-', 'LineWidth', 1.2); hold on;
plot(xx, P(xx), 'b--', 'LineWidth', 1.2);
plot(x_nodes, y_nodes, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');      % узлы
plot(x_j, f(x_j), 'gs', 'MarkerSize', 8, 'MarkerFaceColor', 'g');           % точки погрешности
plot(x_j, P(x_j), 'gs', 'MarkerSize', 8);
grid on;
xlabel('x'); ylabel('y');
legend('f(x)', 'P_3(x)', 'Узлы интерполяции', 'Точки погрешности', 'Location', 'best');
title('Интерполяция многочленом Ньютона (равномерная сетка)');
hold off;
