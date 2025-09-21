clear all; clc;

% Твои результаты из предыдущих задач
x_simple = 0.754861;    % Задача 1
x_mod = 0.754880;       % Задача 2
x_newton = 0.754878;    % Задача 3

% Эталонный результат fzero
f = @(x) sqrt(x + 1) - 1 ./ x;
x_fzero = fzero(f, 0.6);

% Вывод сравнения
fprintf('Сравнение с fzero (эталон):\n');
fprintf('Метод                | Корень     | Отклонение\n');
fprintf('---------------------------------------------\n');
fprintf('fzero                | %.6f  | -\n', x_fzero);
fprintf('Простая итерация     | %.6f  | %+.2e\n', x_simple, x_simple - x_fzero);
fprintf('Мод. итерация        | %.6f  | %+.2e\n', x_mod, x_mod - x_fzero);
fprintf('Ньютон               | %.6f  | %+.2e\n', x_newton, x_newton - x_fzero);
