% Лабораторная работа №4, вариант 5
% f(x) = 4^(cos(x)), [a,b] = [-3, 0]
clear; clc; close all;

a = -3;
b = 0;

% Функция f(x) = 4^(cos(x))
f = @(x) 4 .^ (cos(x));

% Точки для оценки погрешности
x_j = [(5*a + b)/6, (a + b)/2, (a + 5*b)/6];  % = [-2.5, -1.5, -0.5]
y_j = f(x_j);

%% ==========================
%% Равномерная сетка
%% ==========================

% Узлы равномерной сетки (4 узла для полинома 3-й степени)
n = 3;
x_uniform = linspace(a, b, n+1);  % [-3, -2, -1, 0]
y_uniform = f(x_uniform);

%% Лагранж (равномерная)
% Базисные полиномы
l0 = @(x) ((x - x_uniform(2)) .* (x - x_uniform(3)) .* (x - x_uniform(4))) ./ ...
          ((x_uniform(1) - x_uniform(2)) * (x_uniform(1) - x_uniform(3)) * (x_uniform(1) - x_uniform(4)));
l1 = @(x) ((x - x_uniform(1)) .* (x - x_uniform(3)) .* (x - x_uniform(4))) ./ ...
          ((x_uniform(2) - x_uniform(1)) * (x_uniform(2) - x_uniform(3)) * (x_uniform(2) - x_uniform(4)));
l2 = @(x) ((x - x_uniform(1)) .* (x - x_uniform(2)) .* (x - x_uniform(4))) ./ ...
          ((x_uniform(3) - x_uniform(1)) * (x_uniform(3) - x_uniform(2)) * (x_uniform(3) - x_uniform(4)));
l3 = @(x) ((x - x_uniform(1)) .* (x - x_uniform(2)) .* (x - x_uniform(3))) ./ ...
          ((x_uniform(4) - x_uniform(1)) * (x_uniform(4) - x_uniform(2)) * (x_uniform(4) - x_uniform(3)));

L_uniform = @(x) y_uniform(1)*l0(x) + y_uniform(2)*l1(x) + y_uniform(3)*l2(x) + y_uniform(4)*l3(x);

L_uniform_xj = L_uniform(x_j);
errors_L_uniform = abs(y_j - L_uniform_xj);

%% Ньютон (равномерная)
coeff_uniform = y_uniform;
for j = 2:length(x_uniform)
    for i = length(x_uniform):-1:j
        coeff_uniform(i) = (coeff_uniform(i) - coeff_uniform(i-1)) / (x_uniform(i) - x_uniform(i-j+1));
    end
end

P_uniform = @(x) coeff_uniform(1) ...
               + coeff_uniform(2)*(x - x_uniform(1)) ...
               + coeff_uniform(3)*(x - x_uniform(1)).*(x - x_uniform(2)) ...
               + coeff_uniform(4)*(x - x_uniform(1)).*(x - x_uniform(2)).*(x - x_uniform(3));

P_uniform_xj = P_uniform(x_j);
errors_P_uniform = abs(y_j - P_uniform_xj);

%% ==========================
%% Чебышевская сетка
%% ==========================

% Узлы Чебышева (на отрезке [a,b])
x_cheb = zeros(1, n+1);
for i = 0:n
    x_cheb(i+1) = (a + b)/2 + (b - a)/2 * cos( (2*i + 1) * pi / (2*(n+1)) );
end
y_cheb = f(x_cheb);

%% Лагранж (Чебышев)
% Базисные полиномы для Чебышевской сетки
l0c = @(x) ((x - x_cheb(2)) .* (x - x_cheb(3)) .* (x - x_cheb(4))) ./ ...
           ((x_cheb(1) - x_cheb(2)) * (x_cheb(1) - x_cheb(3)) * (x_cheb(1) - x_cheb(4)));
l1c = @(x) ((x - x_cheb(1)) .* (x - x_cheb(3)) .* (x - x_cheb(4))) ./ ...
           ((x_cheb(2) - x_cheb(1)) * (x_cheb(2) - x_cheb(3)) * (x_cheb(2) - x_cheb(4)));
l2c = @(x) ((x - x_cheb(1)) .* (x - x_cheb(2)) .* (x - x_cheb(4))) ./ ...
           ((x_cheb(3) - x_cheb(1)) * (x_cheb(3) - x_cheb(2)) * (x_cheb(3) - x_cheb(4)));
l3c = @(x) ((x - x_cheb(1)) .* (x - x_cheb(2)) .* (x - x_cheb(3))) ./ ...
           ((x_cheb(4) - x_cheb(1)) * (x_cheb(4) - x_cheb(2)) * (x_cheb(4) - x_cheb(3)));

L_cheb = @(x) y_cheb(1)*l0c(x) + y_cheb(2)*l1c(x) + y_cheb(3)*l2c(x) + y_cheb(4)*l3c(x);

L_cheb_xj = L_cheb(x_j);
errors_L_cheb = abs(y_j - L_cheb_xj);

%% Ньютон (Чебышев)
coeff_cheb = y_cheb;
for j = 2:length(x_cheb)
    for i = length(x_cheb):-1:j
        coeff_cheb(i) = (coeff_cheb(i) - coeff_cheb(i-1)) / (x_cheb(i) - x_cheb(i-j+1));
    end
end

