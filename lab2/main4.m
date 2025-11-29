% Лабораторная работа №2 - Итерационные методы решения СЛАУ
% Вариант 5 (ℓ₁-норма)
clear all; clc;

%% Исходные данные
A = [-7, 2, 40, 0;
      9, -5, 0, 50;
      25, 0, 4, -1;
      0, 32, 0, 9];
b = [21; -14; 13; 21];

%% Приведение к диагональному преобладанию
A1 = [25, 0, 4, -1;
       0, 32, 0, 9;
      -7, 2, 40, 0;
       9, -5, 0, 50];
b1 = [13; 21; 21; -14];

% Проверка совпадения решений
x_A = A \ b;
x_A1 = A1 \ b1;
fprintf('Проверка совпадения решений:\n');
fprintf('A\\b  = [%.6f, %.6f, %.6f, %.6f]\n', x_A);
fprintf('A1\\b1 = [%.6f, %.6f, %.6f, %.6f]\n', x_A1);
fprintf('Норма разности: %e\n\n', norm(x_A - x_A1, 1));

%% Общие параметры
epsilon = 1e-4;
x0 = zeros(4, 1);
max_iter = 100;

%% МЕТОД ПРОСТОЙ ИТЕРАЦИИ (Якоби)
fprintf('=== МЕТОД ПРОСТОЙ ИТЕРАЦИИ ===\n');

% Построение итерационной матрицы
D = diag(diag(A1));
L = tril(A1, -1);
U = triu(A1, 1);

% Метод Якоби: x^(k+1) = B*x^(k) + c
B_jacobi = -D \ (L + U);
c_jacobi = D \ b1;

% Проверка сходимости
B_norm = norm(B_jacobi, 1);
fprintf('‖B‖₁ = %.6f\n', B_norm);
if B_norm >= 1
    fprintf('ВНИМАНИЕ: ‖B‖₁ ≥ 1, метод может не сходиться!\n');
end

% Итерационный процесс
x_old = x0;
k_simple = 0;
diff_norm_simple = epsilon + 1;

fprintf('┌─────┬────────────┬────────────┬────────────┬────────────┬──────────────────┬────────────────────┐\n');
fprintf('│ №   │    x1      │    x2      │    x3      │    x4      │ ‖x^(k)-x^(k-1)‖₁ │ (1-‖B‖)*ε/‖B‖     │\n');
fprintf('├─────┼────────────┼────────────┼────────────┼────────────┼──────────────────┼────────────────────┤\n');

while diff_norm_simple >= epsilon && k_simple < max_iter
    k_simple = k_simple + 1;
    x_new = B_jacobi * x_old + c_jacobi;
    diff_norm_simple = norm(x_new - x_old, 1);
    criterion = (1 - B_norm) * epsilon / B_norm;

    fprintf('│ %3d │ %10.6f │ %10.6f │ %10.6f │ %10.6f │ %16.6e │ %18.6e │\n', ...
            k_simple, x_new(1), x_new(2), x_new(3), x_new(4), diff_norm_simple, criterion);

    x_old = x_new;
end

fprintf('└─────┴────────────┴────────────┴────────────┴────────────┴──────────────────┴────────────────────┘\n');

x_simple = x_new;
fprintf('\nТочность достигнута на итерации: %d\n', k_simple);
fprintf('Решение системы x*:\n');
fprintf('x* = [%.8f, %.8f, %.8f, %.8f]\n', x_simple);

% Невязки
R_simple_A1 = A1 * x_simple - b1;
R_simple_A = A * x_simple - b;
fprintf('Невязка R = A1*x* - b1: [%.2e, %.2e, %.2e, %.2e]\n', R_simple_A1);
fprintf('Норма невязки (A1): %e\n', norm(R_simple_A1, 1));
fprintf('Норма невязки (A): %e\n\n', norm(R_simple_A, 1));

%% МЕТОД ЗЕЙДЕЛЯ
fprintf('=== МЕТОД ЗЕЙДЕЛЯ ===\n');

% Построение итерационной матрицы Зейделя
% x^(k+1) = (D + L)^(-1) * (b - U*x^(k))
B_seidel = (D + L) \ (-U);
c_seidel = (D + L) \ b1;

% Проверка сходимости
B_seidel_norm = norm(B_seidel, 1);
fprintf('‖B_зейдель‖₁ = %.6f\n', B_seidel_norm);
if B_seidel_norm >= 1
    fprintf('ВНИМАНИЕ: ‖B_зейдель‖₁ ≥ 1, метод может не сходиться!\n');
end

% Итерационный процесс
x_old = x0;
k_seidel = 0;
diff_norm_seidel = epsilon + 1;

fprintf('┌─────┬────────────┬────────────┬────────────┬────────────┬──────────────────┬────────────────────┐\n');
fprintf('│ №   │    x1      │    x2      │    x3      │    x4      │ ‖x^(k)-x^(k-1)‖₁ │ (1-‖B‖)*ε/‖B2‖    │\n');
fprintf('├─────┼────────────┼────────────┼────────────┼────────────┼──────────────────┼────────────────────┤\n');

