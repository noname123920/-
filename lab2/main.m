clc;
A = [-7   2  40   0;
      9  -5   0  50;
     25   0   4  -1;
      0  32   0   9];
b = [21; -14; 13; 21];

x_exact = b \ A;
disp('Точное решение:');
disp(x_exact);

% Исходная система: A * x = b
% Цель: преобразовать к виду x = B*x + c для итерационных методов

% Разложение матрицы A = M - N
% Для метода Якоби:
% M = диагональная часть матрицы A
% N = M - A

M = diag(diag(A));       % Диагональная часть матрицы A
N = M - A;               % N = M - A

% Преобразование уравнения:
% A * x = b
% (M - N) * x = b
% M * x - N * x = b
% M * x = N * x + b
% x = M^(-1) * N * x + M^(-1) * b

% Получаем вид x = B*x + c:
B_jacobi = M \ N;        % B = M^(-1) * N
c_jacobi = M \ b;        % c = M^(-1) * b

% Проверка эквивалентности:
% x = B*x + c
% x = (M^(-1)*N)*x + M^(-1)*b
% Умножаем слева на M:
% M*x = N*x + b
% M*x - N*x = b
% (M - N)*x = b
% A*x = b  ✓

disp('Матрица B (Якоби):');
disp(B_jacobi);
disp('Вектор c (Якоби):');
disp(c_jacobi);


% Нормы вектора c
c_norm_1 = norm(c_jacobi, 1);
c_norm_2 = norm(c_jacobi, 2);
c_norm_inf = norm(c_jacobi, inf);

disp('Нормы вектора c:');
disp(['1-норма: ', num2str(c_norm_1)]);
disp(['2-норма: ', num2str(c_norm_2)]);
disp(['inf-норма: ', num2str(c_norm_inf)]);

% Нормы матрицы B
B_norm_1 = norm(B_jacobi, 1);
B_norm_2 = norm(B_jacobi, 2);
B_norm_inf = norm(B_jacobi, inf);
B_norm_fro = norm(B_jacobi, 'fro');

disp('Нормы матрицы B:');
disp(['1-норма: ', num2str(B_norm_1)]);
disp(['2-норма: ', num2str(B_norm_2)]);
disp(['inf-норма: ', num2str(B_norm_inf)]);
disp(['Фробениуса: ', num2str(B_norm_fro)]);

% Нормы вектора b
b_norm_1 = norm(b, 1);
b_norm_2 = norm(b, 2);
b_norm_inf = norm(b, inf);

disp('Нормы вектора b:');
disp(['1-норма: ', num2str(b_norm_1)]);
disp(['2-норма: ', num2str(b_norm_2)]);
disp(['inf-норма: ', num2str(b_norm_inf)]);