P_cheb = @(x) coeff_cheb(1) ...
            + coeff_cheb(2)*(x - x_cheb(1)) ...
            + coeff_cheb(3)*(x - x_cheb(1)).*(x - x_cheb(2)) ...
            + coeff_cheb(4)*(x - x_cheb(1)).*(x - x_cheb(2)).*(x - x_cheb(3));

P_cheb_xj = P_cheb(x_j);
errors_P_cheb = abs(y_j - P_cheb_xj);

%% ==========================
%% Вывод результатов
%% ==========================

fprintf("================================================\n");
fprintf("Узлы равномерной сетки:\n");
for i = 1:length(x_uniform)
    fprintf("x_%d = %.6f, f(x_%d) = %.6f\n", i-1, x_uniform(i), i-1, y_uniform(i));
end

fprintf("\nУзлы Чебышевской сетки:\n");
for i = 1:length(x_cheb)
    fprintf("x_%d = %.6f, f(x_%d) = %.6f\n", i-1, x_cheb(i), i-1, y_cheb(i));
end

fprintf("\n================================================\n");
fprintf("Таблица результатов (Лагранж):\n");
fprintf("------------------------------------------------------------\n");
fprintf('j   x_j        f(x_j)      L_unif(x_j)  |f-L_unif|   L_cheb(x_j)  |f-L_cheb|\n');
fprintf("------------------------------------------------------------\n");
for j = 1:length(x_j)
    fprintf('%d   %6.3f   %10.6f   %10.6f   %10.6e   %10.6f   %10.6e\n', ...
            j-1, x_j(j), y_j(j), L_uniform_xj(j), errors_L_uniform(j), ...
            L_cheb_xj(j), errors_L_cheb(j));
end
fprintf("------------------------------------------------------------\n");

fprintf("\n================================================\n");
fprintf("Таблица результатов (Ньютон):\n");
fprintf("------------------------------------------------------------\n");
fprintf('j   x_j        f(x_j)      P_unif(x_j)  |f-P_unif|   P_cheb(x_j)  |f-P_cheb|\n');
fprintf("------------------------------------------------------------\n");
for j = 1:length(x_j)
    fprintf('%d   %6.3f   %10.6f   %10.6f   %10.6e   %10.6f   %10.6e\n', ...
            j-1, x_j(j), y_j(j), P_uniform_xj(j), errors_P_uniform(j), ...
            P_cheb_xj(j), errors_P_cheb(j));
end
fprintf("------------------------------------------------------------\n");

%% ==========================
%% Графики (Лагранж)
%% ==========================
xx = linspace(a, b, 500);

figure;
subplot(2,2,1);
plot(xx, f(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xx, L_uniform(xx), 'b--', 'LineWidth', 1.5);
plot(x_uniform, y_uniform, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(x_j, y_j, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('y');
legend('f(x)', 'L_3(x)', 'Узлы', 'Точки погрешности', 'Location', 'best');
title('Лагранж: равномерная сетка');

subplot(2,2,2);
plot(xx, f(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xx, L_cheb(xx), 'r--', 'LineWidth', 1.5);
plot(x_cheb, y_cheb, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(x_j, y_j, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('y');
legend('f(x)', 'L_3(x)', 'Узлы', 'Точки погрешности', 'Location', 'best');
title('Лагранж: Чебышевская сетка');

subplot(2,2,3);
plot(xx, abs(f(xx) - L_uniform(xx)), 'b-', 'LineWidth', 1.5); hold on;
plot(xx, abs(f(xx) - L_cheb(xx)), 'r-', 'LineWidth', 1.5);
plot(x_j, errors_L_uniform, 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
plot(x_j, errors_L_cheb, 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
grid on; xlabel('x'); ylabel('Погрешность');
legend('Равномерная', 'Чебышевская', 'Точки (равн.)', 'Точки (Чеб.)', 'Location', 'best');
title('Погрешность интерполяции (Лагранж)');

%% ==========================
%% Графики (Ньютон)
%% ==========================
subplot(2,2,4);
plot(xx, abs(f(xx) - P_uniform(xx)), 'b-', 'LineWidth', 1.5); hold on;
plot(xx, abs(f(xx) - P_cheb(xx)), 'r-', 'LineWidth', 1.5);
plot(x_j, errors_P_uniform, 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
plot(x_j, errors_P_cheb, 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
grid on; xlabel('x'); ylabel('Погрешность');
legend('Равномерная', 'Чебышевская', 'Точки (равн.)', 'Точки (Чеб.)', 'Location', 'best');
title('Погрешность интерполяции (Ньютон)');

figure;
subplot(1,2,1);
plot(xx, f(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xx, P_uniform(xx), 'b--', 'LineWidth', 1.5);
plot(x_uniform, y_uniform, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(x_j, y_j, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('y');
legend('f(x)', 'P_3(x)', 'Узлы', 'Точки погрешности', 'Location', 'best');
title('Ньютон: равномерная сетка');

subplot(1,2,2);
plot(xx, f(xx), 'k-', 'LineWidth', 1.5); hold on;
plot(xx, P_cheb(xx), 'r--', 'LineWidth', 1.5);
plot(x_cheb, y_cheb, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(x_j, y_j, 'gs', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
grid on; xlabel('x'); ylabel('y');
legend('f(x)', 'P_3(x)', 'Узлы', 'Точки погрешности', 'Location', 'best');
title('Ньютон: Чебышевская сетка');