while diff_norm_seidel >= epsilon && k_seidel < max_iter
    k_seidel = k_seidel + 1;

    % Последовательное обновление компонент (практическая реализация)
    x_new = x_old;
    for i = 1:4
        sum_before = A1(i, 1:i-1) * x_new(1:i-1);
        sum_after = A1(i, i+1:end) * x_old(i+1:end);
        x_new(i) = (b1(i) - sum_before - sum_after) / A1(i,i);
    end

    diff_norm_seidel = norm(x_new - x_old, 1);
    criterion_seidel = (1 - B_seidel_norm) * epsilon / B_seidel_norm;

    fprintf('│ %3d │ %10.6f │ %10.6f │ %10.6f │ %10.6f │ %16.6e │ %18.6e │\n', ...
            k_seidel, x_new(1), x_new(2), x_new(3), x_new(4), diff_norm_seidel, criterion_seidel);

    x_old = x_new;
end

fprintf('└─────┴────────────┴────────────┴────────────┴────────────┴──────────────────┴────────────────────┘\n');

x_seidel = x_new;
fprintf('\nТочность достигнута на итерации: %d\n', k_seidel);
fprintf('Решение системы x*:\n');
fprintf('x* = [%.8f, %.8f, %.8f, %.8f]\n', x_seidel);

% Невязки
R_seidel_A1 = A1 * x_seidel - b1;
R_seidel_A = A * x_seidel - b;
fprintf('Невязка R = A1*x* - b1: [%.2e, %.2e, %.2e, %.2e]\n', R_seidel_A1);
fprintf('Норма невязки (A1): %e\n', norm(R_seidel_A1, 1));
fprintf('Норма невязки (A): %e\n\n', norm(R_seidel_A, 1));

%% РЕШЕНИЕ ВСТРОЕННОЙ ФУНКЦИЕЙ
fprintf('=== ВСТРОЕННОЕ РЕШЕНИЕ ===\n');
x_builtin = A1 \ b1;
fprintf('Решение A1\\b1: [%.8f, %.8f, %.8f, %.8f]\n', x_builtin);
R_builtin_A1 = A1 * x_builtin - b1;
R_builtin_A = A * x_builtin - b;
fprintf('Невязка R = A1*x* - b1: [%.2e, %.2e, %.2e, %.2e]\n', R_builtin_A1);
fprintf('Норма невязки (A1): %e\n', norm(R_builtin_A1, 1));
fprintf('Норма невязки (A): %e\n\n', norm(R_builtin_A, 1));

%% СРАВНИТЕЛЬНЫЙ АНАЛИЗ
fprintf('=== СРАВНИТЕЛЬНЫЙ АНАЛИЗ МЕТОДОВ ===\n');
fprintf('┌──────────────────┬──────────────┬────────────────────┬──────────────────┐\n');
fprintf('│     Метод        │ Итерации     │ Невязка (A1)       │ Невязка (A)      │\n');
fprintf('├──────────────────┼──────────────┼────────────────────┼──────────────────┤\n');
fprintf('│ Простая итерация │ %12d │ %18.2e │ %16.2e │\n', k_simple, norm(R_simple_A1, 1), norm(R_simple_A, 1));
fprintf('│ Зейделя          │ %12d │ %18.2e │ %16.2e │\n', k_seidel, norm(R_seidel_A1, 1), norm(R_seidel_A, 1));
fprintf('│ Встроенный       │ %12s │ %18.2e │ %16.2e │\n', '-', norm(R_builtin_A1, 1), norm(R_builtin_A, 1));
fprintf('└──────────────────┴──────────────┴────────────────────┴──────────────────┘\n\n');

fprintf('=== ВЫВОДЫ ===\n');
fprintf('1. СКОРОСТЬ СХОДИМОСТИ:\n');
if k_seidel < k_simple
    fprintf('   - Метод Зейделя сходится быстрее (%d итераций против %d)\n', k_seidel, k_simple);
elseif k_seidel > k_simple
    fprintf('   - Метод простой итерации сходится быстрее (%d итераций против %d)\n', k_simple, k_seidel);
else
    fprintf('   - Оба метода сошлись за одинаковое количество итераций (%d)\n', k_simple);
end

fprintf('2. ТОЧНОСТЬ:\n');
fprintf('   - Метод простой итерации: невязка = %.2e\n', norm(R_simple_A, 1));
fprintf('   - Метод Зейделя: невязка = %.2e\n', norm(R_seidel_A, 1));
fprintf('   - Встроенное решение: невязка = %.2e\n', norm(R_builtin_A, 1));

fprintf('3. ЗАКЛЮЧЕНИЕ:\n');
if norm(R_seidel_A, 1) < norm(R_simple_A, 1)
    fprintf('   - Метод Зейделя обеспечивает более высокую точность\n');
else
    fprintf('   - Метод простой итерации обеспечивает более высокую точность\n');
end
