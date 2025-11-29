clear; clc;

% === Исходные данные ===
A = [-7  2  40   0;
      9 -5   0  50;
     25  0   4  -1;
      0 32   0   9];

b = [21; -14; 13; 21];

% Прямое решение (для сравнения)
x_direct = A \ b;
fprintf('Прямое решение: x = [%.6f, %.6f, %.6f, %.6f]\n\n', x_direct);

% === Приведение к диагональному преобладанию ===
% Порядок строк: 3, 4, 1, 2
A1 = A([3,4,1,2], :);
b1 = b([3,4,1,2]);

fprintf('Матрица после перестановки:\n');
disp(A1);
fprintf('Вектор b после перестановки:\n');
disp(b1);

% Проверка, что решение не изменилось
x_check = A1 \ b1;
fprintf('Решение после перестановки: x = [%.6f, %.6f, %.6f, %.6f]\n', x_check);
fprintf('Норма разности решений: %.2e\n\n', norm(x_direct - x_check));

% === Параметры методов ===
epsilon = 1e-4;
max_iter = 100;
n = size(A1, 1);

% === МЕТОД ПРОСТОЙ ИТЕРАЦИИ ===
fprintf('=== МЕТОД ПРОСТОЙ ИТЕРАЦИИ ===\n');

% Приведение к виду x = B*x + c
D = diag(diag(A1));
B = eye(n) - D \ A1;
c = D \ b1;

normB = norm(B, 1);
if normB >= 1
    warning('||B||_1 = %.4f >= 1 — метод может не сходиться!', normB);
else
    fprintf('Норма матрицы B (1-норма): %.6f < 1 — сходимость обеспечена.\n', normB);
end

% Начальное приближение
x = zeros(n, 1);

% Таблица
fprintf('\n%4s %12s %12s %12s %12s %12s\n', ...
    'k', 'x1', 'x2', 'x3', 'x4', '||dx||_1');
fprintf('%4d %12.6f %12.6f %12.6f %12.6f\n', 0, x);

converged = false;
for k = 1:max_iter
    x_prev = x;
    x = B * x + c;
    dx = x - x_prev;
    delta = norm(dx, 1);

    fprintf('%4d %12.6f %12.6f %12.6f %12.6f %12.2e\n', ...
        k, x(1), x(2), x(3), x(4), delta);

    % Апостериорная оценка погрешности: ||x^k - x*|| <= normB/(1 - normB) * ||dx||
    if normB < 1
        error_est = (normB / (1 - normB)) * delta;
        if error_est < epsilon
            fprintf('\nДостигнута точность %.1e по апостериорной оценке на итерации %d.\n', epsilon, k);
            converged = true;
            break;
        end
    else
        % Резервный вариант — критерий по невязке
        residual = norm(A1 * x - b1, 1);
        if residual < epsilon
            fprintf('\nДостигнута точность %.1e по невязке на итерации %d.\n', epsilon, k);
            converged = true;
            break;
        end
    end
end

if ~converged
    fprintf('\nНе удалось достичь точности за %d итераций.\n', max_iter);
end

x_simple = x;
R_simple = A * x_simple - b;  % обратно к исходной A и b
fprintf('\nРешение (простая итерация):\n');
fprintf('x* = [%.6f, %.6f, %.6f, %.6f]\n', x_simple);
fprintf('Невязка (исходная система): %.2e\n\n', norm(R_simple, 1));

% === МЕТОД ЗЕЙДЕЛЯ ===
fprintf('=== МЕТОД ЗЕЙДЕЛЯ ===\n');

% Начальное приближение
x = zeros(n, 1);
fprintf('\n%4s %12s %12s %12s %12s %12s\n', ...
    'k', 'x1', 'x2', 'x3', 'x4', '||dx||_1');
fprintf('%4d %12.6f %12.6f %12.6f %12.6f\n', 0, x);

converged = false;
for k = 1:max_iter
    x_prev = x;

    % Последовательное обновление по формуле Зейделя
    for i = 1:n
        sum1 = A1(i, 1:i-1) * x(1:i-1);     % уже обновлённые
        sum2 = A1(i, i+1:end) * x_prev(i+1:end); % старые
        x(i) = (b1(i) - sum1 - sum2) / A1(i, i);
    end

    dx = x - x_prev;
    delta = norm(dx, 1);

    fprintf('%4d %12.6f %12.6f %12.6f %12.6f %12.2e\n', ...
        k, x(1), x(2), x(3), x(4), delta);

    % Критерий останова — по невязке (надёжно)
    residual = norm(A1 * x - b1, 1);
    if residual < epsilon
        fprintf('\nДостигнута точность %.1e по невязке на итерации %d.\n', epsilon, k);
        converged = true;
        break;
    end
end

if ~converged
    fprintf('\nНе удалось достичь точности за %d итераций.\n', max_iter);
end

x_seidel = x;
R_seidel = A * x_seidel - b;
fprintf('\nРешение (метод Зейделя):\n');
fprintf('\nR_seidel:\n', R_seidel);
fprintf('x* = [%.6f, %.6f, %.6f, %.6f]\n', x_seidel);
fprintf('Невязка (исходная система): %.2e\n\n', norm(R_seidel, 1));

% === СРАВНЕНИЕ ===
fprintf('=== СРАВНЕНИЕ РЕЗУЛЬТАТОВ ===\n');
fprintf('Прямое решение:        [%.6f, %.6f, %.6f, %.6f]\n', x_direct);
fprintf('Простая итерация:      [%.6f, %.6f, %.6f, %.6f]\n', x_simple);
fprintf('Метод Зейделя:         [%.6f, %.6f, %.6f, %.6f]\n', x_seidel);
fprintf('\nНевязки (||Ax - b||_1):\n');
fprintf('  Прямое:      %.2e\n', norm(A*x_direct - b, 1));
fprintf('  Итерация:    %.2e\n', norm(R_simple, 1));
fprintf('  Зейдель:     %.2e\n', norm(R_seidel, 1));
