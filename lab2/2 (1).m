% Очистка и подготовка
clear; clc;

% Исходные данные варианта 7
A = [-9 4 64 0; 10 50 0 -4; 0 -14 7 80; 40 9 0 0];
b = [24; -5; 14; 29];

% 1. Решение прямым методом
x_direct = A \ b;
fprintf('Прямое решение: x = [%.6f, %.6f, %.6f, %.6f]\n\n', x_direct);

% 2. Приведение к диагональному преобладанию
A1 = A; b1 = b;
% Переставляем строки для лучшего диагонального преобладания
A1 = A1([4,2,1,3], :);
b1 = b1([4,2,1,3]);

fprintf('Матрица после перестановки:\n');
disp(A1);
fprintf('Вектор b после перестановки:\n');
disp(b1);

% 3. Проверка решения после перестановки
x_check = A1 \ b1;
fprintf('Решение после перестановки: x = [%.6f, %.6f, %.6f, %.6f]\n', x_check);
fprintf('Норма разности решений: %.2e\n\n', norm(x_direct - x_check));

% 4. Метод простой итерации
fprintf('=== МЕТОД ПРОСТОЙ ИТЕРАЦИИ ===\n');

% Параметры
epsilon = 1e-4;
max_iter = 100;
n = length(b1);

% Начальное приближение
x = zeros(n, 1);
x_prev = x;

% Приведение к виду x = B*x + c
D = diag(diag(A1));
B = eye(n) - D\A1;
c = D\b1;

fprintf('Матрица B:\n');
disp(B);
fprintf('Норма матрицы B: %.6f\n', norm(B, inf));

% Таблица итераций
fprintf('\n%4s %12s %12s %12s %12s %12s %12s\n', ...
        'Iter', 'x1', 'x2', 'x3', 'x4', 'Delta', 'Criterion');
fprintf('%4d %12.6f %12.6f %12.6f %12.6f\n', 0, x);

for k = 1:max_iter
    x_prev = x;
    x = B * x + c;

    delta = norm(x - x_prev, inf);
    criterion = (1 - norm(B, inf)) * epsilon / norm(B, inf);

    fprintf('%4d %12.6f %12.6f %12.6f %12.6f %12.2e %12.2e\n', ...
            k, x(1), x(2), x(3), x(4), delta, criterion);

    if delta < epsilon
        fprintf('\nТочность достигнута на итерации %d\n', k);
        break;
    end
end

disp(criterion);

% 6. Решение и невязка
x_simple = x;
R_simple = A * x_simple - b;
fprintf('\nРешение методом простой итерации:\n');
fprintf('x = [%.6f, %.6f, %.6f, %.6f]\n', x_simple);
fprintf('Невязка R = Ax - b: [%.2e, %.2e, %.2e, %.2e]\n', R_simple);
fprintf('Норма невязки: %.2e\n\n', norm(R_simple));

% Метод Зейделя
fprintf('=== МЕТОД ЗЕЙДЕЛЯ ===\n');

% Начальное приближение
x = zeros(n, 1);
x_prev = x;

% Разложение матрицы B = B1 + B2 (нижняя и верхняя треугольные части)
B1 = tril(B, -1);  % Нижняя треугольная часть (без диагонали)
B2 = triu(B, 1);   % Верхняя треугольная часть (без диагонали)

fprintf('Матрица B1 (нижняя треугольная):\n');
disp(B1);
fprintf('Матрица B2 (верхняя треугольная):\n');
disp(B2);

% Таблица итераций
fprintf('\n%4s %12s %12s %12s %12s %12s %12s\n', ...
        'Iter', 'x1', 'x2', 'x3', 'x4', 'Delta', 'Criterion');
fprintf('%4d %12.6f %12.6f %12.6f %12.6f\n', 0, x);

for k = 1:max_iter
    x_prev = x;

    % Метод Зейделя: последовательное обновление компонент
    for i = 1:n
        sum1 = 0;
        for j = 1:i-1
            sum1 = sum1 + B1(i,j) * x(j);
        end

        sum2 = 0;
        for j = i+1:n
            sum2 = sum2 + B2(i,j) * x_prev(j);
        end

        x(i) = sum1 + sum2 + c(i);
    end

    delta = norm(x - x_prev, inf);
    criterion = (1 - norm(B2, inf)) * epsilon / norm(B2, inf);

    fprintf('%4d %12.6f %12.6f %12.6f %12.6f %12.2e %12.2e\n', ...
            k, x(1), x(2), x(3), x(4), delta, criterion);

    if delta < epsilon
        fprintf('\nТочность достигнута на итерации %d\n', k);
        break;
    end
end

% Решение и невязка
x_seidel = x;
R_seidel = A * x_seidel - b;
fprintf('\nРешение методом Зейделя:\n');
fprintf('x = [%.6f, %.6f, %.6f, %.6f]\n', x_seidel);
fprintf('Невязка R = Ax - b: [%.2e, %.2e, %.2e, %.2e]\n', R_seidel);
fprintf('Норма невязки: %.2e\n\n', norm(R_seidel));

% Сравнение методов
fprintf('=== СРАВНЕНИЕ МЕТОДОВ ===\n');
fprintf('Прямое решение:        x = [%.6f, %.6f, %.6f, %.6f]\n', x_direct);
fprintf('Простая итерация:      x = [%.6f, %.6f, %.6f, %.6f]\n', x_simple);
fprintf('Метод Зейделя:         x = [%.6f, %.6f, %.6f, %.6f]\n', x_seidel);

fprintf('\nНевязки:\n');
fprintf('Простая итерация: %.2e\n', norm(R_simple));
fprintf('Метод Зейделя:    %.2e\n', norm(R_seidel));
